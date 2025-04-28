class Lesson {
  final int? id;
  final String title;
  final String description;
  final String level;

  Lesson({
    this.id,
    required this.title,
    required this.description,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      level: map['level'],
    );
  }
}