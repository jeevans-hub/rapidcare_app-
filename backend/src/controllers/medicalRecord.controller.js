const MedicalRecord = require('../models/MedicalRecord');

// Create medical record
const createMedicalRecord = async (req, res, next) => {
  console.log('[DEBUG BACKEND] POST /medical-records reached');
  console.log('[DEBUG BACKEND] req.user exists:', !!req.user);
  
  try {
    const { title, recordType, doctorName, hospitalName, recordDate, description, diagnosisText, prescriptionText, notes } = req.body;
    const userId = req.user.id;

    console.log('[DEBUG BACKEND] Received fields:', { title, recordType, recordDate, doctorName, hospitalName });

    // Validation
    if (!title) {
      console.log('[DEBUG BACKEND] Validation failed: Title is required');
      return res.status(400).json({
        success: false,
        message: 'Title is required',
      });
    }

    if (!recordType) {
      console.log('[DEBUG BACKEND] Validation failed: Record type is required');
      return res.status(400).json({
        success: false,
        message: 'Record type is required',
      });
    }

    if (!recordDate) {
      console.log('[DEBUG BACKEND] Validation failed: Record date is required');
      return res.status(400).json({
        success: false,
        message: 'Record date is required',
      });
    }

    // Validate record type
    const validRecordTypes = ['consultation', 'lab_report', 'prescription', 'vaccination', 'surgery', 'allergy', 'general'];
    if (!validRecordTypes.includes(recordType)) {
      console.log('[DEBUG BACKEND] Validation failed: Invalid record type:', recordType);
      return res.status(400).json({
        success: false,
        message: 'Invalid record type',
      });
    }

    // Validate date format
    const recordDateObj = new Date(recordDate);
    if (isNaN(recordDateObj.getTime())) {
      console.log('[DEBUG BACKEND] Validation failed: Invalid record date format:', recordDate);
      return res.status(400).json({
        success: false,
        message: 'Invalid record date format',
      });
    }

    // Create medical record
    const medicalRecord = new MedicalRecord({
      user: userId,
      title,
      recordType,
      doctorName: doctorName || null,
      hospitalName: hospitalName || null,
      recordDate: recordDateObj,
      description: description || null,
      diagnosisText: diagnosisText || null,
      prescriptionText: prescriptionText || null,
      notes: notes || null,
      status: 'active',
    });

    await medicalRecord.save();

    console.log('[DEBUG BACKEND] Created record ID:', medicalRecord._id);

    res.status(201).json({
      success: true,
      message: 'Medical record saved successfully',
      data: { medicalRecord },
    });
  } catch (error) {
    console.log('[DEBUG BACKEND] Error:', error.message);
    next(error);
  }
};

// Get user's medical records
const getUserMedicalRecords = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { recordType, status, search } = req.query;

    // Build query
    const query = { user: userId };

    // Filter by status if provided (default to active)
    if (status && ['active', 'archived'].includes(status)) {
      query.status = status;
    } else {
      query.status = 'active';
    }

    // Filter by record type if provided
    if (recordType) {
      query.recordType = recordType;
    }

    // Search functionality
    if (search) {
      query.$or = [
        { title: { $regex: search, $options: 'i' } },
        { doctorName: { $regex: search, $options: 'i' } },
        { hospitalName: { $regex: search, $options: 'i' } },
      ];
    }

    // Execute query
    const medicalRecords = await MedicalRecord.find(query)
      .sort({ recordDate: -1, createdAt: -1 });

    res.status(200).json({
      success: true,
      message: 'Medical records retrieved successfully',
      data: { medicalRecords },
    });
  } catch (error) {
    next(error);
  }
};

// Get medical record by ID
const getMedicalRecordById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medical record ID',
      });
    }

    const medicalRecord = await MedicalRecord.findById(id);

    if (!medicalRecord) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Check ownership
    if (medicalRecord.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    res.status(200).json({
      success: true,
      message: 'Medical record retrieved successfully',
      data: { medicalRecord },
    });
  } catch (error) {
    next(error);
  }
};

// Update medical record
const updateMedicalRecord = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title, recordType, doctorName, hospitalName, recordDate, description, diagnosisText, prescriptionText, notes } = req.body;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medical record ID',
      });
    }

    const medicalRecord = await MedicalRecord.findById(id);

    if (!medicalRecord) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Check ownership
    if (medicalRecord.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Update fields if provided
    if (title !== undefined) medicalRecord.title = title;
    if (recordType !== undefined) {
      const validRecordTypes = ['consultation', 'lab_report', 'prescription', 'vaccination', 'surgery', 'allergy', 'general'];
      if (!validRecordTypes.includes(recordType)) {
        return res.status(400).json({
          success: false,
          message: 'Invalid record type',
        });
      }
      medicalRecord.recordType = recordType;
    }
    if (doctorName !== undefined) medicalRecord.doctorName = doctorName;
    if (hospitalName !== undefined) medicalRecord.hospitalName = hospitalName;
    if (recordDate !== undefined) {
      const recordDateObj = new Date(recordDate);
      if (isNaN(recordDateObj.getTime())) {
        return res.status(400).json({
          success: false,
          message: 'Invalid record date format',
        });
      }
      medicalRecord.recordDate = recordDateObj;
    }
    if (description !== undefined) medicalRecord.description = description;
    if (diagnosisText !== undefined) medicalRecord.diagnosisText = diagnosisText;
    if (prescriptionText !== undefined) medicalRecord.prescriptionText = prescriptionText;
    if (notes !== undefined) medicalRecord.notes = notes;

    await medicalRecord.save();

    res.status(200).json({
      success: true,
      message: 'Medical record updated successfully',
      data: { medicalRecord },
    });
  } catch (error) {
    next(error);
  }
};

// Archive medical record
const archiveMedicalRecord = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medical record ID',
      });
    }

    const medicalRecord = await MedicalRecord.findById(id);

    if (!medicalRecord) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Check ownership
    if (medicalRecord.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Update status to archived
    medicalRecord.status = 'archived';
    await medicalRecord.save();

    res.status(200).json({
      success: true,
      message: 'Medical record archived successfully',
      data: { medicalRecord },
    });
  } catch (error) {
    next(error);
  }
};

// Delete medical record (soft delete via archive)
const deleteMedicalRecord = async (req, res, next) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid medical record ID',
      });
    }

    const medicalRecord = await MedicalRecord.findById(id);

    if (!medicalRecord) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Check ownership
    if (medicalRecord.user.toString() !== userId) {
      return res.status(404).json({
        success: false,
        message: 'Medical record not found',
      });
    }

    // Soft delete by archiving
    medicalRecord.status = 'archived';
    await medicalRecord.save();

    res.status(200).json({
      success: true,
      message: 'Medical record deleted successfully',
      data: { medicalRecord },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createMedicalRecord,
  getUserMedicalRecords,
  getMedicalRecordById,
  updateMedicalRecord,
  archiveMedicalRecord,
  deleteMedicalRecord,
};
