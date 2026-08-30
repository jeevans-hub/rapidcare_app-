const express = require('express');
const auth = require('../middleware/auth');
const { createReminder, getReminders, getReminderById, updateReminder, completeReminder, deleteReminder } = require('../controllers/reminder.controller');

const router = express.Router();
router.use(auth);
router.post('/', createReminder);
router.get('/', getReminders);
router.get('/:id', getReminderById);
router.put('/:id', updateReminder);
router.patch('/:id/complete', completeReminder);
router.delete('/:id', deleteReminder);

module.exports = router;
