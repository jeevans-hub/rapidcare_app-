class MedicalRecord {
  final String id;
  final String title;
  final String recordType;
  final String? doctorName;
  final String? hospitalName;
  final DateTime recordDate;
  final String? description;
  final String? diagnosisText;
  final String? prescriptionText;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.recordType,
    this.doctorName,
    this.hospitalName,
    required this.recordDate,
    this.description,
    this.diagnosisText,
    this.prescriptionText,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      recordType: json['recordType']?.toString() ?? 'general',
      doctorName: json['doctorName']?.toString(),
      hospitalName: json['hospitalName']?.toString(),
      recordDate: json['recordDate'] != null 
          ? DateTime.parse(json['recordDate'].toString()) 
          : DateTime.now(),
      description: json['description']?.toString(),
      diagnosisText: json['diagnosisText']?.toString(),
      prescriptionText: json['prescriptionText']?.toString(),
      notes: json['notes']?.toString(),
      status: json['status']?.toString() ?? 'active',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'].toString()) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'].toString()) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'recordType': recordType,
      'doctorName': doctorName,
      'hospitalName': hospitalName,
      'recordDate': recordDate.toIso8601String(),
      'description': description,
      'diagnosisText': diagnosisText,
      'prescriptionText': prescriptionText,
      'notes': notes,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper method to get display type name
  String getDisplayType() {
    switch (recordType) {
      case 'consultation':
        return 'Doctor Report';
      case 'lab_report':
        return 'Lab Report';
      case 'prescription':
        return 'Prescription';
      case 'vaccination':
        return 'Vaccination';
      case 'surgery':
        return 'Surgery';
      case 'allergy':
        return 'Allergy';
      default:
        return 'General';
    }
  }

  // Helper method to get formatted date
  String getFormattedDate() {
    return '${recordDate.day} ${_getMonthName(recordDate.month)} ${recordDate.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  // Helper method to check if record is active
  bool get isActive => status == 'active';
  bool get isArchived => status == 'archived';
}
