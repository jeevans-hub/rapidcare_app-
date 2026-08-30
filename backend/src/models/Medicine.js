const mongoose = require('mongoose');

const medicineSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    maxlength: 200,
  },
  genericName: {
    type: String,
    maxlength: 200,
    default: null,
  },
  brand: {
    type: String,
    maxlength: 100,
    default: null,
  },
  category: {
    type: String,
    required: true,
    enum: [
      'Pain Relief',
      'Cold & Cough',
      'Vitamins',
      'First Aid',
      'Diabetes Care',
      'Heart Care',
      'Skin Care',
      'Digestive Care',
      'Personal Care',
      'Baby Care',
      'Health Devices',
      'General',
    ],
  },
  description: {
    type: String,
    maxlength: 2000,
    default: null,
  },
  price: {
    type: Number,
    required: true,
    min: 0,
  },
  mrp: {
    type: Number,
    min: 0,
    default: null,
  },
  discountPercent: {
    type: Number,
    min: 0,
    max: 100,
    default: 0,
  },
  stock: {
    type: Number,
    required: true,
    min: 0,
    default: 0,
  },
  unit: {
    type: String,
    enum: ['tablet', 'capsule', 'syrup', 'cream', 'ointment', 'drops', 'inhaler', 'injection', 'pack', 'bottle', 'tube', 'box'],
    default: 'tablet',
  },
  requiresPrescription: {
    type: Boolean,
    default: false,
  },
  manufacturer: {
    type: String,
    maxlength: 200,
    default: null,
  },
  expiryInfo: {
    type: String,
    maxlength: 100,
    default: null,
  },
  imageUrl: {
    type: String,
    default: null,
  },
  isAvailable: {
    type: Boolean,
    default: true,
  },
  rating: {
    type: Number,
    min: 0,
    max: 5,
    default: 4.5,
  },
  reviewCount: {
    type: Number,
    min: 0,
    default: 0,
  },
}, {
  timestamps: true,
});

// Indexes for efficient querying
medicineSchema.index({ category: 1, isAvailable: 1 });
medicineSchema.index({ name: 'text', description: 'text' }); // For search
medicineSchema.index({ isAvailable: 1, stock: 1 });

// Virtual for calculated price after discount
medicineSchema.virtual('discountedPrice').get(function() {
  if (this.discountPercent > 0) {
    return this.price * (1 - this.discountPercent / 100);
  }
  return this.price;
});

// Method to check if medicine is in stock
medicineSchema.methods.isInStock = function(quantity = 1) {
  return this.stock >= quantity && this.isAvailable;
};

// Custom toJSON to exclude virtuals and __v
medicineSchema.methods.toJSON = function() {
  const obj = this.toObject();
  delete obj.__v;
  return obj;
};

const Medicine = mongoose.model('Medicine', medicineSchema);

module.exports = Medicine;
