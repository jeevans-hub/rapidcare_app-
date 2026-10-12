const { test, before, after, beforeEach } = require('node:test');
const assert = require('node:assert/strict');
const mongoose = require('mongoose');
const { MongoMemoryReplSet } = require('mongodb-memory-server');

// Tests always use a disposable local replica set, never the application's .env database.
process.env.NODE_ENV = 'test';
process.env.JWT_SECRET = 'rapidcare-regression-test-secret';
process.env.MONGODB_URI = 'mongodb://127.0.0.1/unused';
process.env.API_PREFIX = '/api/v1';
const app = require('../src/app');
const User = require('../src/models/User');
const Medicine = require('../src/models/Medicine');
const Cart = require('../src/models/Cart');
const Order = require('../src/models/Order');
const Doctor = require('../src/models/Doctor');
const Appointment = require('../src/models/Appointment');
const jwt = require('jsonwebtoken');

let replicaSet;
let server;
let baseUrl;
let users;

before(async () => {
  replicaSet = await MongoMemoryReplSet.create({ replSet: { count: 1 } });
  await mongoose.connect(replicaSet.getUri());
  await Promise.all(Object.values(mongoose.models).map(model => model.init()));
  server = await new Promise(resolve => {
    const listening = app.listen(0, '127.0.0.1', () => resolve(listening));
  });
  baseUrl = `http://127.0.0.1:${server.address().port}/api/v1`;
}, { timeout: 180000 });

after(async () => {
  if (server) await new Promise(resolve => server.close(resolve));
  await mongoose.disconnect();
  if (replicaSet) await replicaSet.stop();
});

beforeEach(async () => {
  await Promise.all(Object.values(mongoose.models).map(model => model.deleteMany({})));
  users = await User.create([
    { name: 'First', email: 'first@example.test', password: 'test-password' },
    { name: 'Second', email: 'second@example.test', password: 'test-password' },
  ]);
});

async function request(path, { user, body, method = 'POST' } = {}) {
  const response = await fetch(baseUrl + path, {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...(user ? { Authorization: `Bearer ${jwt.sign({ userId: user.id }, process.env.JWT_SECRET)}` } : {}),
    },
    ...(body !== undefined ? { body: JSON.stringify(body) } : {}),
  });
  return { status: response.status, body: await response.json() };
}

async function medicine(stock = 1) {
  return Medicine.create({ name: 'Test item', category: 'General', price: 10, stock });
}

async function cart(user, items) {
  return Cart.create({ user: user.id, items: items.map(item => ({ medicine: item.id, quantity: 1, priceAtAdd: item.price })) });
}

test('malformed authentication fields return 400 instead of 500', async () => {
  const valid = { name: 'Test', email: 'test@example.test', password: 'test-password' };
  for (const body of [
    { ...valid, name: 123 }, { ...valid, email: 123 },
    { ...valid, password: {} }, { ...valid, phone: 123 },
    { ...valid, dateOfBirth: {} }, { ...valid, dateOfBirth: 'invalid' },
    { ...valid, email: 'invalid' },
  ]) {
    assert.equal((await request('/auth/register', { body })).status, 400);
  }
  for (const body of [{ email: 123, password: 'test-password' }, { email: valid.email, password: {} }]) {
    assert.equal((await request('/auth/login', { body })).status, 400);
  }
  assert.equal(await User.countDocuments(), 2);
});

test('login normalizes email whitespace and case', async () => {
  assert.equal((await request('/auth/login', { body: { email: ' FIRST@EXAMPLE.TEST ', password: 'test-password' } })).status, 200);
});

test('concurrent checkouts cannot oversell the last item', async () => {
  const item = await medicine();
  await Promise.all(users.map(user => cart(user, [item])));
  const results = await Promise.all(users.map(user => request('/orders', { user, body: {} })));
  assert.deepEqual(results.map(result => result.status).sort(), [201, 409]);
  assert.equal((await Medicine.findById(item.id)).stock, 0);
  assert.equal(await Order.countDocuments(), 1);
  assert.equal(await Cart.countDocuments({ 'items.0': { $exists: true } }), 1);
});

test('concurrent checkout of the same cart creates only one order', async () => {
  const item = await medicine(3);
  await cart(users[0], [item]);
  const results = await Promise.all([0, 1].map(() => request('/orders', { user: users[0], body: {} })));
  assert.deepEqual(results.map(result => result.status).sort(), [201, 400]);
  assert.equal(await Order.countDocuments(), 1);
  assert.equal((await Medicine.findById(item.id)).stock, 2);
});

test('a later stock failure rolls back earlier reservations and preserves the cart', async () => {
  const first = await medicine();
  const second = await medicine(0);
  await cart(users[0], [first, second]);
  assert.equal((await request('/orders', { user: users[0], body: {} })).status, 409);
  assert.equal((await Medicine.findById(first.id)).stock, 1);
  assert.equal(await Order.countDocuments(), 0);
  assert.equal((await Cart.findOne({ user: users[0].id })).items.length, 2);
});

test('order validation failure rolls back inventory changes', async () => {
  const item = await medicine();
  await cart(users[0], [item]);
  assert.equal((await request('/orders', { user: users[0], body: { notes: 'x'.repeat(1001) } })).status, 400);
  assert.equal((await Medicine.findById(item.id)).stock, 1);
  assert.equal(await Order.countDocuments(), 0);
  assert.equal((await Cart.findOne({ user: users[0].id })).items.length, 1);
});

test('concurrent cancellations restore inventory only once', async () => {
  const item = await medicine();
  await cart(users[0], [item]);
  const placed = await request('/orders', { user: users[0], body: {} });
  assert.equal(placed.status, 201);
  const path = `/orders/${placed.body.data.order._id}/cancel`;
  const results = await Promise.all([0, 1].map(() => request(path, { user: users[0], method: 'PATCH', body: {} })));
  assert.deepEqual(results.map(result => result.status).sort(), [200, 400]);
  assert.equal((await Medicine.findById(item.id)).stock, 1);
});

test('another user cannot cancel an order or restore its stock', async () => {
  const item = await medicine();
  await cart(users[0], [item]);
  const placed = await request('/orders', { user: users[0], body: {} });
  const result = await request(`/orders/${placed.body.data.order._id}/cancel`, { user: users[1], method: 'PATCH', body: {} });
  assert.equal(result.status, 403);
  assert.equal((await Medicine.findById(item.id)).stock, 0);
});

async function doctor() {
  return Doctor.create({ name: 'Doctor', specialty: 'General Medicine', qualification: 'MBBS', experienceYears: 5, hospital: 'Test', consultationFee: 10, availableDays: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'] });
}

test('concurrent bookings return one success and one conflict; cancellation releases the slot', async () => {
  const clinician = await doctor();
  const date = new Date();
  date.setDate(date.getDate() + 2);
  const body = { doctorId: clinician.id, appointmentDate: date.toISOString(), timeSlot: '09:00 AM' };
  const results = await Promise.all(users.map(user => request('/appointments', { user, body })));
  assert.deepEqual(results.map(result => result.status).sort(), [201, 409]);
  const booked = await Appointment.findOne();
  const owner = users.find(user => user.id === booked.user.toString());
  assert.equal((await request(`/appointments/${booked.id}/cancel`, { user: owner, method: 'PATCH', body: {} })).status, 200);
  assert.equal((await request('/appointments', { user: users[0], body })).status, 201);
});

test('the database rejects duplicate active slots even when writes bypass the controller', async () => {
  const clinician = await doctor();
  const slot = { doctor: clinician.id, appointmentDate: new Date('2030-01-01'), timeSlot: '09:00 AM', user: users[0].id };
  await Appointment.create({ ...slot, status: 'completed' });
  await assert.rejects(Appointment.create({ ...slot, user: users[1].id }), error => error.code === 11000);
  await Appointment.create({ ...slot, status: 'cancelled' });
});

test('doctor list and details expose the same MongoDB identity', async () => {
  const clinician = await doctor();
  const list = await request('/doctors', { method: 'GET' });
  assert.equal(list.status, 200);
  assert.equal(list.body.data.doctors[0]._id, clinician.id);
  const details = await request(`/doctors/${list.body.data.doctors[0]._id}`, { method: 'GET' });
  assert.equal(details.status, 200);
  assert.equal(details.body.data.doctor._id, clinician.id);
  assert.deepEqual(details.body.data.doctor.availableSlots, list.body.data.doctors[0].availableSlots);
  assert.equal((await request('/doctors/invalid', { method: 'GET' })).status, 400);
  assert.equal((await request(`/doctors/${new mongoose.Types.ObjectId()}`, { method: 'GET' })).status, 404);
});

test('invalid booking requests are rejected without persisting appointments', async () => {
  const clinician = await doctor();
  const valid = { doctorId: clinician.id, appointmentDate: '2030-01-15', timeSlot: '09:00 AM' };
  for (const body of [
    {}, { ...valid, doctorId: '' }, { ...valid, doctorId: 123 },
    { ...valid, appointmentDate: '2020-01-01' }, { ...valid, appointmentDate: 'not-a-date' },
    { ...valid, appointmentDate: ['2030-01-15'] }, { ...valid, appointmentDate: '2030-02-30' },
    { ...valid, timeSlot: '' }, { ...valid, timeSlot: {} }, { ...valid, timeSlot: '99:99 AM' },
    { ...valid, reason: {} },
  ]) {
    assert.equal((await request('/appointments', { user: users[0], body })).status, 400);
  }
  assert.equal((await request('/appointments', { body: valid })).status, 401);
  assert.equal(await Appointment.countDocuments(), 0);
});

test('booking persists the selected doctor and day, and history is scoped to its owner', async () => {
  const clinician = await doctor();
  const body = { doctorId: clinician.id, appointmentDate: '2030-01-15', timeSlot: '09:00 AM' };
  const created = await request('/appointments', { user: users[0], body });
  assert.equal(created.status, 201);
  const id = created.body.data.appointment._id;
  assert.equal(created.body.data.appointment.doctor._id, clinician.id);
  const persisted = await Appointment.findById(id);
  assert.equal(persisted.user.toString(), users[0].id);
  assert.equal(persisted.doctor.toString(), clinician.id);
  assert.equal(persisted.appointmentDate.getDate(), 15);
  const ownHistory = await request('/appointments', { user: users[0], method: 'GET' });
  assert.equal(ownHistory.status, 200);
  assert.equal(ownHistory.body.data.appointments[0]._id, id);
  const otherHistory = await request('/appointments', { user: users[1], method: 'GET' });
  assert.deepEqual(otherHistory.body.data.appointments, []);
  assert.equal((await request(`/appointments/${id}`, { user: users[1], method: 'GET' })).status, 404);
  assert.equal((await request('/appointments', { user: users[0], body })).status, 409);
  assert.equal((await request(`/appointments/${id}/reschedule`, { user: users[0], method: 'PATCH', body: { appointmentDate: [], timeSlot: '09:00 AM' } })).status, 400);
});

const seedDoctors = require('../src/seed/doctorSeed');
const { parseDay, scheduledSlots } = require('../src/utils/doctorSchedule');
function futureDay(doctor, scheduled = true) {
  for (let i = 1; i < 15; i++) {
    const date = new Date(Date.now() + i * 86400000);
    const day = date.toISOString().slice(0, 10);
    const weekday = new Intl.DateTimeFormat('en', { weekday: 'long', timeZone: 'UTC' }).format(parseDay(day));
    if (doctor.availableDays.includes(weekday) === scheduled) return day;
  }
}
test('20 demo profiles: idempotent upserts, exact API data, search, filters and availability', async () => {
  assert.equal((await seedDoctors()).activeDemoDoctors, 20);
  const first = await Doctor.find({ isDemo: true }).sort('demoKey').lean();
  await Doctor.updateOne({ _id: first[0]._id }, { consultationFee: 1 });
  await seedDoctors();
  const list = (await request('/doctors', { method: 'GET' })).body.data;
  assert.equal(list.doctors.length, 20);
  assert.equal(new Set(list.doctors.map(d => d.demoKey)).size, 20);
  assert.equal(list.specialties.length, 20);
  assert.deepEqual(list.doctors.map(d => d.consultationFee), [500,1000,750,850,650,1100,650,700,950,1000,900,800,1000,950,1050,600,900,1200,800,550]);
  for (const [i, d] of list.doctors.entries()) {
    assert.equal(d._id, first[i]._id.toString());
    assert.equal(d.demoKey, 'RC-D' + String(i + 1).padStart(3, '0'));
    const details = await request('/doctors/' + d._id, { method: 'GET' });
    assert.deepEqual(details.body.data.doctor, d);
    assert.equal(d.isDemo, true); assert.equal(d.contactStatus, 'demo-only');
    assert.equal(d.contactPhone, null); assert.match(d.contactEmail, /@rapidcare\.example$/);
    assert.equal(d.qualification, null); assert.equal(d.experienceYears, null);
    assert.equal(d.rating, 0); assert.equal(d.reviewCount, 0); assert.equal(d.profileImageUrl, null);
    const date = futureDay(d);
    const availability = await request('/doctors/' + d._id + '/availability?date=' + date, { method: 'GET' });
    assert.deepEqual(availability.body.data.slots, d.availableSlots);
    assert.equal(availability.body.data.slots.length, 6);
    assert.equal(availability.body.data.timeZone, 'Asia/Kolkata');
    assert.deepEqual((await request('/doctors/' + d._id + '/availability?date=' + futureDay(d, false), { method: 'GET' })).body.data.slots, []);
    const filter = await request('/doctors?specialty=' + encodeURIComponent(d.specialty), { method: 'GET' });
    assert.deepEqual(filter.body.data.doctors.map(x => x._id), [d._id]);
    const search = await request('/doctors?search=' + encodeURIComponent(d.name), { method: 'GET' });
    assert.deepEqual(search.body.data.doctors.map(x => x._id), [d._id]);
  }
  assert.equal((await request('/doctors?search=Cardiology', { method: 'GET' })).body.data.doctors.length, 1);
  assert.equal((await request('/doctors?search=%5B', { method: 'GET' })).status, 200);
  assert.equal((await request('/doctors/invalid/availability?date=invalid', { method: 'GET' })).status, 400);
});

const originalLegacyDoctors = [{"name":"Dr. Sarah Johnson","specialty":"Cardiology","qualification":"MBBS, MD","experienceYears":12,"hospital":"City General Hospital","location":"New York","consultationFee":600,"rating":4.8,"reviewCount":234,"about":"Dr. Sarah Johnson is a highly experienced cardiologist with over 12 years of experience in treating heart conditions. She specializes in interventional cardiology and has successfully treated thousands of patients.","languages":["English","Spanish"],"availableDays":["Monday","Tuesday","Wednesday","Thursday","Friday"],"availableSlots":["09:00 AM","09:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","02:00 PM","02:30 PM","03:00 PM","03:30 PM","04:00 PM","04:30 PM"],"isAvailable":true},{"name":"Dr. Michael Lee","specialty":"Dermatology","qualification":"MBBS, MD","experienceYears":8,"hospital":"St. Mary's Medical Center","location":"Los Angeles","consultationFee":500,"rating":4.6,"reviewCount":189,"about":"Dr. Michael Lee specializes in dermatology with expertise in treating various skin conditions. He is known for his patient-centered approach and effective treatments.","languages":["English","Mandarin"],"availableDays":["Monday","Wednesday","Friday"],"availableSlots":["10:00 AM","11:00 AM","02:00 PM","03:00 PM","04:00 PM"],"isAvailable":true},{"name":"Dr. Emily Brown","specialty":"Orthopedics","qualification":"MBBS, MS","experienceYears":15,"hospital":"Riverside Clinic","location":"Chicago","consultationFee":700,"rating":4.9,"reviewCount":312,"about":"Dr. Emily Brown is an orthopedic surgeon with 15 years of experience. She specializes in joint replacement and sports medicine.","languages":["English"],"availableDays":["Tuesday","Thursday","Saturday"],"availableSlots":["09:00 AM","11:00 AM","01:00 PM","03:00 PM"],"isAvailable":true},{"name":"Dr. David Wilson","specialty":"Neurology","qualification":"MBBS, MD","experienceYears":10,"hospital":"City General Hospital","location":"New York","consultationFee":650,"rating":4.7,"reviewCount":156,"about":"Dr. David Wilson is a neurologist specializing in neurological disorders. He has extensive experience in diagnosing and treating conditions affecting the nervous system.","languages":["English","French"],"availableDays":["Monday","Tuesday","Thursday","Friday"],"availableSlots":["09:30 AM","10:30 AM","11:30 AM","02:30 PM","03:30 PM"],"isAvailable":true},{"name":"Dr. Jennifer Martinez","specialty":"Pediatrics","qualification":"MBBS, MD","experienceYears":7,"hospital":"Children's Hospital","location":"Houston","consultationFee":450,"rating":4.5,"reviewCount":98,"about":"Dr. Jennifer Martinez is a pediatrician dedicated to providing comprehensive care for children. She specializes in preventive care and childhood development.","languages":["English","Spanish"],"availableDays":["Monday","Wednesday","Friday"],"availableSlots":["09:00 AM","10:00 AM","11:00 AM","02:00 PM","03:00 PM"],"isAvailable":true},{"name":"Dr. Robert Chen","specialty":"General Medicine","qualification":"MBBS, MD","experienceYears":20,"hospital":"Metro Medical Center","location":"San Francisco","consultationFee":400,"rating":4.6,"reviewCount":278,"about":"Dr. Robert Chen is a general practitioner with 20 years of experience. He provides comprehensive primary care services and focuses on preventive medicine.","languages":["English","Mandarin","Cantonese"],"availableDays":["Monday","Tuesday","Wednesday","Thursday","Friday"],"availableSlots":["08:00 AM","09:00 AM","10:00 AM","11:00 AM","02:00 PM","03:00 PM","04:00 PM"],"isAvailable":true},{"name":"Dr. Amanda White","specialty":"Gynecology","qualification":"MBBS, MD","experienceYears":11,"hospital":"Women's Health Center","location":"Boston","consultationFee":550,"rating":4.7,"reviewCount":201,"about":"Dr. Amanda White specializes in gynecology and women's health. She provides comprehensive care for women of all ages.","languages":["English"],"availableDays":["Tuesday","Thursday","Saturday"],"availableSlots":["09:00 AM","10:30 AM","12:00 PM","02:30 PM","04:00 PM"],"isAvailable":true},{"name":"Dr. James Anderson","specialty":"ENT","qualification":"MBBS, MS","experienceYears":9,"hospital":"City General Hospital","location":"New York","consultationFee":480,"rating":4.4,"reviewCount":145,"about":"Dr. James Anderson is an ENT specialist treating ear, nose, and throat conditions. He has expertise in both medical and surgical treatments.","languages":["English","German"],"availableDays":["Monday","Wednesday","Friday"],"availableSlots":["10:00 AM","11:30 AM","02:00 PM","03:30 PM"],"isAvailable":true}];

test('retire only exact legacy seeds; preserve IDs, appointments and edited/user-created doctors', async () => {
  const old = await Doctor.create(originalLegacyDoctors);
  const custom = await doctor();
  const edited = await Doctor.create({ ...originalLegacyDoctors[0], about: 'User edited this profile' });
  const appointment = await Appointment.create({ doctor: old[0]._id, user: users[0]._id, appointmentDate: new Date('2030-01-15'), timeSlot: '09:00 AM' });
  const result = await seedDoctors();
  assert.equal(result.retired, 8); assert.equal(result.activeDemoDoctors, 20); assert.equal(result.unrecognizedLegacyCount, 1);
  assert.equal(await Doctor.countDocuments(), 30);
  assert.equal((await Doctor.findById(custom.id)).isActive, true);
  assert.equal((await Doctor.findById(edited.id)).isActive, true);
  const preserved = await Appointment.findById(appointment.id).populate('doctor');
  assert.equal(preserved.doctor.id, old[0].id); assert.equal(preserved.doctor.name, old[0].name);
  assert.equal((await request('/appointments/' + appointment.id, { user: users[0], method: 'GET' })).status, 200);
  await seedDoctors(); assert.equal(await Appointment.countDocuments(), 1);
});
test('demo booking enforces schedules, future IST slots, server fee, conflict and owner privacy', async () => {
  await seedDoctors();
  const d = await Doctor.findOne({ demoKey: 'RC-D001' });
  const date = futureDay(d);
  const body = { doctorId: d.id, appointmentDate: date, timeSlot: d.availableSlots[0], consultationFee: 1, isDemo: false };
  assert.equal((await request('/appointments', { body })).status, 401);
  for (const invalid of [{ appointmentDate: futureDay(d, false) }, { timeSlot: '12:00 PM' }, { timeSlot: '09:15 AM' }, { appointmentDate: '2020-01-01' }]) {
    assert.equal((await request('/appointments', { user: users[0], body: { ...body, ...invalid } })).status, 400);
  }
  const results = await Promise.all(users.map(user => request('/appointments', { user, body })));
  assert.deepEqual(results.map(r => r.status).sort(), [201, 409]);
  const a = results.find(r => r.status === 201).body.data.appointment;
  assert.equal(a.consultationFee, 500); assert.equal(a.isDemo, true); assert.equal(a.appointmentDay, date);
  assert.equal(a.appointmentDate, date + 'T00:00:00.000Z');
  const owner = users.find(u => u.id === a.user); const other = users.find(u => u.id !== a.user);
  assert.deepEqual((await request('/appointments', { user: other, method: 'GET' })).body.data.appointments, []);
  for (const [suffix, method] of [['', 'GET'], ['/cancel', 'PATCH'], ['/reschedule', 'PATCH']]) {
    assert.equal((await request('/appointments/' + a._id + suffix, { user: other, method, ...(method === 'PATCH' ? { body } : {}) })).status, 404);
  }
  assert.equal((await request('/appointments/' + a._id + '/reschedule', { user: owner, method: 'PATCH', body: { appointmentDate: futureDay(d, false), timeSlot: body.timeSlot } })).status, 400);
  const slots = (await request('/doctors/' + d.id + '/availability?date=' + date, { method: 'GET' })).body.data.slots;
  assert.equal(slots.includes(body.timeSlot), false);
  assert.equal(slots.length, 5);
});
test('IST slot boundary is independent of host timezone and excludes elapsed same-day slots', () => {
  const d = seedDoctors.demoDoctors[0]; // Monday 09:00–12:00 IST
  const date = parseDay('2030-01-14');
  assert.equal(scheduledSlots(d, date, new Date('2030-01-14T03:29:59Z')).length, 6);
  assert.equal(scheduledSlots(d, date, new Date('2030-01-14T03:30:00Z')).includes('09:00 AM'), false);
  assert.equal(scheduledSlots(d, date, new Date('2030-01-14T06:00:00Z')).length, 0);
  assert.equal(parseDay('2030-02-30'), null);
});
test('production seeding is refused before any write', async () => {
  process.env.NODE_ENV = 'production';
  try { await assert.rejects(seedDoctors(), /disabled in production/); }
  finally { process.env.NODE_ENV = 'test'; }
  assert.equal(await Doctor.countDocuments(), 0);
});

test('pharmacy catalog search, category, availability and IDs are consistent', async () => {
  await require('../src/seed/medicineSeed')();
  const list = await request('/medicines', { method: 'GET' });
  assert.equal(list.status, 200);
  assert.ok(list.body.data.medicines.length > 6);
  const item = list.body.data.medicines[0];
  assert.equal((await request('/medicines/'+item._id, {method:'GET'})).body.data.medicine.name, item.name);
  for (const search of [item.name, item.category]) {
    const result = await request('/medicines?search='+encodeURIComponent(search), {method:'GET'});
    assert.ok(result.body.data.medicines.some(m => m._id === item._id));
  }
  assert.equal((await request('/medicines?search=%5B', {method:'GET'})).status, 200);
  const filtered = await request('/medicines?category='+encodeURIComponent(item.category), {method:'GET'});
  assert.ok(filtered.body.data.medicines.every(m => m.category === item.category));
  assert.equal((await request('/medicines/invalid', {method:'GET'})).status, 400);
  assert.equal((await request('/medicines/'+new mongoose.Types.ObjectId(), {method:'GET'})).status, 404);
});

test('cart CRUD, concurrent adds, current catalog prices and ownership', async () => {
  const item = await medicine(20);
  assert.equal((await request('/cart', {method:'GET'})).status, 401);
  assert.equal((await request('/orders', {body:{}})).status, 401);
  const add = () => request('/cart/items', {user:users[0], body:{medicineId:item.id, quantity:1, price:0, user:users[1].id}});
  await request('/cart', {user:users[0], method:'GET'});
  assert.ok((await Promise.all([add(),add(),add()])).every(r=>r.status===200));
  let result = await request('/cart', {user:users[0],method:'GET'});
  assert.equal(result.body.data.cart.items.length,1);
  assert.equal(result.body.data.cart.items[0].quantity,3);
  await Medicine.updateOne({_id:item.id},{$set:{price:12.34}});
  result = await request('/cart', {user:users[0],method:'GET'});
  assert.equal(result.body.data.cart.subtotal,37.02);
  assert.equal(result.body.data.cart.total,40.01);
  assert.equal((await request('/cart',{user:users[1],method:'GET'})).body.data.cart.items.length,0);
  assert.equal((await request('/cart/items/'+item.id,{user:users[1],method:'PATCH',body:{quantity:2}})).status,404);
  assert.equal((await request('/cart/items/'+item.id,{user:users[0],method:'PATCH',body:{quantity:2}})).status,200);
  assert.equal((await request('/cart/items/'+item.id,{user:users[0],method:'DELETE'})).status,200);
  await add();
  assert.equal((await request('/cart',{user:users[0],method:'DELETE'})).body.data.cart.items.length,0);
});

test('invalid, excessive, out-of-stock and unavailable cart quantities are rejected', async () => {
  const item = await medicine(2);
  for (const quantity of [-1,0,1.5,'2',3,Number.MAX_SAFE_INTEGER+1]) {
    assert.equal((await request('/cart/items',{user:users[0],body:{medicineId:item.id,quantity}})).status,400);
  }
  assert.equal((await request('/cart/items',{user:users[0],body:{medicineId:'invalid'}})).status,400);
  await Medicine.updateOne({_id:item.id},{$set:{stock:0}});
  assert.equal((await request('/cart/items',{user:users[0],body:{medicineId:item.id}})).status,400);
  await Medicine.updateOne({_id:item.id},{$set:{stock:2,isAvailable:false}});
  assert.equal((await request('/cart/items',{user:users[0],body:{medicineId:item.id}})).status,400);
});

test('checkout uses current prices, replays a submission key, persists history and isolates users', async () => {
  const item = await medicine(5);
  await cart(users[0],[item]);
  await Medicine.updateOne({_id:item.id},{$set:{price:14.25}});
  const body = {checkoutKey:'pharmacy-test-key-0001',price:0,totalAmount:0,user:users[1].id};
  const results = await Promise.all([0,1].map(()=>request('/orders',{user:users[0],body})));
  assert.ok(results.every(r=>r.status===201));
  const order = results[0].body.data.order;
  assert.equal(results[1].body.data.order._id,order._id);
  assert.equal(order.totalAmount,17.24);
  assert.equal(order.items[0].priceSnapshot,14.25);
  assert.equal(await Order.countDocuments(),1);
  assert.equal((await Medicine.findById(item.id)).stock,4);
  assert.equal((await request('/cart',{user:users[0],method:'GET'})).body.data.cart.items.length,0);
  // A replay must not consume a new cart assembled after a successful checkout.
  await request('/cart/items',{user:users[0],body:{medicineId:item.id}});
  assert.equal((await request('/orders',{user:users[0],body})).body.data.order._id,order._id);
  assert.equal((await request('/cart',{user:users[0],method:'GET'})).body.data.cart.items.length,1);
  assert.equal((await request('/orders',{user:users[0],method:'GET'})).body.data.orders[0]._id,order._id);
  assert.equal((await request('/orders',{user:users[1],method:'GET'})).body.data.orders.length,0);
  assert.equal((await request('/orders/'+order._id,{user:users[1],method:'GET'})).status,403);
  assert.equal((await request('/orders/'+order._id,{user:users[0],method:'GET'})).status,200);
});

test('prescription checkout is blocked and transaction leaves stock and cart intact', async () => {
  const first = await medicine(3), prescription = await medicine(3);
  await Medicine.updateOne({_id:prescription.id},{$set:{requiresPrescription:true}});
  await cart(users[0],[first,prescription]);
  const result = await request('/orders',{user:users[0],body:{}});
  assert.equal(result.status,400);
  assert.match(result.body.message,/Prescription/);
  assert.equal((await Medicine.findById(first.id)).stock,3);
  assert.equal((await Medicine.findById(prescription.id)).stock,3);
  assert.equal(await Order.countDocuments(),0);
  assert.equal((await Cart.findOne({user:users[0].id})).items.length,2);
});

test('failure after inventory reservation rolls back stock, order and cart', async () => {
  const item = await medicine(3);
  await cart(users[0],[item]);
  const original = Order.create;
  Order.create = async () => { throw new Error('Simulated persistence failure'); };
  try { assert.equal((await request('/orders',{user:users[0],body:{}})).status,500); }
  finally { Order.create = original; }
  assert.equal((await Medicine.findById(item.id)).stock,3);
  assert.equal(await Order.countDocuments(),0);
  assert.equal((await Cart.findOne({user:users[0].id})).items.length,1);
});

test('packed orders cannot be cancelled or restore stock', async () => {
  const item = await medicine(3); await cart(users[0],[item]);
  const created = await request('/orders',{user:users[0],body:{}});
  await Order.updateOne({_id:created.body.data.order._id},{$set:{status:'packed'}});
  assert.equal((await request('/orders/'+created.body.data.order._id+'/cancel',{user:users[0],method:'PATCH',body:{}})).status,400);
  assert.equal((await Medicine.findById(item.id)).stock,2);
});

test('medical records, notification and health metric routes retain authentication and owner scoping', async () => {
  for (const path of ['/medical-records','/notifications','/health-metrics']) {
    assert.equal((await request(path,{method:'GET'})).status,401);
    assert.equal((await request(path,{user:users[0],method:'GET'})).status,200);
  }
});
