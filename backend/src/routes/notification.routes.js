const express = require('express');
const auth = require('../middleware/auth');
const { getNotifications, getUnreadCount, markAsRead, markAllAsRead, deleteNotification } = require('../controllers/notification.controller');

const router = express.Router();
router.use(auth);
router.get('/', getNotifications);
router.get('/unread-count', getUnreadCount);
router.patch('/read-all', markAllAsRead);
router.patch('/:id/read', markAsRead);
router.delete('/:id', deleteNotification);

module.exports = router;
