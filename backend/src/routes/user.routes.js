const express = require('express');
const router = express.Router();
const { getUserProfile, updateUserProfile } = require('../controllers/user.controller');
const auth = require('../middleware/auth');

// All user routes are protected
router.get('/me', auth, getUserProfile);
router.put('/me', auth, updateUserProfile);

module.exports = router;
