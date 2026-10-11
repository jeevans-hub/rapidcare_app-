const Appointment = require('../models/Appointment');
const Doctor = require('../models/Doctor');

const { parseDay: parseAppointmentDate, scheduledSlots, dayQuery } = require('../utils/doctorSchedule');

// Create appointment
const createAppointment = async (req, res, next) => {
  try {
    const { doctorId, appointmentDate, timeSlot, reason } = req.body || {};
    const userId = req.user.id;

    // Validation
    if (!doctorId) {
      return res.status(400).json({
        success: false,
        message: 'Doctor ID is required',
      });
    }

    if (!appointmentDate) {
      return res.status(400).json({
        success: false,
        message: 'Appointment date is required',
      });
    }

    if (typeof timeSlot !== 'string' || !timeSlot.trim()) {
      return res.status(400).json({
        success: false,
        message: 'Time slot is required',
      });
    }

    if (reason != null && typeof reason !== 'string') {
      return res.status(400).json({ success: false, message: 'Reason must be text' });
    }

    // Validate doctor ID format
    if (typeof doctorId !== 'string' || !doctorId.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid doctor ID',
      });
    }

    // Check if doctor exists
    const doctor = await Doctor.findById(doctorId);
    if (!doctor) {
      return res.status(404).json({
        success: false,
        message: 'Doctor not found',
      });
    }

    // Validate date format and check if date is in the past
    const appointmentDateObj = parseAppointmentDate(appointmentDate);
    if (!appointmentDateObj) {
      return res.status(400).json({
        success: false,
        message: 'Invalid appointment date format',
      });
    }

    if (!scheduledSlots(doctor, appointmentDateObj).includes(timeSlot)) {
      return res.status(400).json({ success: false, message: 'Selected slot is outside the doctor schedule or is in the past (Asia/Kolkata)' });
    }

    // Check for slot conflict
    const existingAppointment = await Appointment.findOne({
      doctor: doctorId,
      ...dayQuery(appointmentDateObj),
      timeSlot,
      status: { $ne: 'cancelled' },
    });

    if (existingAppointment) {
      return res.status(409).json({
        success: false,
        message: 'Selected appointment slot is no longer available',
      });
    }

    // Create appointment
    const appointment = new Appointment({
      user: userId,
      doctor: doctorId,
      appointmentDate: appointmentDateObj,
      appointmentDay: appointmentDateObj.toISOString().slice(0, 10),
      isDemo: doctor.isDemo, consultationFee: doctor.consultationFee, timeZone: doctor.timeZone,
      timeSlot,
      reason: reason || 'General consultation',
      status: 'scheduled',
    });

    await appointment.save();

    // Populate doctor details for response
    await appointment.populate('doctor', 'name specialty qualification hospital consultationFee isDemo demoKey timeZone');

    res.status(201).json({
      success: true,
      message: 'Appointment booked successfully',
      data: { appointment },
    });
  } catch (error) {
    next(error);
  }
};

// Get user's appointments
const getUserAppointments = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { status } = req.query;

    // Build query
    const query = { user: userId };

    // Filter by status if provided
    if (status && ['scheduled', 'completed', 'cancelled'].includes(status)) {
      query.status = status;
    }

    // Execute query with population
    const appointments = await Appointment.find(query)
      .populate('doctor', 'name specialty qualification hospital consultationFee isDemo demoKey timeZone rating')
      .sort({ appointmentDate: -1, createdAt: -1 });

    res.status(200).json({
      success: true,
      message: 'Appointments retrieved successfully',
      data: { appointments },
    });
  } catch (error) {
    next(error);
  }
};

// Get appointment by ID
const getAppointmentById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid appointment ID',
      });
    }

    const appointment = await Appointment.findById(id).populate(
      'doctor',
      'name specialty qualification hospital consultationFee isDemo demoKey timeZone rating experienceYears location about languages availableDays availableSlots'
    );

    if (!appointment) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    // Check ownership
    if (appointment.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Appointment retrieved successfully',
      data: { appointment },
    });
  } catch (error) {
    next(error);
  }
};

// Cancel appointment
const cancelAppointment = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid appointment ID',
      });
    }

    const appointment = await Appointment.findById(id);

    if (!appointment) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    // Check ownership
    if (appointment.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    // Check if already cancelled
    if (appointment.status === 'cancelled') {
      return res.status(400).json({
        success: false,
        message: 'Appointment is already cancelled',
      });
    }

    // Update status to cancelled
    appointment.status = 'cancelled';
    await appointment.save();

    // Populate doctor details for response
    await appointment.populate('doctor', 'name specialty qualification hospital consultationFee isDemo demoKey timeZone');

    res.status(200).json({
      success: true,
      message: 'Appointment cancelled successfully',
      data: { appointment },
    });
  } catch (error) {
    next(error);
  }
};

// Reschedule appointment
const rescheduleAppointment = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { appointmentDate, timeSlot } = req.body || {};
    const userId = req.user.id;

    // Validation
    if (!appointmentDate) {
      return res.status(400).json({
        success: false,
        message: 'Appointment date is required',
      });
    }

    if (typeof timeSlot !== 'string' || !timeSlot.trim()) {
      return res.status(400).json({
        success: false,
        message: 'Time slot is required',
      });
    }

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid appointment ID',
      });
    }

    const appointment = await Appointment.findById(id);

    if (!appointment) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    // Check ownership
    if (appointment.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found',
      });
    }

    // Check if already cancelled
    if (appointment.status === 'cancelled') {
      return res.status(400).json({
        success: false,
        message: 'Cannot reschedule a cancelled appointment',
      });
    }

    // Validate date format and check if date is in the past
    const newAppointmentDateObj = parseAppointmentDate(appointmentDate);
    if (!newAppointmentDateObj) {
      return res.status(400).json({
        success: false,
        message: 'Invalid appointment date format',
      });
    }

    // Check if doctor exists and validate time slot
    const doctor = await Doctor.findById(appointment.doctor);
    if (!doctor) {
      return res.status(404).json({
        success: false,
        message: 'Doctor not found',
      });
    }

    if (!scheduledSlots(doctor, newAppointmentDateObj).includes(timeSlot)) {
      return res.status(400).json({
        success: false,
        message: 'Selected time slot is not available for this doctor',
      });
    }

    // Check for slot conflict (excluding current appointment)
    const conflictingAppointment = await Appointment.findOne({
      doctor: appointment.doctor,
      ...dayQuery(newAppointmentDateObj),
      timeSlot,
      status: { $ne: 'cancelled' },
      _id: { $ne: id },
    });

    if (conflictingAppointment) {
      return res.status(409).json({
        success: false,
        message: 'Selected appointment slot is no longer available',
      });
    }

    // Update appointment
    appointment.appointmentDate = newAppointmentDateObj;
    appointment.appointmentDay = newAppointmentDateObj.toISOString().slice(0, 10);
    appointment.timeSlot = timeSlot;
    await appointment.save();

    // Populate doctor details for response
    await appointment.populate('doctor', 'name specialty qualification hospital consultationFee isDemo demoKey timeZone');

    res.status(200).json({
      success: true,
      message: 'Appointment rescheduled successfully',
      data: { appointment },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createAppointment,
  getUserAppointments,
  getAppointmentById,
  cancelAppointment,
  rescheduleAppointment,
};
