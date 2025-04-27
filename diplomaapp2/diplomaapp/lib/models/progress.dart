import 'package:cloud_firestore/cloud_firestore.dart';

class Progress {
  final String id;
  final String courseId;
  final String userId;
  final List<String> completedLessons;
  final List<String> passedQuizzes;
  final bool completed;
  final DateTime updatedAt;

  Progress({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.completedLessons,
    required this.passedQuizzes,
    required this.completed,
    required this.updatedAt,
  });

  factory Progress.fromMap(String id, Map<String, dynamic> data) => Progress(
        id: id,
        courseId: data['courseId'],
        userId: data['userId'],
        completedLessons: List<String>.from(data['completedLessons'] ?? []),
        passedQuizzes: List<String>.from(data['passedQuizzes'] ?? []),
        completed: data['completed'] ?? false,
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toMap() => {
        'courseId': courseId,
        'userId': userId,
        'completedLessons': completedLessons,
        'passedQuizzes': passedQuizzes,
        'completed': completed,
        'updatedAt': updatedAt,
      };
}
