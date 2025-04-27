import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/progress_service.dart';
import '../../models/progress.dart';

class ProgressView extends StatelessWidget {
  final String courseId;
  final int totalLessons;
  final int totalQuizzes;

  ProgressView({
    required this.courseId,
    required this.totalLessons,
    required this.totalQuizzes,
  });

  final _progressService = ProgressService();

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text("Прогресс по курсу")),
      body: StreamBuilder<Progress?>(
        stream: _progressService.getUserProgress(courseId, userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final progress = snapshot.data!;
          double lessonPercent = progress.completedLessons.length / totalLessons;
          double quizPercent = progress.passedQuizzes.length / totalQuizzes;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Уроки: ${progress.completedLessons.length} / $totalLessons"),
                LinearProgressIndicator(value: lessonPercent),
                SizedBox(height: 16),
                Text("Тесты: ${progress.passedQuizzes.length} / $totalQuizzes"),
                LinearProgressIndicator(value: quizPercent),
                SizedBox(height: 32),
                Text("Завершено: ${progress.completed ? "✅ Да" : "🕓 Нет"}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
