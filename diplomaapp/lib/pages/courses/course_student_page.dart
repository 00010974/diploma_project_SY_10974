import 'package:flutter/material.dart';
import 'package:diplomaapp/models/course.dart';


class CourseStudentsPage extends StatelessWidget {
  final Course course;

  const CourseStudentsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enrolled Students")),
      body: ListView.builder(
        itemCount: course.enrolledStudentIds.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text("Student ID: ${course.enrolledStudentIds[i]}"),
          );
        },
      ),
    );
  }
}
