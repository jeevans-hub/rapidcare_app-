const mongoose = require('mongoose');

const healthMetricSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  metricType: { type: String, enum: ['heart_rate', 'blood_pressure', 'blood_sugar', 'temperature', 'oxygen_level', 'weight', 'height', 'steps', 'sleep', 'water_intake', 'calories', 'general'], required: true },
  value: { type: String, required: true, trim: true, maxlength: 100 },
  unit: { type: String, required: true, trim: true, maxlength: 30 },
  recordedAt: { type: Date, default: Date.now },
  notes: { type: String, default: null, trim: true, maxlength: 1000 },
  source: { type: String, default: 'manual', trim: true, maxlength: 50 },
  systolic: { type: Number, min: 0, default: null },
  diastolic: { type: Number, min: 0, default: null },
}, { timestamps: true });

healthMetricSchema.index({ user: 1, metricType: 1, recordedAt: -1 });
healthMetricSchema.index({ user: 1, recordedAt: -1 });
healthMetricSchema.methods.toJSON = function() { const value = this.toObject(); delete value.__v; return value; };

module.exports = mongoose.model('HealthMetric', healthMetricSchema);
