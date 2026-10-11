const mongoose = require('mongoose');
const crypto = require('crypto');
const Doctor = require('../models/Doctor');
const rows = require('./demoDoctors.json');
const legacy = require('./legacyDoctorFingerprints.json');
const { slotsForHours } = require('../utils/doctorSchedule');
const weekdays = { Mon: 'Monday', Tue: 'Tuesday', Wed: 'Wednesday', Thu: 'Thursday', Fri: 'Friday', Sat: 'Saturday' };
const topics = ['general consultation and routine care', 'heart health consultations', 'skin and hair consultations', 'joint and mobility consultations', 'child health consultations', 'nervous system consultations', 'ear, nose and throat consultations', 'eye health consultations', 'reproductive health consultations', 'digestive health consultations', 'hormonal health consultations', 'respiratory health consultations', 'mental health consultations', 'urinary health consultations', 'kidney health consultations', 'oral health consultations', 'joint and autoimmune condition consultations', 'oncology consultations', 'allergy and immune health consultations', 'routine family care consultations'];
const demoDoctors = rows.map(([demoKey, name, specialty, fee, days, start, end, email], i) => ({
  demoKey, name, specialty, consultationFee: Number(fee),
  isDemo: true, isActive: true, isAvailable: true,
  clinic: 'RapidCare Demo Clinic — Bengaluru', hospital: 'RapidCare Demo Clinic — Bengaluru', location: 'Bengaluru',
  timeZone: 'Asia/Kolkata', contactPhone: null, contactEmail: email, contactStatus: 'demo-only',
  qualification: null, experienceYears: null, rating: 0, reviewCount: 0, languages: [], profileImageUrl: null,
  about: `${name} is a fictional demo profile for testing ${topics[i]}. This profile does not represent a real clinician.`,
  availableDays: days.split(',').map(d => weekdays[d]), consultationStart: start, consultationEnd: end,
  slotDurationMinutes: 30, availableSlots: slotsForHours(start, end, 30),
}));

// Uses the caller's connection; never connects or deletes data implicitly.
async function seedDoctors() {
  if (process.env.NODE_ENV === 'production') throw new Error('Demo seeding is disabled in production');
  await Doctor.init();
  for (const data of demoDoctors) {
    const existing = await Doctor.findOne({ demoKey: data.demoKey });
    if (existing && !existing.isDemo) throw new Error(`Refusing to overwrite non-demo key ${data.demoKey}`);
    await Doctor.updateOne({ demoKey: data.demoKey, isDemo: true }, { $set: data }, { upsert: true, runValidators: true });
  }
  // Exact full-payload fingerprints only: matching names alone are insufficient.
  // Edited/unrecognized legacy entries remain untouched and are reported.
  let retired = 0;
  const unrecognized = [];
  for (const { name, hash } of legacy.fingerprints) {
    const candidates = await Doctor.find({ name, demoKey: { $exists: false }, isActive: { $ne: false } }).lean();
    for (const candidate of candidates) {
      const actual = crypto.createHash('sha256').update(JSON.stringify(legacy.fields.map(k => candidate[k]))).digest('hex');
      if (actual !== hash) { unrecognized.push(candidate._id.toString()); continue; }
      const fingerprintFilter = Object.fromEntries(legacy.fields.map(k => [k, candidate[k]]));
      const result = await Doctor.updateOne({ _id: candidate._id, ...fingerprintFilter }, { $set: { isActive: false, isAvailable: false, isDemo: true, contactStatus: 'demo-only', contactPhone: null } });
      retired += result.modifiedCount;
    }
  }
  return { activeDemoDoctors: await Doctor.countDocuments({ isDemo: true, isActive: true }), retired, unrecognizedLegacyCount: unrecognized.length };
}
if (require.main === module) {
  (async () => {
    if (process.env.NODE_ENV === 'production' || process.env.RAPIDCARE_DEMO_SEED !== 'true') throw new Error('Set RAPIDCARE_DEMO_SEED=true explicitly for a development/demo database');
    const config = require('../config/env');
    if (config.nodeEnv === 'production') throw new Error('Demo seeding is disabled in production');
    await mongoose.connect(config.mongodbUri);
    console.log(await seedDoctors());
  })().catch(error => { console.error(error.message); process.exitCode = 1; }).finally(() => mongoose.disconnect());
}
module.exports = seedDoctors;
module.exports.demoDoctors = demoDoctors;
