const mongoose = require('mongoose');
const ActivityLog = require('../models/ActivityLog');

const TYPES = ['walking', 'running', 'cycling', 'gym', 'yoga', 'sports', 'other'];
const createActivity = async (req, res, next) => {
  try {
    const { activityType, durationMinutes, caloriesBurned, distance, steps, activityDate, notes } = req.body;
    if (!TYPES.includes(activityType)) return res.status(400).json({ success: false, message: 'Valid activity type is required' });
    if (!Number.isFinite(Number(durationMinutes)) || Number(durationMinutes) < 1) return res.status(400).json({ success: false, message: 'Duration must be at least 1 minute' });
    if (activityDate && Number.isNaN(new Date(activityDate).getTime())) return res.status(400).json({ success: false, message: 'Invalid activity date' });
    const activity = await ActivityLog.create({ user: req.user.id, activityType, durationMinutes: Number(durationMinutes), caloriesBurned, distance, steps, activityDate, notes });
    res.status(201).json({ success: true, message: 'Activity created successfully', data: { activity } });
  } catch (error) { next(error); }
};

const getActivities = async (req, res, next) => {
  try {
    const query = { user: req.user.id };
    if (req.query.activityType && TYPES.includes(req.query.activityType)) query.activityType = req.query.activityType;
    const activities = await ActivityLog.find(query).sort({ activityDate: -1, createdAt: -1 }).limit(100);
    const summary = activities.reduce((value, item) => ({ durationMinutes: value.durationMinutes + item.durationMinutes, caloriesBurned: value.caloriesBurned + (item.caloriesBurned || 0), distance: value.distance + (item.distance || 0), steps: value.steps + (item.steps || 0) }), { durationMinutes: 0, caloriesBurned: 0, distance: 0, steps: 0 });
    res.status(200).json({ success: true, message: 'Activities retrieved successfully', data: { activities, summary } });
  } catch (error) { next(error); }
};

const getActivitySummary = async (req, res, next) => {
  try {
    const activities = await ActivityLog.find({ user: req.user.id });
    const summary = activities.reduce((value, item) => ({ totalActivities: value.totalActivities + 1, durationMinutes: value.durationMinutes + item.durationMinutes, caloriesBurned: value.caloriesBurned + (item.caloriesBurned || 0), distance: value.distance + (item.distance || 0), steps: value.steps + (item.steps || 0) }), { totalActivities: 0, durationMinutes: 0, caloriesBurned: 0, distance: 0, steps: 0 });
    res.status(200).json({ success: true, message: 'Activity summary retrieved successfully', data: { summary } });
  } catch (error) { next(error); }
};

const getActivityById = async (req, res, next) => {
  try { if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid activity ID' }); const activity = await ActivityLog.findOne({ _id: req.params.id, user: req.user.id }); if (!activity) return res.status(404).json({ success: false, message: 'Activity not found' }); res.status(200).json({ success: true, message: 'Activity retrieved successfully', data: { activity } }); } catch (error) { next(error); }
};
const updateActivity = async (req, res, next) => {
  try { if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid activity ID' }); const updates = { ...req.body }; delete updates.user; if (updates.activityType && !TYPES.includes(updates.activityType)) return res.status(400).json({ success: false, message: 'Invalid activity type' }); if (updates.durationMinutes !== undefined && (!Number.isFinite(Number(updates.durationMinutes)) || Number(updates.durationMinutes) < 1)) return res.status(400).json({ success: false, message: 'Duration must be at least 1 minute' }); const activity = await ActivityLog.findOneAndUpdate({ _id: req.params.id, user: req.user.id }, updates, { new: true, runValidators: true }); if (!activity) return res.status(404).json({ success: false, message: 'Activity not found' }); res.status(200).json({ success: true, message: 'Activity updated successfully', data: { activity } }); } catch (error) { next(error); }
};
const deleteActivity = async (req, res, next) => {
  try { if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid activity ID' }); const activity = await ActivityLog.findOneAndDelete({ _id: req.params.id, user: req.user.id }); if (!activity) return res.status(404).json({ success: false, message: 'Activity not found' }); res.status(200).json({ success: true, message: 'Activity deleted successfully', data: { activity } }); } catch (error) { next(error); }
};

module.exports = { createActivity, getActivities, getActivitySummary, getActivityById, updateActivity, deleteActivity };
