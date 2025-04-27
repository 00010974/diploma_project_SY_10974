import 'package:hive/hive.dart';

part 'lesson.g.dart';

@HiveType(typeId: 1)
class Lesson extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String? videoUrl;

  @HiveField(4)
  final String? pdfUrl;

  /// Ключ = userId, значение = файл или статус
  @HiveField(5)
  final Map<String, String> homework; // userId => filePath/status

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    this.videoUrl,
    this.pdfUrl,
    Map<String, String>? homework,
  }) : homework = homework ?? {};

  factory Lesson.fromMap(String id, Map<String, dynamic> data) {
    return Lesson(
      id: id,
      title: data['title'],
      description: data['description'],
      videoUrl: data['videoUrl'],
      pdfUrl: data['pdfUrl'],
      homework: Map<String, String>.from(data['homework'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'pdfUrl': pdfUrl,
      'homework': homework,
    };
  }
}
