const express = require('express');
const router = express.Router();
const { getAllMedicines, getMedicineById } = require('../controllers/medicine.controller');

// Medicine routes (public - no auth required for browsing)
router.get('/', getAllMedicines);
router.get('/:id', getMedicineById);

module.exports = router;
