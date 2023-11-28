class NoteModel {
  String? id;
  String? title;
  String? description;
  String? color;
  String? tags;
  int? priority;
  int? isActive;
  DateTime? createdAt;

  NoteModel({
    this.id,
    this.title,
    this.description,
    this.color,
    this.tags,
    this.priority,
    this.isActive,
    createdAt,
  }) : createdAt = (createdAt ?? DateTime.now());

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'title': String title,
        'description': String description,
        'color': String color,
        'tags': String tags,
        'priority': int priority,
        'isActive': int isActive,
        'createdAt': String createdAt,
      } =>
        NoteModel(
          id: id,
          title: title,
          description: description,
          color: color,
          tags: tags,
          priority: priority,
          isActive: isActive,
          createdAt: DateTime.parse(createdAt).toLocal(),
        ),
      _ => throw const FormatException('Failed to load note.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'color': color,
      'tags': tags,
      'priority': priority,
      'isActive': isActive,
    };
  }

  // NoteModel.fromMap(Map<String, Object?> map) {
  //   id = map['id'] as int?;
  //   title = map['title'] as String?;
  //   description = map['description'] as String?;
  //   color = map['color'] as String?;
  //   tags = map['tags'] as String?;
  //   priority = map['priority'] as int?;
  //   isActive = map['is_active'] as int?;
  //   createdAt = DateTime.parse(map['created_at'] as String);
  // }

  // Map<String, Object?> toMap() {
  //   Map<String, Object?> map = {
  //     'title': title,
  //     'description': description,
  //     'color': color,
  //     'tags': tags,
  //     'priority': priority,
  //     'is_active': isActive,
  //     'created_at': createdAt?.toIso8601String(),
  //   };

  //   if (id != null) {
  //     map['id'] = id;
  //   }

  //   return map;
  // }
}
