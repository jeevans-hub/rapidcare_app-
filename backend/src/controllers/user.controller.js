const User = require('../models/User');

// Get User Profile
const getUserProfile = async (req, res, next) => {
  try {
    const user = req.user;

    res.status(200).json({
      success: true,
      data: {
        user: {
          id: user._id,
          name: user.name,
          email: user.email,
          phone: user.phone,
          dateOfBirth: user.dateOfBirth,
        },
      },
    });
  } catch (error) {
    next(error);
  }
};

// Update User Profile
const updateUserProfile = async (req, res, next) => {
  try {
    const { name, phone, dateOfBirth } = req.body;
    const user = req.user;

    // Only allow updating specific fields
    const allowedUpdates = {};
    
    if (name !== undefined) {
      if (typeof name === 'string' && name.trim() !== '') {
        allowedUpdates.name = name.trim();
      }
    }
    
    if (phone !== undefined) {
      if (typeof phone === 'string' && phone.trim() !== '') {
        allowedUpdates.phone = phone.trim();
      }
    }

    if (dateOfBirth !== undefined) {
      if (dateOfBirth !== null && dateOfBirth !== '') {
        allowedUpdates.dateOfBirth = new Date(dateOfBirth);
      } else if (dateOfBirth === null || dateOfBirth === '') {
        allowedUpdates.dateOfBirth = null;
      }
    }

    // Prevent updating sensitive fields
    const forbiddenFields = ['email', 'password', 'role', 'isActive'];
    for (const field of forbiddenFields) {
      if (req.body[field] !== undefined) {
        return res.status(400).json({
          success: false,
          message: `Cannot update ${field}`,
        });
      }
    }

    if (Object.keys(allowedUpdates).length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No valid fields to update',
      });
    }

    // Update user
    const updatedUser = await User.findByIdAndUpdate(
      user._id,
      { $set: allowedUpdates },
      { new: true, runValidators: true }
    ).select('-password');

    res.status(200).json({
      success: true,
      message: 'Profile updated successfully',
      data: {
        user: {
          id: updatedUser._id,
          name: updatedUser.name,
          email: updatedUser.email,
          phone: updatedUser.phone,
          dateOfBirth: updatedUser.dateOfBirth,
        },
      },
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getUserProfile,
  updateUserProfile,
};
