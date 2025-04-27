import 'package:cloud_firestore/cloud_firestore.dart';

class HomeworkService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitHomework({
    required String courseId,
    required String lessonId,
    required String studentId,
    required String fileUrl,
  }) async {
    final lessonRef = _db.collection('courses/$courseId/lessons').doc(lessonId);
    await lessonRef.update({
      'homework.$studentId': {
        'fileUrl': fileUrl,
        'status': 'submitted',
        'grade': '',
        'comment': '',
      }
    });
  }

  Future<void> reviewHomework({
    required String courseId,
    required String lessonId,
    required String studentId,
    required String grade,
    required String comment,
  }) async {
    final lessonRef = _db.collection('courses/$courseId/lessons').doc(lessonId);
    await lessonRef.update({
      'homework.$studentId.status': 'reviewed',
      'homework.$studentId.grade': grade,
      'homework.$studentId.comment': comment,
    });
  }
}
