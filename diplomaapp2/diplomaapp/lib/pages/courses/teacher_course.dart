import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final String courseId;
  final String title;
  final String description;
  final String thumbnailUrl;

  const CourseDetail({
    super.key,
    required this.courseId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(thumbnailUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 24),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
