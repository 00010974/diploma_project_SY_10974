import 'package:flutter/material.dart';
import '../courses/course_list_page.dart';
import '../progress/progress_view.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎓 Student Panel")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Добро пожаловать в личный кабинет студента!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CourseListPage()),
                );
              },
              icon: const Icon(Icons.school),
              label: const Text("📚 Мои Курсы"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProgressView(
                      courseId: 'course123', // заменишь на текущий
                      totalLessons: 5,
                      totalQuizzes: 2,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.timeline),
              label: const Text("📊 Мой прогресс"),
            ),
          ],
        ),
      ),
    );
  }
}
