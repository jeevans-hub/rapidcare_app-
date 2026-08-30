class AppNotification {
  final String id;
  final String title;
  final String message;
  final String type;
  final String priority;
  final bool isRead;
  final String? relatedEntityType;
  final String? relatedEntityId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.isRead,
    this.relatedEntityType,
    this.relatedEntityId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return AppNotification(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      type: json['type']?.toString() ?? 'general',
      priority: json['priority']?.toString() ?? 'normal',
      isRead: json['isRead'] == true,
      relatedEntityType: json['relatedEntityType']?.toString(),
      relatedEntityId: json['relatedEntityId']?.toString(),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? now,
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? now,
    );
  }
}
