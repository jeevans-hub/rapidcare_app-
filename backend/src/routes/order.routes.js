const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { placeOrder, getUserOrders, getOrderById, cancelOrder } = require('../controllers/order.controller');

// All order routes require authentication
router.post('/', auth, placeOrder);
router.get('/', auth, getUserOrders);
router.get('/:id', auth, getOrderById);
router.patch('/:id/cancel', auth, cancelOrder);

module.exports = router;
