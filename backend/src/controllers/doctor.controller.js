const Doctor = require('../models/Doctor');

// Get all doctors with optional filtering
const getAllDoctors = async (req, res, next) => {
  try {
    const { search, specialty, available } = req.query;

    // Build query
    const query = {};

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
      const searchRegex = new RegExp(search, 'i');
      query.$or = [
        { name: searchRegex },
        { specialty: searchRegex },
        { hospital: searchRegex },
      ];
    }

    // Execute query
    const doctors = await Doctor.find(query).sort({ rating: -1, reviewCount: -1 });

    res.status(200).json({
      success: true,
      message: 'Doctors retrieved successfully',
      data: { doctors },
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

module.exports = {
  getAllDoctors,
  getDoctorById,
};
