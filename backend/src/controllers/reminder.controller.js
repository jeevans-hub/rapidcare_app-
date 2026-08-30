const mongoose = require('mongoose');
const Reminder = require('../models/Reminder');
const Notification = require('../models/Notification');

const TYPES = ['medicine', 'appointment', 'health_checkup', 'exercise', 'water', 'general'];
const REPEATS = ['none', 'daily', 'weekly', 'monthly'];
const STATUSES = ['pending', 'completed', 'cancelled'];

const validatePayload = (body, partial = false) => {
  if (!partial && (!body.title || !body.title.trim())) return 'Title is required';
  if (body.title !== undefined && (!body.title.trim() || body.title.length > 200)) return 'Title must be between 1 and 200 characters';
  if (body.reminderType !== undefined && !TYPES.includes(body.reminderType)) return 'Invalid reminder type';
  if (body.repeat !== undefined && !REPEATS.includes(body.repeat)) return 'Invalid repeat value';
  if (body.status !== undefined && !STATUSES.includes(body.status)) return 'Invalid reminder status';
  if (body.reminderDate !== undefined && body.reminderDate !== null && Number.isNaN(Date.parse(body.reminderDate))) return 'Invalid reminder date';
  if (body.reminderTime !== undefined && body.reminderTime !== null && !/^([01]\d|2[0-3]):[0-5]\d$/.test(body.reminderTime)) return 'Invalid reminder time; use HH:mm';
  return null;
};

const createReminder = async (req, res, next) => {
  try {
    const error = validatePayload(req.body);
    if (error) return res.status(400).json({ success: false, message: error });
    const reminder = await Reminder.create({
      user: req.user.id,
      title: req.body.title.trim(),
      description: req.body.description || null,
      reminderType: req.body.reminderType || 'general',
      reminderDate: req.body.reminderDate || null,
      reminderTime: req.body.reminderTime || null,
      repeat: req.body.repeat || 'none',
      status: 'pending',
      isActive: req.body.isActive !== false,
    });
    await Notification.create({ user: req.user.id, title: 'Reminder created', message: `Reminder created: ${reminder.title}`, type: 'reminder', priority: 'normal', relatedEntityType: 'reminder', relatedEntityId: reminder.id });
    res.status(201).json({ success: true, message: 'Reminder created successfully', data: { reminder } });
  } catch (error) { next(error); }
};

const getReminders = async (req, res, next) => {
  try {
    const query = { user: req.user.id };
    if (req.query.reminderType && TYPES.includes(req.query.reminderType)) query.reminderType = req.query.reminderType;
    if (req.query.status && STATUSES.includes(req.query.status)) query.status = req.query.status;
    if (req.query.isActive === 'true' || req.query.isActive === 'false') query.isActive = req.query.isActive === 'true';
    const reminders = await Reminder.find(query).sort({ reminderDate: 1, reminderTime: 1, createdAt: -1 });
    res.status(200).json({ success: true, message: 'Reminders retrieved successfully', data: { reminders } });
  } catch (error) { next(error); }
};

const getReminderById = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid reminder ID' });
    const reminder = await Reminder.findOne({ _id: req.params.id, user: req.user.id });
    if (!reminder) return res.status(404).json({ success: false, message: 'Reminder not found' });
    res.status(200).json({ success: true, message: 'Reminder retrieved successfully', data: { reminder } });
  } catch (error) { next(error); }
};

const updateReminder = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid reminder ID' });
    const error = validatePayload(req.body, true);
    if (error) return res.status(400).json({ success: false, message: error });
    const allowed = ['title', 'description', 'reminderType', 'reminderDate', 'reminderTime', 'repeat', 'status', 'isActive'];
    const updates = Object.fromEntries(Object.entries(req.body).filter(([key]) => allowed.includes(key)));
    if (updates.title) updates.title = updates.title.trim();
    const reminder = await Reminder.findOneAndUpdate({ _id: req.params.id, user: req.user.id }, updates, { new: true, runValidators: true });
    if (!reminder) return res.status(404).json({ success: false, message: 'Reminder not found' });
    res.status(200).json({ success: true, message: 'Reminder updated successfully', data: { reminder } });
  } catch (error) { next(error); }
};

const completeReminder = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid reminder ID' });
    const reminder = await Reminder.findOneAndUpdate({ _id: req.params.id, user: req.user.id }, { status: 'completed', isActive: false }, { new: true });
    if (!reminder) return res.status(404).json({ success: false, message: 'Reminder not found' });
    await Notification.create({ user: req.user.id, title: 'Reminder completed', message: `Reminder completed: ${reminder.title}`, type: 'reminder', priority: 'normal', relatedEntityType: 'reminder', relatedEntityId: reminder.id });
    res.status(200).json({ success: true, message: 'Reminder completed successfully', data: { reminder } });
  } catch (error) { next(error); }
};

const deleteReminder = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid reminder ID' });
    const reminder = await Reminder.findOneAndDelete({ _id: req.params.id, user: req.user.id });
    if (!reminder) return res.status(404).json({ success: false, message: 'Reminder not found' });
    res.status(200).json({ success: true, message: 'Reminder deleted successfully', data: { reminder } });
  } catch (error) { next(error); }
};

module.exports = { createReminder, getReminders, getReminderById, updateReminder, completeReminder, deleteReminder };
