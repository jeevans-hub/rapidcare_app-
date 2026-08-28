const mongoose = require('mongoose');
const Doctor = require('../models/Doctor');
const config = require('../config/env');

const seedDoctors = async () => {
  try {
    // Connect to MongoDB
    await mongoose.connect(config.mongodbUri);
    console.log('Connected to MongoDB');

    // Check if doctors already exist
    const existingDoctors = await Doctor.countDocuments();
    if (existingDoctors > 0) {
      console.log(`Doctors already exist (${existingDoctors} found). Skipping seed.`);
      process.exit(0);
    }

    // Demo doctor data
    const doctors = [
      {
        name: 'Dr. Sarah Johnson',
        specialty: 'Cardiology',
        qualification: 'MBBS, MD',
        experienceYears: 12,
        hospital: 'City General Hospital',
        location: 'New York',
        consultationFee: 600,
        rating: 4.8,
        reviewCount: 234,
        about: 'Dr. Sarah Johnson is a highly experienced cardiologist with over 12 years of experience in treating heart conditions. She specializes in interventional cardiology and has successfully treated thousands of patients.',
        languages: ['English', 'Spanish'],
        availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
        availableSlots: [
          '09:00 AM',
          '09:30 AM',
          '10:00 AM',
          '10:30 AM',
          '11:00 AM',
          '11:30 AM',
          '02:00 PM',
          '02:30 PM',
          '03:00 PM',
          '03:30 PM',
          '04:00 PM',
          '04:30 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. Michael Lee',
        specialty: 'Dermatology',
        qualification: 'MBBS, MD',
        experienceYears: 8,
        hospital: 'St. Mary\'s Medical Center',
        location: 'Los Angeles',
        consultationFee: 500,
        rating: 4.6,
        reviewCount: 189,
        about: 'Dr. Michael Lee specializes in dermatology with expertise in treating various skin conditions. He is known for his patient-centered approach and effective treatments.',
        languages: ['English', 'Mandarin'],
        availableDays: ['Monday', 'Wednesday', 'Friday'],
        availableSlots: [
          '10:00 AM',
          '11:00 AM',
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. Emily Brown',
        specialty: 'Orthopedics',
        qualification: 'MBBS, MS',
        experienceYears: 15,
        hospital: 'Riverside Clinic',
        location: 'Chicago',
        consultationFee: 700,
        rating: 4.9,
        reviewCount: 312,
        about: 'Dr. Emily Brown is an orthopedic surgeon with 15 years of experience. She specializes in joint replacement and sports medicine.',
        languages: ['English'],
        availableDays: ['Tuesday', 'Thursday', 'Saturday'],
        availableSlots: [
          '09:00 AM',
          '11:00 AM',
          '01:00 PM',
          '03:00 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. David Wilson',
        specialty: 'Neurology',
        qualification: 'MBBS, MD',
        experienceYears: 10,
        hospital: 'City General Hospital',
        location: 'New York',
        consultationFee: 650,
        rating: 4.7,
        reviewCount: 156,
        about: 'Dr. David Wilson is a neurologist specializing in neurological disorders. He has extensive experience in diagnosing and treating conditions affecting the nervous system.',
        languages: ['English', 'French'],
        availableDays: ['Monday', 'Tuesday', 'Thursday', 'Friday'],
        availableSlots: [
          '09:30 AM',
          '10:30 AM',
          '11:30 AM',
          '02:30 PM',
          '03:30 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. Jennifer Martinez',
        specialty: 'Pediatrics',
        qualification: 'MBBS, MD',
        experienceYears: 7,
        hospital: 'Children\'s Hospital',
        location: 'Houston',
        consultationFee: 450,
        rating: 4.5,
        reviewCount: 98,
        about: 'Dr. Jennifer Martinez is a pediatrician dedicated to providing comprehensive care for children. She specializes in preventive care and childhood development.',
        languages: ['English', 'Spanish'],
        availableDays: ['Monday', 'Wednesday', 'Friday'],
        availableSlots: [
          '09:00 AM',
          '10:00 AM',
          '11:00 AM',
          '02:00 PM',
          '03:00 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. Robert Chen',
        specialty: 'General Medicine',
        qualification: 'MBBS, MD',
        experienceYears: 20,
        hospital: 'Metro Medical Center',
        location: 'San Francisco',
        consultationFee: 400,
        rating: 4.6,
        reviewCount: 278,
        about: 'Dr. Robert Chen is a general practitioner with 20 years of experience. He provides comprehensive primary care services and focuses on preventive medicine.',
        languages: ['English', 'Mandarin', 'Cantonese'],
        availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
        availableSlots: [
          '08:00 AM',
          '09:00 AM',
          '10:00 AM',
          '11:00 AM',
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. Amanda White',
        specialty: 'Gynecology',
        qualification: 'MBBS, MD',
        experienceYears: 11,
        hospital: 'Women\'s Health Center',
        location: 'Boston',
        consultationFee: 550,
        rating: 4.7,
        reviewCount: 201,
        about: 'Dr. Amanda White specializes in gynecology and women\'s health. She provides comprehensive care for women of all ages.',
        languages: ['English'],
        availableDays: ['Tuesday', 'Thursday', 'Saturday'],
        availableSlots: [
          '09:00 AM',
          '10:30 AM',
          '12:00 PM',
          '02:30 PM',
          '04:00 PM',
        ],
        isAvailable: true,
      },
      {
        name: 'Dr. James Anderson',
        specialty: 'ENT',
        qualification: 'MBBS, MS',
        experienceYears: 9,
        hospital: 'City General Hospital',
        location: 'New York',
        consultationFee: 480,
        rating: 4.4,
        reviewCount: 145,
        about: 'Dr. James Anderson is an ENT specialist treating ear, nose, and throat conditions. He has expertise in both medical and surgical treatments.',
        languages: ['English', 'German'],
        availableDays: ['Monday', 'Wednesday', 'Friday'],
        availableSlots: [
          '10:00 AM',
          '11:30 AM',
          '02:00 PM',
          '03:30 PM',
        ],
        isAvailable: true,
      },
    ];

    // Insert doctors
    await Doctor.insertMany(doctors);
    console.log(`Successfully seeded ${doctors.length} doctors`);

    process.exit(0);
  } catch (error) {
    console.error('Error seeding doctors:', error);
    process.exit(1);
  }
};

// Run seed if called directly
if (require.main === module) {
  seedDoctors();
}

module.exports = seedDoctors;
