const express = require('express');
const router = express.Router();
const {
  createMedicalRecord,
  getUserMedicalRecords,
  getMedicalRecordById,
  updateMedicalRecord,
  archiveMedicalRecord,
  deleteMedicalRecord,
} = require('../controllers/medicalRecord.controller');
const auth = require('../middleware/auth');

// All medical record routes are protected
router.post('/', auth, createMedicalRecord);
router.get('/', auth, getUserMedicalRecords);
router.get('/:id', auth, getMedicalRecordById);
router.put('/:id', auth, updateMedicalRecord);
router.patch('/:id/archive', auth, archiveMedicalRecord);
router.delete('/:id', auth, deleteMedicalRecord);

module.exports = router;
