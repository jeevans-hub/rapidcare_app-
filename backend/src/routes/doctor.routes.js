const express = require('express');
const router = express.Router();
const { getAllDoctors, getDoctorById } = require('../controllers/doctor.controller');

// Public routes
router.get('/', getAllDoctors);
router.get('/:id', getDoctorById);

module.exports = router;
