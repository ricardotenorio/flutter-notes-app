class NoteModel {
  int? id;
  String? title;
  String? description;
  String? color;
  DateTime? createdAt;

  NoteModel({
    this.id,
    this.title,
    this.description,
    this.color,
    createdAt,
  }) : createdAt = (createdAt ?? DateTime.now());

  NoteModel.fromMap(Map<String, Object?> map) {
    id = map['id'] as int?;
    title = map['title'] as String?;
    description = map['description'] as String?;
    color = map['color'] as String?;
    createdAt = DateTime.parse(map['created_at'] as String);
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      'title': title,
      'description': description,
      'color': color,
      'created_at': createdAt?.toIso8601String(),
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
