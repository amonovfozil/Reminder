class TodoTaskModel {
  static const Object _unset = Object();
  String id;
  String title;
  String note;
  DateTime plannedAt;
  DateTime? completedAt;
  String iconKey;
  String typeLabel;

  TodoTaskModel({
    required this.id,
    required this.title,
    required this.plannedAt,
    this.note = '',
    this.completedAt,
    this.iconKey = '',
    this.typeLabel = '',
  });

  bool get isDone => completedAt != null;

  TodoTaskModel copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? plannedAt,
    Object? completedAt = _unset,
    String? iconKey,
    String? typeLabel,
  }) {
    return TodoTaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      plannedAt: plannedAt ?? this.plannedAt,
      completedAt:
          completedAt == _unset ? this.completedAt : completedAt as DateTime?,
      iconKey: iconKey ?? this.iconKey,
      typeLabel: typeLabel ?? this.typeLabel,
    );
  }

  factory TodoTaskModel.fromJson(Map<String, dynamic> json) => TodoTaskModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        note: json['note'] ?? '',
        plannedAt: _parseDate(json['planned_at']) ?? DateTime.now(),
        completedAt: _parseDate(json['completed_at']),
        iconKey: json['icon_key'] ?? '',
        typeLabel: json['type_label'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'planned_at': plannedAt.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
        'icon_key': iconKey,
        'type_label': typeLabel,
      };
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
