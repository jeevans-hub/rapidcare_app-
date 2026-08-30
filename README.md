# RapidCare

RapidCare is a Flutter healthcare project with a Node.js/Express and MongoDB backend. It demonstrates authenticated healthcare workflows, including appointments, medical records, pharmacy orders, notifications, reminders, health metrics, and activity tracking.

## Stack

- Flutter/Dart frontend
- Node.js, Express, and Mongoose backend
- MongoDB
- JWT authentication

## Features

- Registration, login, profile, and logout
- Doctors and appointment management
- Medical records and prescriptions
- Medicine catalog, cart, and cash-on-delivery orders
- User-owned notifications and reminders
- User-owned health metrics, activity logs, and summary reports
- Emergency, education, wellness, insurance, and healthcare-service demo modules

## Project structure

```text
lib/                 Flutter screens, widgets, models, services, and routes
backend/src/         Express app, routes, controllers, models, and middleware
test/                Flutter tests
API_OVERVIEW.md      Backend endpoint overview
```

## Prerequisites

- Flutter SDK compatible with the project SDK constraint
- Node.js 14+
- MongoDB local instance or MongoDB Atlas database

## Setup

```bash
cd backend
npm install
copy .env.example .env       # Windows
```

Set the values in `backend/.env`. Never commit that file or real credentials.

## Run

Backend:

```bash
cd backend
npm run dev
```

Flutter:

```bash
flutter pub get
flutter run
```

API base URLs used by the app:

- Android emulator: `http://10.0.2.2:5000/api/v1`
- Windows/Web: `http://localhost:5000/api/v1`

## Test

```bash
flutter analyze
flutter test
```

The backend health check is available at `GET /api/v1/health`.

## Safety and limitations

RapidCare is a project/demo and personal-tracking application. It does not diagnose conditions, provide medical advice, recommend medicines or dosages, dispatch real emergency services, process real payments, send push/SMS/email notifications, or integrate with wearable devices. Consult a qualified medical professional for medical interpretation and seek emergency help immediately for serious symptoms.

Doctor and medicine catalog entries are seeded demo data. Backend-connected user data is scoped to the authenticated user.

## Portfolio note

This repository is suitable as a portfolio/college project demonstration. Configure private environment variables locally and review the known limitations before production use.
