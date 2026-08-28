const mongoose = require('mongoose');

const medicalRecordSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'User is required'],
  },
  title: {
    type: String,
    required: [true, 'Title is required'],
    trim: true,
    maxlength: [200, 'Title cannot exceed 200 characters'],
  },
  recordType: {
    type: String,
    enum: ['consultation', 'lab_report', 'prescription', 'vaccination', 'surgery', 'allergy', 'general'],
    default: 'general',
    required: [true, 'Record type is required'],
  },
  doctorName: {
    type: String,
    trim: true,
    default: null,
  },
  hospitalName: {
    type: String,
    trim: true,
    default: null,
  },
  recordDate: {
    type: Date,
    required: [true, 'Record date is required'],
  },
  description: {
    type: String,
    trim: true,
    maxlength: [2000, 'Description cannot exceed 2000 characters'],
    default: null,
  },
  diagnosisText: {
    type: String,
    trim: true,
    maxlength: [5000, 'Diagnosis text cannot exceed 5000 characters'],
    default: null,
  },
  prescriptionText: {
    type: String,
    trim: true,
    maxlength: [5000, 'Prescription text cannot exceed 5000 characters'],
    default: null,
  },
  notes: {
    type: String,
    trim: true,
    maxlength: [2000, 'Notes cannot exceed 2000 characters'],
    default: null,
  },
  status: {
    type: String,
    enum: ['active', 'archived'],
    default: 'active',
  },
}, {
  timestamps: true,
});

// Index for user's medical records
medicalRecordSchema.index({ user: 1, createdAt: -1 });
medicalRecordSchema.index({ user: 1, status: 1, createdAt: -1 });
medicalRecordSchema.index({ user: 1, recordType: 1, createdAt: -1 });

// Method to return safe medical record object
medicalRecordSchema.methods.toJSON = function() {
  const record = this.toObject();
  delete record.__v;
  return record;
};

const MedicalRecord = mongoose.model('MedicalRecord', medicalRecordSchema);

module.exports = MedicalRecord;
