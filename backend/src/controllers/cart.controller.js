const Cart = require('../models/Cart');
const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');

// Get user's cart
const getCart = async (req, res, next) => {
  try {
    const userId = req.user.id;

    let cart = await Cart.findOne({ user: userId }).populate('items.medicine');

    if (!cart) {
      cart = await Cart.create({ user: userId, items: [] });
    }

    res.status(200).json({
      success: true,
      message: 'Cart retrieved successfully',
      data: { cart },
    });
  } catch (error) {
    next(error);
  }
};

// Add item to cart
const addToCart = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { medicineId, quantity = 1 } = req.body;

    // Validate medicineId
    if (!mongoose.Types.ObjectId.isValid(medicineId)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medicine ID',
      });
    }

    // Validate quantity
    if (quantity < 1 || !Number.isInteger(quantity)) {
      return res.status(400).json({
        success: false,
        message: 'Quantity must be a positive integer',
      });
    }

    // Find medicine
    const medicine = await Medicine.findById(medicineId);
    if (!medicine) {
      return res.status(404).json({
        success: false,
        message: 'Medicine not found',
      });
    }

    // Check availability
    if (!medicine.isAvailable) {
      return res.status(400).json({
        success: false,
        message: 'Medicine is not available',
      });
    }

    // Check stock
    if (medicine.stock < quantity) {
      return res.status(400).json({
        success: false,
        message: 'Insufficient stock',
      });
    }

    // Find or create cart
    let cart = await Cart.findOne({ user: userId });
    if (!cart) {
      cart = await Cart.create({ user: userId, items: [] });
    }

    // Check if medicine already in cart
    const existingItemIndex = cart.items.findIndex(
      item => item.medicine.toString() === medicineId
    );

    if (existingItemIndex !== -1) {
      // Update quantity
      const newQuantity = cart.items[existingItemIndex].quantity + quantity;
      if (medicine.stock < newQuantity) {
        return res.status(400).json({
          success: false,
          message: 'Insufficient stock for requested quantity',
        });
      }
      cart.items[existingItemIndex].quantity = newQuantity;
    } else {
      // Add new item
      cart.items.push({
        medicine: medicineId,
        quantity,
        priceAtAdd: medicine.price,
      });
    }

    await cart.save();
    await cart.populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Item added to cart successfully',
      data: { cart },
    });
  } catch (error) {
    next(error);
  }
};

// Update cart item quantity
const updateCartItem = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { medicineId } = req.params;
    const { quantity } = req.body;

    // Validate medicineId
    if (!mongoose.Types.ObjectId.isValid(medicineId)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medicine ID',
      });
    }

    // Validate quantity
    if (quantity < 0 || !Number.isInteger(quantity)) {
      return res.status(400).json({
        success: false,
        message: 'Quantity must be a non-negative integer',
      });
    }

    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found',
      });
    }

    const itemIndex = cart.items.findIndex(
      item => item.medicine.toString() === medicineId
    );

    if (itemIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Item not found in cart',
      });
    }

    if (quantity === 0) {
      // Remove item
      cart.items.splice(itemIndex, 1);
    } else {
      // Update quantity
      const medicine = await Medicine.findById(medicineId);
      if (!medicine) {
        return res.status(404).json({
          success: false,
          message: 'Medicine not found',
        });
      }

      if (medicine.stock < quantity) {
        return res.status(400).json({
          success: false,
          message: 'Insufficient stock',
        });
      }

      cart.items[itemIndex].quantity = quantity;
    }

    await cart.save();
    await cart.populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Cart item updated successfully',
      data: { cart },
    });
  } catch (error) {
    next(error);
  }
};

// Remove item from cart
const removeFromCart = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { medicineId } = req.params;

    // Validate medicineId
    if (!mongoose.Types.ObjectId.isValid(medicineId)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medicine ID',
      });
    }

    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found',
      });
    }

    const itemIndex = cart.items.findIndex(
      item => item.medicine.toString() === medicineId
    );

    if (itemIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Item not found in cart',
      });
    }

    cart.items.splice(itemIndex, 1);
    await cart.save();
    await cart.populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Item removed from cart successfully',
      data: { cart },
    });
  } catch (error) {
    next(error);
  }
};

// Clear cart
const clearCart = async (req, res, next) => {
  try {
    const userId = req.user.id;

    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res.status(404).json({
        success: false,
        message: 'Cart not found',
      });
    }

    cart.items = [];
    await cart.save();
    await cart.populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Cart cleared successfully',
      data: { cart },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getCart,
  addToCart,
  updateCartItem,
  removeFromCart,
  clearCart,
};
