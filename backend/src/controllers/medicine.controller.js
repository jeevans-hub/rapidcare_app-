const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');
const getAllMedicines = async (req, res, next) => {
  try {
    const { search, category, available, requiresPrescription } = req.query;
    if ((search != null && typeof search !== 'string') || (category != null && typeof category !== 'string')) return res.status(400).json({ success: false, message: 'Invalid search or category' });
    const query = {};
    if (search) {
      const literal = Array.from(search).map(c => '.*+?^${}()|[]\\'.includes(c) ? '\\' + c : c).join('');
      query.$or = ['name', 'category', 'description', 'genericName'].map(field => ({ [field]: { $regex: literal, $options: 'i' } }));
    }
    if (category) query.category = category;
    if (available === 'true') { query.isAvailable = true; query.stock = { $gt: 0 }; }
    if (requiresPrescription === 'true' || requiresPrescription === 'false') query.requiresPrescription = requiresPrescription === 'true';
    const medicines = await Medicine.find(query).sort({ category: 1, name: 1 });
    res.json({ success: true, data: { medicines, categories: await Medicine.distinct('category') } });
  } catch (error) { next(error); }
};
const getMedicineById = async (req, res, next) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) return res.status(400).json({ success: false, message: 'Invalid medicine ID' });
    const medicine = await Medicine.findById(req.params.id);
    if (!medicine) return res.status(404).json({ success: false, message: 'Medicine not found' });
    res.json({ success: true, data: { medicine } });
  } catch (error) { next(error); }
};
module.exports = { getAllMedicines, getMedicineById };
