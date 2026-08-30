const mongoose = require('mongoose');
const HealthMetric = require('../models/HealthMetric');

const TYPES = ['heart_rate', 'blood_pressure', 'blood_sugar', 'temperature', 'oxygen_level', 'weight', 'height', 'steps', 'sleep', 'water_intake', 'calories', 'general'];
const validDate = (value) => value == null || !Number.isNaN(new Date(value).getTime());

const validate = (body, partial = false) => {
  if (!partial && (!body.metricType || !TYPES.includes(body.metricType))) return 'Valid metric type is required';
  if (body.metricType !== undefined && !TYPES.includes(body.metricType)) return 'Invalid metric type';
  if (!partial && (body.value === undefined || body.value === null || String(body.value).trim() === '')) return 'Metric value is required';
  if (body.value !== undefined && String(body.value).length > 100) return 'Metric value is too long';
  if (body.recordedAt !== undefined && !validDate(body.recordedAt)) return 'Invalid recorded date';
  return null;
};

const createMetric = async (req, res, next) => {
  try {
    const error = validate(req.body);
    if (error) return res.status(400).json({ success: false, message: error });
    const metric = await HealthMetric.create({ ...req.body, user: req.user.id, value: String(req.body.value).trim(), source: req.body.source || 'manual' });
    res.status(201).json({ success: true, message: 'Health metric created successfully', data: { metric } });
  } catch (error) { next(error); }
};

const getMetrics = async (req, res, next) => {
  try {
    const query = { user: req.user.id };
    if (req.query.metricType && TYPES.includes(req.query.metricType)) query.metricType = req.query.metricType;
    if (req.query.startDate || req.query.endDate) {
      query.recordedAt = {};
      if (req.query.startDate && validDate(req.query.startDate)) query.recordedAt.$gte = new Date(req.query.startDate);
      if (req.query.endDate && validDate(req.query.endDate)) query.recordedAt.$lte = new Date(req.query.endDate);
    }
    const requestedLimit = Number.parseInt(req.query.limit, 10);
    const limit = Number.isInteger(requestedLimit) ? Math.min(Math.max(requestedLimit, 1), 100) : 50;
    const metrics = await HealthMetric.find(query).sort({ recordedAt: -1, createdAt: -1 }).limit(limit);
    res.status(200).json({ success: true, message: 'Health metrics retrieved successfully', data: { metrics } });
  } catch (error) { next(error); }
};

const getSummary = async (req, res, next) => {
  try {
    const user = req.user.id;
    const [totalMetrics, recentMetrics, grouped] = await Promise.all([
      HealthMetric.countDocuments({ user }),
      HealthMetric.find({ user }).sort({ recordedAt: -1 }).limit(20),
      HealthMetric.aggregate([{ $match: { user: new mongoose.Types.ObjectId(user) } }, { $group: { _id: '$metricType', count: { $sum: 1 } } }]),
    ]);
    const latest = {};
    for (const metric of recentMetrics) if (!latest[metric.metricType]) latest[metric.metricType] = metric;
    res.status(200).json({ success: true, message: 'Health summary retrieved successfully', data: { totalMetrics, latestHeartRate: latest.heart_rate || null, latestBloodPressure: latest.blood_pressure || null, latestWeight: latest.weight || null, recentMetrics, metricCountsByType: Object.fromEntries(grouped.map((item) => [item._id, item.count])) } });
  } catch (error) { next(error); }
};

const getMetricById = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid health metric ID' });
    const metric = await HealthMetric.findOne({ _id: req.params.id, user: req.user.id });
    if (!metric) return res.status(404).json({ success: false, message: 'Health metric not found' });
    res.status(200).json({ success: true, message: 'Health metric retrieved successfully', data: { metric } });
  } catch (error) { next(error); }
};

const updateMetric = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid health metric ID' });
    const error = validate(req.body, true);
    if (error) return res.status(400).json({ success: false, message: error });
    const updates = { ...req.body, ...(req.body.value !== undefined ? { value: String(req.body.value).trim() } : {}) };
    delete updates.user;
    const metric = await HealthMetric.findOneAndUpdate({ _id: req.params.id, user: req.user.id }, updates, { new: true, runValidators: true });
    if (!metric) return res.status(404).json({ success: false, message: 'Health metric not found' });
    res.status(200).json({ success: true, message: 'Health metric updated successfully', data: { metric } });
  } catch (error) { next(error); }
};

const deleteMetric = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid health metric ID' });
    const metric = await HealthMetric.findOneAndDelete({ _id: req.params.id, user: req.user.id });
    if (!metric) return res.status(404).json({ success: false, message: 'Health metric not found' });
    res.status(200).json({ success: true, message: 'Health metric deleted successfully', data: { metric } });
  } catch (error) { next(error); }
};

module.exports = { createMetric, getMetrics, getSummary, getMetricById, updateMetric, deleteMetric };
