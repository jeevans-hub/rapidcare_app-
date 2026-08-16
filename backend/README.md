# RapidCare Backend

Backend API for the RapidCare healthcare application.

## Purpose

This backend provides the REST API foundation for the RapidCare Flutter application. It serves as the server-side infrastructure for handling healthcare data, user authentication, appointments, and other healthcare services.

## Prerequisites

- Node.js (v14 or higher recommended)
- MongoDB (v4.4 or higher recommended)
- npm or yarn

## Installation

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

## Environment Setup

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Configure your environment variables in `.env`:
   ```
   NODE_ENV=development
   PORT=5000
   MONGODB_URI=mongodb://localhost:27017/rapidcare
   API_PREFIX=/api/v1
   ```

3. For MongoDB Atlas, use your connection string:
   ```
   MONGODB_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/rapidcare
   ```

   **Important:** Never commit real credentials to version control.

## MongoDB Configuration

### Local MongoDB

Ensure MongoDB is running locally:
```bash
# On Windows
mongod

# On macOS/Linux
sudo systemctl start mongod
```

### MongoDB Atlas

1. Create a free cluster at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Whitelist your IP address
3. Get your connection string
4. Update `MONGODB_URI` in `.env`

## Development

Start the development server with auto-reload:
```bash
npm run dev
```

This uses nodemon to automatically restart the server when files change.

## Production

Start the production server:
```bash
npm start
```

## Health Endpoint

Test the API health:

```bash
curl http://localhost:5000/api/v1/health
```

Expected response:
```json
{
  "success": true,
  "message": "RapidCare API is running",
  "service": "rapidcare-backend",
  "environment": "development",
  "database": "connected"
}
```

## Project Structure

```
backend/
├── src/
│   ├── config/
│   │   ├── env.js           # Environment configuration
│   │   └── database.js      # MongoDB connection
│   ├── controllers/        # Route controllers
│   ├── middleware/          # Express middleware
│   ├── models/              # Mongoose models
│   ├── routes/              # API routes
│   ├── services/            # Business logic
│   ├── utils/               # Utility functions
│   ├── app.js               # Express app configuration
│   └── server.js            # Server startup
├── .env                     # Environment variables (not committed)
├── .env.example             # Environment template
├── .gitignore               # Git ignore rules
├── package.json             # Dependencies and scripts
└── README.md                # This file
```

## API Versioning

All API endpoints are prefixed with `/api/v1` to support future versioning.

## Security Notes

- Never commit `.env` file with real credentials
- Use environment-specific configurations
- Implement proper authentication (planned for Phase 27)
- Validate all input data
- Use HTTPS in production

## Current Features

- ✅ Express server setup
- ✅ MongoDB connection with Mongoose
- ✅ Environment configuration
- ✅ CORS configuration
- ✅ Request logging
- ✅ Centralized error handling
- ✅ 404 handling
- ✅ Health check endpoint
- ✅ Graceful shutdown

## Planned Features

- 🔲 User authentication (JWT)
- 🔲 User registration and login
- 🔲 Doctor management
- 🔲 Appointment booking
- 🔲 Medical records
- 🔲 Health monitoring data
- 🔲 Insurance claims
- 🔲 Notifications

## Troubleshooting

### MongoDB Connection Failed

1. Ensure MongoDB is running
2. Check your `MONGODB_URI` in `.env`
3. Verify network connectivity for Atlas
4. Check MongoDB logs for errors

### Port Already in Use

Change the `PORT` in your `.env` file to use a different port.

### Dependencies Installation Failed

Try clearing npm cache:
```bash
npm cache clean --force
npm install
```
