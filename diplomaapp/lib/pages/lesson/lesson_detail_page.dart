import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/lesson.dart';
import '../../models/course.dart';

class LessonDetailPage extends StatelessWidget {
  final Lesson lesson;

  const LessonDetailPage({super.key, required this.lesson});

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Описание
          Text(
            lesson.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Видео
          if (lesson.videoUrl != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.play_circle_fill),
              label: const Text("Watch Video"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6A5AE0)),
              onPressed: () => _openUrl(lesson.videoUrl!),
            ),

          const SizedBox(height: 16),

          // PDF
          if (lesson.pdfUrl != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Open PDF"),
              onPressed: () => _openUrl(lesson.pdfUrl!),
            ),

          const SizedBox(height: 24),

          // Домашнее задание
          if (lesson.homework != null) ...[
            const Text(
              "Homework",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              lesson.homework!['description'] ?? "No description",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            if (lesson.homework!['dueDate'] != null)
              Text(
                "Due: ${lesson.homework!['dueDate']}",
                style: const TextStyle(color: Colors.redAccent),
              ),
          ],
        ],
      ),
    );
  }
}
