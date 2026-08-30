class ActivityLog {
  final String id;
  final String activityType;
  final int durationMinutes;
  final double? caloriesBurned;
  final double? distance;
  final int? steps;
  final DateTime activityDate;
  final String? notes;

  const ActivityLog({required this.id, required this.activityType, required this.durationMinutes, this.caloriesBurned, this.distance, this.steps, required this.activityDate, this.notes});

  factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        activityType: json['activityType']?.toString() ?? 'other',
        durationMinutes: int.tryParse(json['durationMinutes']?.toString() ?? '') ?? 0,
        caloriesBurned: double.tryParse(json['caloriesBurned']?.toString() ?? ''),
        distance: double.tryParse(json['distance']?.toString() ?? ''),
        steps: int.tryParse(json['steps']?.toString() ?? ''),
        activityDate: DateTime.tryParse(json['activityDate']?.toString() ?? '') ?? DateTime.now(),
        notes: json['notes']?.toString(),
      );
}
