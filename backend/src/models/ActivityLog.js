const mongoose = require('mongoose');

const activityLogSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  activityType: { type: String, enum: ['walking', 'running', 'cycling', 'gym', 'yoga', 'sports', 'other'], required: true },
  durationMinutes: { type: Number, required: true, min: 1 },
  caloriesBurned: { type: Number, min: 0, default: null },
  distance: { type: Number, min: 0, default: null },
  steps: { type: Number, min: 0, default: null },
  activityDate: { type: Date, default: Date.now },
  notes: { type: String, default: null, trim: true, maxlength: 1000 },
}, { timestamps: true });

activityLogSchema.index({ user: 1, activityDate: -1 });
activityLogSchema.methods.toJSON = function() { const value = this.toObject(); delete value.__v; return value; };

module.exports = mongoose.model('ActivityLog', activityLogSchema);
