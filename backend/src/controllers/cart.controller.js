const Cart = require('../models/Cart');
const Medicine = require('../models/Medicine');
const mongoose = require('mongoose');
const fail = (statusCode, message) => Object.assign(new Error(message), { statusCode });

// All mutations serialize against the same cart document, including checkout.
// Retrying write conflicts prevents lost increments and duplicate item rows.
async function cartFor(user) {
  try {
    return await Cart.findOneAndUpdate({ user }, { $setOnInsert: { items: [] } }, { upsert: true, new: true });
  } catch (error) {
    if (error.code === 11000) return Cart.findOne({ user });
    throw error;
  }
}
function priced(cart) {
  const value = cart.toJSON();
  value.items = value.items.map(item => ({ ...item, priceAtAdd: item.medicine?.price ?? item.priceAtAdd }));
  value.subtotal = value.items.reduce((sum, item) => sum + Math.round(item.priceAtAdd * 100) * item.quantity, 0) / 100;
  value.deliveryFee = value.items.length ? 2.99 : 0;
  value.total = Math.round((value.subtotal + value.deliveryFee) * 100) / 100;
  return value;
}
const getCart = async (req, res, next) => {
  try {
    const cart = await cartFor(req.user.id);
    await cart.populate('items.medicine');
    res.json({ success: true, data: { cart: priced(cart) } });
  } catch (error) { next(error); }
};
function mutate(action) {
  return async (req, res, next) => {
    try {
      const medicineId = action === 'add' ? req.body?.medicineId : req.params.medicineId;
      const quantity = req.body?.quantity ?? (action === 'add' ? 1 : undefined);
      if (action !== 'clear' && (typeof medicineId !== 'string' || !/^[a-fA-F0-9]{24}$/.test(medicineId))) throw fail(400, 'Invalid medicine ID');
      if (['add', 'update'].includes(action) && (!Number.isSafeInteger(quantity) || quantity < (action === 'add' ? 1 : 0))) throw fail(400, 'Quantity must be a valid integer');
      await cartFor(req.user.id);
      const cart = await mongoose.connection.transaction(async session => {
        const current = await Cart.findOne({ user: req.user.id }).session(session);
        const index = current.items.findIndex(item => item.medicine.toString() === medicineId);
        if (action === 'clear') current.items = [];
        else if (action === 'remove' || (action === 'update' && quantity === 0)) {
          if (index < 0) throw fail(404, 'Item not found in cart');
          current.items.splice(index, 1);
        } else {
          if (action === 'update' && index < 0) throw fail(404, 'Item not found in cart');
          const medicine = await Medicine.findById(medicineId).session(session);
          if (!medicine) throw fail(404, 'Medicine not found');
          if (!medicine.isAvailable) throw fail(400, 'Medicine is not available');
          const count = quantity + (action === 'add' && index >= 0 ? current.items[index].quantity : 0);
          if (!Number.isSafeInteger(count) || medicine.stock < count) throw fail(400, 'Insufficient stock');
          if (index >= 0) { current.items[index].quantity = count; current.items[index].priceAtAdd = medicine.price; }
          else current.items.push({ medicine: medicineId, quantity: count, priceAtAdd: medicine.price });
        }
        await current.save({ session });
        await current.populate('items.medicine');
        return current;
      });
      res.json({ success: true, data: { cart: priced(cart) } });
    } catch (error) { next(error); }
  };
}
module.exports = { getCart, addToCart: mutate('add'), updateCartItem: mutate('update'), removeFromCart: mutate('remove'), clearCart: mutate('clear') };
