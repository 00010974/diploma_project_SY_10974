import 'package:flutter/material.dart';
import '../../services/course_service.dart';
import '../../models/course.dart';

class CourseListPage extends StatelessWidget {
  final _courseService = CourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Все курсы")),
      body: StreamBuilder<List<Course>>(
        stream: _courseService.getCourses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(course.description),
                trailing: Text("👨‍🏫 ${course.instructorId}"),
                onTap: () {
                  // todo: go to course details
                },
              );
            },
          );
        },
      ),
    );
  }
}
