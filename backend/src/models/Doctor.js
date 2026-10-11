const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
  demoKey: { type: String },
  isDemo: { type: Boolean, default: false },
  isActive: { type: Boolean, default: true },
  clinic: String,
  timeZone: { type: String, default: 'Asia/Kolkata', enum: ['Asia/Kolkata'] },
  consultationStart: String,
  consultationEnd: String,
  slotDurationMinutes: { type: Number, default: 30, min: 1 },
  contactEmail: { type: String, default: null },
  contactPhone: { type: String, default: null },
  contactStatus: { type: String, default: 'unavailable' },
  name: {
    type: String,
    required: [true, 'Doctor name is required'],
    trim: true,
  },
  specialty: {
    type: String,
    required: [true, 'Specialty is required'],
    trim: true,
    enum: [
      'General Medicine',
      'Cardiology',
      'Dermatology',
      'Pediatrics',
      'Orthopedics',
      'Neurology',
      'ENT',
      'Gynecology',
      'Ophthalmology', 'Obstetrics & Gynecology', 'Gastroenterology',
      'Endocrinology', 'Pulmonology', 'Psychiatry', 'Urology', 'Nephrology',
      'Dentistry', 'Rheumatology', 'Oncology', 'Allergy & Immunology', 'Family Medicine',
    ],
  },
  qualification: {
    type: String,
    required: function() { return !this.get('isDemo'); },
    trim: true,
  },
  experienceYears: {
    type: Number,
    required: function() { return !this.get('isDemo'); },
    min: [0, 'Experience cannot be negative'],
  },
  hospital: {
    type: String,
    required: [true, 'Hospital is required'],
    trim: true,
  },
  location: {
    type: String,
    trim: true,
  },
  consultationFee: {
    type: Number,
    required: [true, 'Consultation fee is required'],
    min: [0, 'Fee cannot be negative'],
  },
  rating: {
    type: Number,
    default: 0,
    min: [0, 'Rating cannot be less than 0'],
    max: [5, 'Rating cannot be more than 5'],
  },
  reviewCount: {
    type: Number,
    default: 0,
    min: [0, 'Review count cannot be negative'],
  },
  about: {
    type: String,
    trim: true,
  },
  languages: {
    type: [String],
    default: [],
  },
  availableDays: {
    type: [String],
    default: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
  },
  availableSlots: {
    type: [String],
    default: [
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '02:00 PM',
      '02:30 PM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
    ],
  },
  isAvailable: {
    type: Boolean,
    default: true,
  },
  profileImageUrl: {
    type: String,
    default: null,
  },
}, {
  timestamps: true,
});

// Method to return safe doctor object
doctorSchema.index({ demoKey: 1 }, { unique: true, partialFilterExpression: { demoKey: { $type: 'string' } } });
doctorSchema.methods.toJSON = function() {
  const doctor = this.toObject();
  delete doctor.__v;
  return doctor;
};

const Doctor = mongoose.model('Doctor', doctorSchema);

module.exports = Doctor;
