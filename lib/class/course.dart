class Course {
  final int id;
  final String name;
  final String content;
  late int like;
  final String emoji;

  Course({
    required this.id,
    required this.name,
    required this.content,
    required this.like,
    required this.emoji,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      like: json['like'],
      emoji: json['emoge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'like': like,
      'emoge': emoji,
    };
  }
}