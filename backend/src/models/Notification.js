const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  title: { type: String, required: true, trim: true, maxlength: 200 },
  message: { type: String, required: true, trim: true, maxlength: 2000 },
  type: {
    type: String,
    enum: ['general', 'appointment', 'medical_record', 'pharmacy_order', 'reminder', 'system'],
    default: 'general',
  },
  priority: { type: String, enum: ['low', 'normal', 'high'], default: 'normal' },
  isRead: { type: Boolean, default: false },
  relatedEntityType: { type: String, default: null, maxlength: 100 },
  relatedEntityId: { type: String, default: null, maxlength: 100 },
}, { timestamps: true });

notificationSchema.index({ user: 1, createdAt: -1 });
notificationSchema.index({ user: 1, isRead: 1 });

notificationSchema.methods.toJSON = function() {
  const value = this.toObject();
  delete value.__v;
  return value;
};

module.exports = mongoose.model('Notification', notificationSchema);
