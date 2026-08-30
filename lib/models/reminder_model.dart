class Reminder {
  final String id;
  final String title;
  final String? description;
  final String reminderType;
  final String? reminderDate;
  final String? reminderTime;
  final String repeat;
  final String status;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Reminder({
    required this.id,
    required this.title,
    this.description,
    required this.reminderType,
    this.reminderDate,
    this.reminderTime,
    required this.repeat,
    required this.status,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return Reminder(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      reminderType: json['reminderType']?.toString() ?? 'general',
      reminderDate: json['reminderDate']?.toString(),
      reminderTime: json['reminderTime']?.toString(),
      repeat: json['repeat']?.toString() ?? 'none',
      status: json['status']?.toString() ?? 'pending',
      isActive: json['isActive'] != false,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? now,
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? now,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'reminderType': reminderType,
        'reminderDate': reminderDate,
        'reminderTime': reminderTime,
        'repeat': repeat,
        'status': status,
        'isActive': isActive,
      };
}
