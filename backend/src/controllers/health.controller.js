const config = require('../config/env');
const { getDatabaseStatus } = require('../config/database');

const getHealth = (req, res) => {
  const dbStatus = getDatabaseStatus();

  res.status(200).json({
    success: true,
    message: 'RapidCare API is running',
    service: 'rapidcare-backend',
    environment: config.nodeEnv,
    database: dbStatus.connected ? 'connected' : 'disconnected',
  });
};

module.exports = {
  getHealth,
};
