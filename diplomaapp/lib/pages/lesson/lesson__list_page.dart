import 'package:flutter/material.dart';
import 'package:diplomaapp/models/lesson.dart';
import 'package:diplomaapp/services/lesson_service.dart';
import 'create_lesson_page.dart';

class LessonListPage extends StatelessWidget {
  final String courseId;
  final LessonService _lessonService = LessonService();

  LessonListPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course Lessons")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateLessonPage(courseId: courseId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Lesson>>(
        stream: _lessonService.getLessons(courseId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final lessons = snapshot.data!;
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return ListTile(
                title: Text(lesson.title),
                subtitle: Text(lesson.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _lessonService.deleteLesson(courseId, lesson.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
