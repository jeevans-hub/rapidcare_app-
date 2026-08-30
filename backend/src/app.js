const express = require('express');
const cors = require('cors');
const config = require('./config/env');
const requestLogger = require('./middleware/requestLogger');
const notFound = require('./middleware/notFound');
const errorHandler = require('./middleware/errorHandler');
const healthRoutes = require('./routes/health.routes');
const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/user.routes');
const doctorRoutes = require('./routes/doctor.routes');
const appointmentRoutes = require('./routes/appointment.routes');
const medicalRecordRoutes = require('./routes/medicalRecord.routes');
const medicineRoutes = require('./routes/medicine.routes');
const cartRoutes = require('./routes/cart.routes');
const orderRoutes = require('./routes/order.routes');
const notificationRoutes = require('./routes/notification.routes');
const reminderRoutes = require('./routes/reminder.routes');
const healthMetricRoutes = require('./routes/healthMetric.routes');
const activityLogRoutes = require('./routes/activityLog.routes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(requestLogger);

// Routes
app.use(config.apiPrefix, healthRoutes);
app.use(`${config.apiPrefix}/auth`, authRoutes);
app.use(`${config.apiPrefix}/users`, userRoutes);
app.use(`${config.apiPrefix}/doctors`, doctorRoutes);
app.use(`${config.apiPrefix}/appointments`, appointmentRoutes);
app.use(`${config.apiPrefix}/medical-records`, medicalRecordRoutes);
app.use(`${config.apiPrefix}/medicines`, medicineRoutes);
app.use(`${config.apiPrefix}/cart`, cartRoutes);
app.use(`${config.apiPrefix}/orders`, orderRoutes);
app.use(`${config.apiPrefix}/notifications`, notificationRoutes);
app.use(`${config.apiPrefix}/reminders`, reminderRoutes);
app.use(`${config.apiPrefix}/health-metrics`, healthMetricRoutes);
app.use(`${config.apiPrefix}/activity-logs`, activityLogRoutes);

// 404 handler
app.use(notFound);

// Error handler
app.use(errorHandler);

module.exports = app;
