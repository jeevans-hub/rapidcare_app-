// Appointment dates are calendar days in Asia/Kolkata, never host-local dates.
const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
function parseDay(value) {
  if (typeof value !== 'string' || !/^\d{4}-\d{2}-\d{2}(?:T.*)?$/.test(value) || !Number.isFinite(Date.parse(value))) return null;
  const day = value.slice(0, 10);
  const date = new Date(`${day}T00:00:00.000Z`);
  return date.toISOString().slice(0, 10) === day ? date : null;
}
function minutes(slot) {
  const match = typeof slot === 'string' && slot.match(/^(0[1-9]|1[0-2]):([0-5]\d) (AM|PM)$/);
  return match ? (+match[1] % 12 + (match[3] === 'PM' ? 12 : 0)) * 60 + +match[2] : null;
}
function clockMinutes(clock) {
  return /^([01]\d|2[0-3]):[0-5]\d$/.test(clock || '') ? +clock.slice(0, 2) * 60 + +clock.slice(3) : null;
}
function slotsForHours(start, end, duration) {
  const slots = [];
  for (let m = clockMinutes(start); m != null && duration > 0 && m + duration <= clockMinutes(end); m += duration) {
    slots.push(`${String(Math.floor(m / 60) % 12 || 12).padStart(2, '0')}:${String(m % 60).padStart(2, '0')} ${m < 720 ? 'AM' : 'PM'}`);
  }
  return slots;
}
function scheduledSlots(doctor, date, now = new Date()) {
  if (!date || doctor.isActive === false || !doctor.isAvailable || !doctor.availableDays.includes(days[date.getUTCDay()])) return [];
  const allowed = doctor.consultationStart && doctor.consultationEnd
    ? slotsForHours(doctor.consultationStart, doctor.consultationEnd, doctor.slotDurationMinutes)
    : doctor.availableSlots;
  return allowed.filter(slot => {
    const m = minutes(slot);
    return m != null && doctor.availableSlots.includes(slot) && date.getTime() + (m - 330) * 60000 > now.getTime();
  });
}
function dayQuery(date) {
  const day = date.toISOString().slice(0, 10);
  // Preserve and recognize previous UTC, IST, and host-midnight records.
  const local = new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate());
  return { $or: [ { appointmentDay: day }, { appointmentDate: { $in: [date, new Date(date.getTime() - 330 * 60000), local] } } ] };
}
module.exports = { parseDay, scheduledSlots, slotsForHours, dayQuery };
