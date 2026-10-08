const mongoose = require('mongoose');
const config = require('./env');

let isConnected = false;

const connectDatabase = async () => {
  if (isConnected) {
    console.log('MongoDB is already connected');
    return;
  }

  try {
    await mongoose.connect(config.mongodbUri);
    const topology = await mongoose.connection.db.admin().command({ hello: 1 });
    if (!topology.setName && topology.msg !== 'isdbgrid') {
      throw new Error('Transactions require a MongoDB replica set or Atlas. See backend/README.md for local setup.');
    }
    isConnected = true;
    console.log('MongoDB connected successfully');
  } catch (error) {
    console.error('MongoDB connection error:', error.message);
    process.exit(1);
  }
};

const disconnectDatabase = async () => {
  if (!isConnected) {
    return;
  }

  try {
    await mongoose.disconnect();
    isConnected = false;
    console.log('MongoDB disconnected successfully');
  } catch (error) {
    console.error('MongoDB disconnection error:', error.message);
  }
};

const getDatabaseStatus = () => {
  return {
    connected: isConnected,
    state: mongoose.connection.readyState,
  };
};

module.exports = {
  connectDatabase,
  disconnectDatabase,
  getDatabaseStatus,
};
