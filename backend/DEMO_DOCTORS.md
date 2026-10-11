# Fictional doctor catalog

The existing `src/seed/doctorSeed.js` workflow now upserts RC-D001–RC-D020 from
`src/seed/demoDoctors.json`. These are fictional testing profiles, not verified
clinicians. All contacts are nonfunctional `.example` sample data. Booking only
persists a demo appointment; it performs no payment, call, SMS or email.

## Development/demo seeding

Select a development or disposable MongoDB database explicitly. Do not point
this command at production. From `backend`, in PowerShell:

```powershell
$env:NODE_ENV = 'development'
$env:RAPIDCARE_DEMO_SEED = 'true'
# Set MONGODB_URI to your development/demo database using your normal workflow.
node src/seed/doctorSeed.js
Remove-Item Env:RAPIDCARE_DEMO_SEED
```

The CLI refuses to run without the explicit opt-in, and both CLI and callable
seeder reject `NODE_ENV=production`. The application does not seed on startup.
No `.env` edits are needed. These guards do not identify a production database
whose environment was incorrectly labelled development; check the target first.

## Preservation

- A unique partial `demoKey` index prevents duplicate catalog identities.
- Reruns update catalog fields in place and retain MongoDB ObjectIds.
- No doctor or appointment records are deleted or reassigned.
- Only exact matches of all original eight seed payloads are marked inactive.
  Fingerprints in `legacyDoctorFingerprints.json` identify these historical
  seed-only payloads; a name match alone is never enough.
- Edited or unrecognized legacy records remain active and are counted in
  `unrecognizedLegacyCount`. Review these manually if the total catalog exceeds
  20. User-created doctors are preserved, so the overall catalog may exceed 20
  even though the supplied catalog contains exactly 20 active demo profiles.
- Inactive doctors remain retrievable by ID for existing appointment history;
  new bookings and rescheduling to their slots are refused.

## Scheduling contract

Existing list, details and booking APIs are unchanged. The additive public
`GET /api/v1/doctors/:id/availability?date=YYYY-MM-DD` endpoint returns `slots`
and `timeZone` without disclosing appointment owners or patient information.
List responses also return the full active `specialties` list for filtering.

Dates denote calendar days in `Asia/Kolkata`; time labels remain `hh:mm AM/PM`.
The server enforces weekdays, consultation hours, 30-minute boundaries, future
instants and active-slot conflicts for creation and rescheduling. New records
store `appointmentDay`, canonical UTC-midnight `appointmentDate`, demo status,
timezone and a server-calculated consultation fee. UTC midnight is a day key,
not the consultation instant. Conflict lookup also recognizes the previous
IST/host-midnight representation; existing timestamps are not rewritten.

## Verification

`npm test` runs against an isolated MongoDB memory replica set, never `.env`.
It covers all 20 list/detail/search/filter/schedule results, seeder reruns,
legacy retirement and reference preservation, concurrent conflicts, invalid
slots, authentication, cross-user access and IST time boundaries.

`flutter analyze` and `flutter test` include catalog, route, availability,
booking, confirmation/history and earlier dashboard/article regressions.
