# RapidCare API Overview

Base URL: `/api/v1`

## Public routes

- `GET /health`
- `POST /auth/register`
- `POST /auth/login`
- `GET /doctors`
- `GET /doctors/:id`
- `GET /medicines`
- `GET /medicines/:id`

## Authenticated routes

Send `Authorization: Bearer <JWT>`.

- `/auth/me`
- `/users/me`
- `/appointments`
- `/medical-records`
- `/cart`
- `/orders`
- `/notifications`
- `/reminders`
- `/health-metrics`
- `/activity-logs`

Health metrics provide create/list/details/update/delete operations and `GET /health-metrics/summary`. Activity logs provide create/list/details/update/delete operations and `GET /activity-logs/summary`. Notifications support listing, unread count, mark-read, mark-all-read, and deletion. Reminders support create, list, details, update, complete, and delete.

All private resources are scoped to the authenticated user. Error responses use `{ "success": false, "message": "..." }` and do not expose stack traces.
