const requestLogger = (req, res, next) => {
  const startTime = Date.now();

  // Log when request completes
  res.on('finish', () => {
    const duration = Date.now() - startTime;
    const { method, originalUrl } = req;
    const { statusCode } = res;

    console.log(`${method} ${originalUrl} - ${statusCode} - ${duration}ms`);
  });

  next();
};

module.exports = requestLogger;
