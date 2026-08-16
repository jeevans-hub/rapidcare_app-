require('dotenv').config();

const config = {
  port: process.env.PORT || 5000,
  nodeEnv: process.env.NODE_ENV || 'development',
  mongodbUri: process.env.MONGODB_URI,
  apiPrefix: process.env.API_PREFIX || '/api/v1',
};

// Validate required environment variables
if (!config.mongodbUri) {
  console.error('ERROR: MONGODB_URI is required in .env file');
  process.exit(1);
}

module.exports = config;
