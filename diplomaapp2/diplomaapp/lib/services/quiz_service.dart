import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';

class QuizService {
  final _quizRef = FirebaseFirestore.instance.collection('quizzes');

  Future<void> createQuiz(Quiz quiz) async {
    await _quizRef.add(quiz.toMap());
  }

  Stream<List<Quiz>> getQuizzesByCourse(String courseId) {
    return _quizRef.where('courseId', isEqualTo: courseId).snapshots().map((snap) {
      return snap.docs.map((doc) => Quiz.fromMap(doc.id, doc.data())).toList();
    });
  }

  Future<Quiz> getQuiz(String quizId) async {
    final doc = await _quizRef.doc(quizId).get();
    return Quiz.fromMap(doc.id, doc.data()!);
  }
}
