const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { getCart, addToCart, updateCartItem, removeFromCart, clearCart } = require('../controllers/cart.controller');

// All cart routes require authentication
router.get('/', auth, getCart);
router.post('/items', auth, addToCart);
router.patch('/items/:medicineId', auth, updateCartItem);
router.delete('/items/:medicineId', auth, removeFromCart);
router.delete('/', auth, clearCart);

module.exports = router;
