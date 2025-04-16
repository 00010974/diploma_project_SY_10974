import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/progress.dart';

class ProgressService {
  final _progressRef = FirebaseFirestore.instance.collection('progress');

  String _docId(String courseId, String userId) => "${courseId}_$userId";

  Future<void> markLessonComplete(String courseId, String userId, String lessonId) async {
    final docId = _docId(courseId, userId);
    final doc = await _progressRef.doc(docId).get();

    if (doc.exists) {
      final data = doc.data()!;
      List<String> completedLessons = List<String>.from(data['completedLessons'] ?? []);
      if (!completedLessons.contains(lessonId)) completedLessons.add(lessonId);

      await _progressRef.doc(docId).update({
        'completedLessons': completedLessons,
        'updatedAt': DateTime.now(),
      });
    } else {
      await _progressRef.doc(docId).set({
        'courseId': courseId,
        'userId': userId,
        'completedLessons': [lessonId],
        'passedQuizzes': [],
        'completed': false,
        'updatedAt': DateTime.now(),
      });
    }
  }

  Future<void> markQuizPassed(String courseId, String userId, String quizId) async {
    final docId = _docId(courseId, userId);
    final doc = await _progressRef.doc(docId).get();

    if (doc.exists) {
      final data = doc.data()!;
      List<String> passed = List<String>.from(data['passedQuizzes'] ?? []);
      if (!passed.contains(quizId)) passed.add(quizId);

      await _progressRef.doc(docId).update({
        'passedQuizzes': passed,
        'updatedAt': DateTime.now(),
      });
    } else {
      await _progressRef.doc(docId).set({
        'courseId': courseId,
        'userId': userId,
        'completedLessons': [],
        'passedQuizzes': [quizId],
        'completed': false,
        'updatedAt': DateTime.now(),
      });
    }
  }

  Stream<Progress?> getUserProgress(String courseId, String userId) {
    final docId = _docId(courseId, userId);
    return _progressRef.doc(docId).snapshots().map((doc) {
      if (doc.exists) return Progress.fromMap(doc.id, doc.data()!);
      return null;
    });
  }
}
