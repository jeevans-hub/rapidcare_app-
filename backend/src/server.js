const app = require('./app');
const config = require('./config/env');
const { connectDatabase, disconnectDatabase } = require('./config/database');
const seedMedicines = require('./seed/medicineSeed');

const startServer = async () => {
  try {
    // Connect to MongoDB
    await connectDatabase();

    // Seed medicines (idempotent - only if none exist)
    await seedMedicines();

    // Start Express server
    const server = app.listen(config.port, () => {
      console.log(`RapidCare API server running on port ${config.port}`);
      console.log(`Environment: ${config.nodeEnv}`);
      console.log(`API endpoint: http://localhost:${config.port}${config.apiPrefix}/health`);
    });

    // Graceful shutdown
    const gracefulShutdown = async (signal) => {
      console.log(`\n${signal} received. Starting graceful shutdown...`);
      
      server.close(async () => {
        console.log('HTTP server closed');
        await disconnectDatabase();
        console.log('Graceful shutdown completed');
        process.exit(0);
      });

      // Force shutdown after 10 seconds
      setTimeout(() => {
        console.error('Forced shutdown after timeout');
        process.exit(1);
      }, 10000);
    };

    process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
    process.on('SIGINT', () => gracefulShutdown('SIGINT'));

  } catch (error) {
    console.error('Failed to start server:', error.message);
    process.exit(1);
  }
};

startServer();
