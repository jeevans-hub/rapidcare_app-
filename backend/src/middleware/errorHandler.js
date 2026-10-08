const errorHandler = (err, req, res, next) => {
  let statusCode = err.statusCode || err.status || 500;
  let message = err.message || 'Internal server error';

  if (err.code === 11000) {
    statusCode = 409;
    message = err.keyPattern?.doctor
      ? 'Selected appointment slot is no longer available'
      : 'A record with these details already exists';
  } else if (err.name === 'ValidationError' || err.name === 'CastError') {
    statusCode = 400;
    message = 'Invalid request data';
  } else if (statusCode >= 500) {
    message = 'Internal server error';
  }

  // Log error for development (without exposing sensitive details)
  if (process.env.NODE_ENV === 'development') {
    console.error('Request failed:', { statusCode, name: err.name, code: err.code });
  }

  res.status(statusCode).json({
    success: false,
    message: message,
  });
};

module.exports = errorHandler;
