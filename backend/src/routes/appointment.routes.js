const express = require('express');
const router = express.Router();
const {
  createAppointment,
  getUserAppointments,
  getAppointmentById,
  cancelAppointment,
  rescheduleAppointment,
} = require('../controllers/appointment.controller');
const auth = require('../middleware/auth');

// All appointment routes are protected
router.post('/', auth, createAppointment);
router.get('/', auth, getUserAppointments);
router.get('/:id', auth, getAppointmentById);
router.patch('/:id/cancel', auth, cancelAppointment);
router.patch('/:id/reschedule', auth, rescheduleAppointment);

module.exports = router;
