const mongoose = require('mongoose');

const cartItemSchema = new mongoose.Schema({
  medicine: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Medicine',
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
    min: 1,
    default: 1,
  },
  priceAtAdd: {
    type: Number,
    required: true,
    min: 0,
  },
}, { _id: false });

const cartSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    unique: true, // One cart per user
  },
  items: {
    type: [cartItemSchema],
    default: [],
  },
}, {
  timestamps: true,
});

// Virtual for calculating subtotal
cartSchema.virtual('subtotal').get(function() {
  return this.items.reduce((sum, item) => sum + (item.priceAtAdd * item.quantity), 0);
});

// Custom toJSON to exclude virtuals and __v
cartSchema.methods.toJSON = function() {
  const obj = this.toObject();
  delete obj.__v;
  return obj;
};

const Cart = mongoose.model('Cart', cartSchema);

module.exports = Cart;
