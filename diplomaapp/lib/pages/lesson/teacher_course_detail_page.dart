import 'package:flutter/material.dart';
import '../../models/course.dart';
import 'create_lesson_page.dart';

class TeacherCourseDetailPage extends StatelessWidget {
  final Course course;

  const TeacherCourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Описание:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(course.description),

            ElevatedButton.icon(
            onPressed: () {
              // Переход на создание урока
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateLessonPage(courseId: course.id),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Lesson"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A5AE0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

            const SizedBox(height: 24),
            Text("Студенты:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: course.studentStatuses.length,
                itemBuilder: (context, index) {
                  final studentId = course.studentStatuses[index];
                  return ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text("Student ID: $studentId"), // TODO: Replace with name/email
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
