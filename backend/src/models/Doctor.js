const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
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
    ],
  },
  qualification: {
    type: String,
    required: [true, 'Qualification is required'],
    trim: true,
  },
  experienceYears: {
    type: Number,
    required: [true, 'Experience years is required'],
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
doctorSchema.methods.toJSON = function() {
  const doctor = this.toObject();
  delete doctor.__v;
  return doctor;
};

const Doctor = mongoose.model('Doctor', doctorSchema);

module.exports = Doctor;
