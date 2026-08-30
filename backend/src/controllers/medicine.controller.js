const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');

// Get all medicines with optional filters
const getAllMedicines = async (req, res, next) => {
  try {
    const { search, category, available, requiresPrescription } = req.query;

    // Build query
    const query = {};

    // Search by name or description
    if (search) {
      query.$or = [
        { name: { $regex: search, $options: 'i' } },
        { description: { $regex: search, $options: 'i' } },
        { genericName: { $regex: search, $options: 'i' } },
      ];
    }

    // Filter by category
    if (category) {
      query.category = category;
    }

    // Filter by availability
    if (available === 'true') {
      query.isAvailable = true;
    }

    // Filter by prescription requirement
    if (requiresPrescription === 'true') {
      query.requiresPrescription = true;
    } else if (requiresPrescription === 'false') {
      query.requiresPrescription = false;
    }

    // Execute query
    const medicines = await Medicine.find(query).sort({ category: 1, name: 1 });

    res.status(200).json({
      success: true,
      message: 'Medicines retrieved successfully',
      data: { medicines },
    });
  } catch (error) {
    next(error);
  }
};

// Get medicine by ID
const getMedicineById = async (req, res, next) => {
  try {
    const { id } = req.params;

    // Validate ObjectId
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medicine ID',
      });
    }

    const medicine = await Medicine.findById(id);

    if (!medicine) {
      return res.status(404).json({
        success: false,
        message: 'Medicine not found',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Medicine retrieved successfully',
      data: { medicine },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getAllMedicines,
  getMedicineById,
};
