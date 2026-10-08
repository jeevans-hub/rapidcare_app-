const mongoose = require('mongoose');

const appointmentSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'User is required'],
  },
  doctor: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Doctor',
    required: [true, 'Doctor is required'],
  },
  appointmentDate: {
    type: Date,
    required: [true, 'Appointment date is required'],
  },
  timeSlot: {
    type: String,
    required: [true, 'Time slot is required'],
    trim: true,
  },
  reason: {
    type: String,
    trim: true,
    default: 'General consultation',
  },
  status: {
    type: String,
    enum: ['scheduled', 'completed', 'cancelled'],
    default: 'scheduled',
  },
  notes: {
    type: String,
    trim: true,
    default: null,
  },
}, {
  timestamps: true,
});

// Compound index to prevent duplicate appointments for same doctor at same date and time
appointmentSchema.index(
  { doctor: 1, appointmentDate: 1, timeSlot: 1 },
  { 
    name: 'unique_active_appointment_slot',
    unique: true,
    partialFilterExpression: { status: { $in: ['scheduled', 'completed'] } }
  }
);

// Index for user's appointments
appointmentSchema.index({ user: 1, createdAt: -1 });

// Method to return safe appointment object
appointmentSchema.methods.toJSON = function() {
  const appointment = this.toObject();
  delete appointment.__v;
  return appointment;
};

const Appointment = mongoose.model('Appointment', appointmentSchema);

module.exports = Appointment;
