import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/course_service.dart';
import '../../models/course.dart';
import '../courses/create_course_page.dart';
import 'teacher_course_detail_page.dart';

class TeacherCoursesPage extends StatelessWidget {
  final _courseService = CourseService();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Created Courses"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateCoursePage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Course>>(
        stream: _courseService.getCoursesForUser(uid, 'teacher'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text("Enrolled: ${course.studentStatuses.length} students"),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TeacherCourseDetailPage(course: course),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
