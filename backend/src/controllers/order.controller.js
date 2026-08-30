const Order = require('../models/Order');
const Cart = require('../models/Cart');
const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');

// Place order from cart
const placeOrder = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { deliveryAddress, notes } = req.body;

    // Get user's cart
    const cart = await Cart.findOne({ user: userId }).populate('items.medicine');
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Cart is empty',
      });
    }

    // Validate stock for all items
    for (const item of cart.items) {
      if (!item.medicine || !item.medicine.isAvailable) {
        return res.status(400).json({
          success: false,
          message: 'One or more medicines are not available',
        });
      }
      if (item.medicine.stock < item.quantity) {
        return res.status(400).json({
          success: false,
          message: `Insufficient stock for ${item.medicine.name}`,
        });
      }
    }

    // Calculate subtotal
    const subtotal = cart.items.reduce(
      (sum, item) => sum + (item.priceAtAdd * item.quantity),
      0
    );

    const deliveryFee = 2.99;
    const totalAmount = subtotal + deliveryFee;

    // Create order items with snapshots
    const orderItems = cart.items.map(item => ({
      medicine: item.medicine._id,
      nameSnapshot: item.medicine.name,
      priceSnapshot: item.priceAtAdd,
      quantity: item.quantity,
    }));

    // Create order
    const order = await Order.create({
      user: userId,
      items: orderItems,
      subtotal,
      deliveryFee,
      totalAmount,
      status: 'placed',
      deliveryAddress: deliveryAddress || null,
      paymentMethod: 'cash_on_delivery',
      notes: notes || null,
    });

    // Reduce stock
    for (const item of cart.items) {
      await Medicine.findByIdAndUpdate(item.medicine._id, {
        $inc: { stock: -item.quantity },
      });
    }

    // Clear cart
    cart.items = [];
    await cart.save();

    await order.populate('items.medicine');

    res.status(201).json({
      success: true,
      message: 'Order placed successfully',
      data: { order },
    });
  } catch (error) {
    next(error);
  }
};

// Get user's orders
const getUserOrders = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { status } = req.query;

    const query = { user: userId };
    if (status) {
      query.status = status;
    }

    const orders = await Order.find(query)
      .sort({ createdAt: -1 })
      .populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Orders retrieved successfully',
      data: { orders },
    });
  } catch (error) {
    next(error);
  }
};

// Get order by ID
const getOrderById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate ObjectId
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid order ID',
      });
    }

    const order = await Order.findById(id).populate('items.medicine');

    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found',
      });
    }

    // Check ownership
    if (order.user.toString() !== userId) {
      return res.status(403).json({
        success: false,
        message: 'Access denied',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Order retrieved successfully',
      data: { order },
    });
  } catch (error) {
    next(error);
  }
};

// Cancel order
const cancelOrder = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate ObjectId
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid order ID',
      });
    }

    const order = await Order.findById(id);

    if (!order) {
      return res.status(404).json({
        success: false,
        message: 'Order not found',
      });
    }

    // Check ownership
    if (order.user.toString() !== userId) {
      return res.status(403).json({
        success: false,
        message: 'Access denied',
      });
    }

    // Check if order can be cancelled
    if (order.status === 'cancelled' || order.status === 'delivered') {
      return res.status(400).json({
        success: false,
        message: 'Order cannot be cancelled',
      });
    }

    // Update status
    order.status = 'cancelled';
    await order.save();

    // Restore stock
    for (const item of order.items) {
      await Medicine.findByIdAndUpdate(item.medicine, {
        $inc: { stock: item.quantity },
      });
    }

    await order.populate('items.medicine');

    res.status(200).json({
      success: true,
      message: 'Order cancelled successfully',
      data: { order },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  placeOrder,
  getUserOrders,
  getOrderById,
  cancelOrder,
};
