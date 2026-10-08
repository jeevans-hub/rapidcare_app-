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
  return Doctor.create({ name: 'Doctor', specialty: 'General Medicine', qualification: 'MBBS', experienceYears: 5, hospital: 'Test', consultationFee: 10 });
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
