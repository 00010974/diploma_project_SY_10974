import 'package:hive/hive.dart';

part 'course.g.dart';

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String instructorId;

  @HiveField(4)
  final String? videoUrl;

  @HiveField(5)
  final String? pdfUrl;

  @HiveField(6)
  final Map<String, String> studentStatuses;

  @HiveField(7)
  List<String> enrolledStudentIds;

  @HiveField(8)
Map<String, String> homework;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    this.videoUrl,
    this.pdfUrl,
    required this.studentStatuses,
    required this.enrolledStudentIds,
    required this.homework,
  });

  factory Course.fromMap(String id, Map<String, dynamic> data) {
    return Course(
      id: id,
      title: data['title'],
      description: data['description'],
      instructorId: data['instructorId'],
      videoUrl: data['videoUrl'],
      pdfUrl: data['pdfUrl'],
      studentStatuses: Map<String, String>.from(data['studentStatuses'] ?? {}),
      enrolledStudentIds: List<String>.from(data['enrolledStudentIds'] ?? []),
      homework: Map<String, String>.from(data['homework'] ?? {}),


    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'instructorId': instructorId,
      'videoUrl': videoUrl,
      'pdfUrl': pdfUrl,
      'studentStatuses': studentStatuses,
      'enrolledStudentIds': enrolledStudentIds,
      'homework': homework,
    };
  }
}
