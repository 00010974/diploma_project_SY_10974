import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/course_service.dart';
import '../../models/course.dart';

class StudentCoursesTabs extends StatelessWidget {
  final CourseService _courseService = CourseService();

  StudentCoursesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Courses'),
          backgroundColor: const Color(0xFF6A5AE0),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Enrolled'),
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: StreamBuilder<List<Course>>(
          stream: _courseService.getStudentCourses(uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final allCourses = snapshot.data!;
            final enrolled = allCourses.where((c) => true).toList(); // TODO: replace with real condition
            final pending = allCourses.where((c) => false).toList(); // mock filter
            final completed = allCourses.where((c) => false).toList(); // mock filter

            return TabBarView(
              children: [
                _buildCourseList(enrolled),
                _buildCourseList(pending),
                _buildCourseList(completed),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCourseList(List<Course> courses) {
    if (courses.isEmpty) {
      return const Center(child: Text("No courses found."));
    }

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(course.title),
            subtitle: Text(course.description),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Navigate to course details
            },
          ),
        );
      },
    );
  }
}
