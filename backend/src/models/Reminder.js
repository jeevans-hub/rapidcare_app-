const mongoose = require('mongoose');

const reminderSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  title: { type: String, required: true, trim: true, maxlength: 200 },
  description: { type: String, default: null, trim: true, maxlength: 1000 },
  reminderType: {
    type: String,
    enum: ['medicine', 'appointment', 'health_checkup', 'exercise', 'water', 'general'],
    default: 'general',
  },
  reminderDate: { type: String, default: null, trim: true, maxlength: 30 },
  reminderTime: { type: String, default: null, trim: true, maxlength: 20 },
  repeat: { type: String, enum: ['none', 'daily', 'weekly', 'monthly'], default: 'none' },
  status: { type: String, enum: ['pending', 'completed', 'cancelled'], default: 'pending' },
  isActive: { type: Boolean, default: true },
}, { timestamps: true });

reminderSchema.index({ user: 1, reminderDate: 1, reminderTime: 1 });
reminderSchema.index({ user: 1, createdAt: -1 });

reminderSchema.methods.toJSON = function() {
  const value = this.toObject();
  delete value.__v;
  return value;
};

module.exports = mongoose.model('Reminder', reminderSchema);
