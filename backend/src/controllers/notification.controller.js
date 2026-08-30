const mongoose = require('mongoose');
const Notification = require('../models/Notification');

const validId = (id) => mongoose.Types.ObjectId.isValid(id);

const getNotifications = async (req, res, next) => {
  try {
    const query = { user: req.user.id };
    if (req.query.type) query.type = req.query.type;
    if (req.query.isRead === 'true' || req.query.isRead === 'false') {
      query.isRead = req.query.isRead === 'true';
    }
    const notifications = await Notification.find(query).sort({ createdAt: -1 });
    res.status(200).json({ success: true, message: 'Notifications retrieved successfully', data: { notifications } });
  } catch (error) { next(error); }
};

const getUnreadCount = async (req, res, next) => {
  try {
    const count = await Notification.countDocuments({ user: req.user.id, isRead: false });
    res.status(200).json({ success: true, message: 'Unread count retrieved successfully', data: { count } });
  } catch (error) { next(error); }
};

const markAsRead = async (req, res, next) => {
  try {
    if (!validId(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid notification ID' });
    const notification = await Notification.findOneAndUpdate(
      { _id: req.params.id, user: req.user.id },
      { isRead: true },
      { new: true },
    );
    if (!notification) return res.status(404).json({ success: false, message: 'Notification not found' });
    res.status(200).json({ success: true, message: 'Notification marked as read', data: { notification } });
  } catch (error) { next(error); }
};

const markAllAsRead = async (req, res, next) => {
  try {
    const result = await Notification.updateMany({ user: req.user.id, isRead: false }, { isRead: true });
    res.status(200).json({ success: true, message: 'All notifications marked as read', data: { updatedCount: result.modifiedCount } });
  } catch (error) { next(error); }
};

const deleteNotification = async (req, res, next) => {
  try {
    if (!validId(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid notification ID' });
    const notification = await Notification.findOneAndDelete({ _id: req.params.id, user: req.user.id });
    if (!notification) return res.status(404).json({ success: false, message: 'Notification not found' });
    res.status(200).json({ success: true, message: 'Notification deleted successfully', data: { notification } });
  } catch (error) { next(error); }
};

module.exports = { getNotifications, getUnreadCount, markAsRead, markAllAsRead, deleteNotification };
