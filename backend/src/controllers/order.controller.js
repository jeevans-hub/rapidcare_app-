const Order = require('../models/Order');
const Cart = require('../models/Cart');
const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');

const requestError = (statusCode, message) => Object.assign(new Error(message), { statusCode });

// Commit the order, inventory changes, and cart clearing together. MongoDB retries
// write conflicts, so a competing checkout sees the updated stock/cart on retry.
const placeOrder = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { deliveryAddress, notes } = req.body;
    const order = await mongoose.connection.transaction(async (session) => {
      const cart = await Cart.findOne({ user: userId }).session(session).populate('items.medicine');
      if (!cart || cart.items.length === 0) {
        throw requestError(400, 'Cart is empty');
      }

      for (const item of cart.items) {
        if (!item.medicine || !item.medicine.isAvailable) {
          throw requestError(400, 'One or more medicines are not available');
        }
        if (!Number.isInteger(item.quantity) || item.quantity < 1) {
          throw requestError(400, 'Quantity must be a positive integer');
        }
        const reserved = await Medicine.updateOne(
          { _id: item.medicine._id, isAvailable: true, stock: { $gte: item.quantity } },
          { $inc: { stock: -item.quantity } },
          { session }
        );
        if (reserved.modifiedCount !== 1) {
          throw requestError(409, 'Insufficient stock for ' + item.medicine.name);
        }
      }

      const subtotal = cart.items.reduce((sum, item) => sum + item.priceAtAdd * item.quantity, 0);
      const deliveryFee = 2.99;
      const [createdOrder] = await Order.create([{
        user: userId,
        items: cart.items.map(item => ({
          medicine: item.medicine._id,
          nameSnapshot: item.medicine.name,
          priceSnapshot: item.priceAtAdd,
          quantity: item.quantity,
        })),
        subtotal,
        deliveryFee,
        totalAmount: subtotal + deliveryFee,
        status: 'placed',
        deliveryAddress: deliveryAddress || null,
        paymentMethod: 'cash_on_delivery',
        notes: notes || null,
      }], { session });

      cart.items = [];
      await cart.save({ session });
      await createdOrder.populate('items.medicine');
      return createdOrder;
    });

    res.status(201).json({ success: true, message: 'Order placed successfully', data: { order } });
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

    const order = await mongoose.connection.transaction(async (session) => {
      const currentOrder = await Order.findById(id).session(session);
      if (!currentOrder) throw requestError(404, 'Order not found');
      if (currentOrder.user.toString() !== userId) throw requestError(403, 'Access denied');
      if (['cancelled', 'delivered'].includes(currentOrder.status)) {
        throw requestError(400, 'Order cannot be cancelled');
      }

      currentOrder.status = 'cancelled';
      await currentOrder.save({ session });
      for (const item of currentOrder.items) {
        await Medicine.updateOne(
          { _id: item.medicine },
          { $inc: { stock: item.quantity } },
          { session }
        );
      }
      await currentOrder.populate('items.medicine');
      return currentOrder;
    });

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
