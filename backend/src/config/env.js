require('dotenv').config();

const config = {
  port: process.env.PORT || 5000,
  nodeEnv: process.env.NODE_ENV || 'development',
  mongodbUri: process.env.MONGODB_URI,
  apiPrefix: process.env.API_PREFIX || '/api/v1',
  jwtSecret: process.env.JWT_SECRET,
  jwtExpiresIn: process.env.JWT_EXPIRES_IN || '7d',
};

// Validate required environment variables
if (!config.mongodbUri) {
  console.error('ERROR: MONGODB_URI is required in .env file');
  process.exit(1);
}

if (!config.jwtSecret) {
  console.error('ERROR: JWT_SECRET is required in .env file');
  process.exit(1);
}

module.exports = config;
