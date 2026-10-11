const Doctor = require('../models/Doctor');
const Appointment = require('../models/Appointment');
const { parseDay, scheduledSlots, dayQuery } = require('../utils/doctorSchedule');

// Get all doctors with optional filtering
const getAllDoctors = async (req, res, next) => {
  try {
    const { search, specialty, available } = req.query;

    // Build query
    const query = { isActive: { $ne: false } };

    // Filter by specialty
    if (specialty && specialty !== 'All') {
      query.specialty = specialty;
    }

    // Filter by availability
    if (available === 'true') {
      query.isAvailable = true;
    }

    // Search by name, specialty, or hospital
    if (search) {
      const escapedSearch = Array.from(String(search), c => '.*+?^${}()|[]\\'.includes(c) ? '\\' + c : c).join('');
      const searchRegex = new RegExp(escapedSearch, 'i');
      query.$or = [
        { name: searchRegex },
        { specialty: searchRegex },
        { hospital: searchRegex },
      ];
    }

    // Execute query
    const doctors = await Doctor.find(query).sort({ demoKey: 1, name: 1 });

    res.status(200).json({
      success: true,
      message: 'Doctors retrieved successfully',
      data: { doctors, specialties: (await Doctor.distinct('specialty', { isActive: { $ne: false } })).sort() },
    });
  } catch (error) {
    next(error);
  }
};

// Get doctor by ID
const getDoctorById = async (req, res, next) => {
  try {
    const { id } = req.params;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid doctor ID',
      });
    }

    const doctor = await Doctor.findById(id);

    if (!doctor) {
      return res.status(404).json({
        success: false,
        message: 'Doctor not found',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Doctor retrieved successfully',
      data: { doctor },
    });
  } catch (error) {
    next(error);
  }
};

const getAvailability = async (req, res, next) => {
  try {
    if (!/^[0-9a-fA-F]{24}$/.test(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid doctor ID' });
    const doctor = await Doctor.findById(req.params.id);
    if (!doctor) return res.status(404).json({ success: false, message: 'Doctor not found' });
    const date = parseDay(req.query.date);
    if (!date) return res.status(400).json({ success: false, message: 'Invalid appointment date' });
    const booked = await Appointment.find({ doctor: doctor._id, ...dayQuery(date), status: { $ne: 'cancelled' } }).select('timeSlot').lean();
    const slots = scheduledSlots(doctor, date).filter(slot => !booked.some(a => a.timeSlot === slot));
    res.json({ success: true, data: { date: date.toISOString().slice(0, 10), timeZone: doctor.timeZone, slots } });
  } catch (error) { next(error); }
};

module.exports = {
  getAvailability,
  getAllDoctors,
  getDoctorById,
};
