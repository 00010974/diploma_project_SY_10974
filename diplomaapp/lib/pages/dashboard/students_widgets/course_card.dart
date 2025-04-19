import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final double hoursTaken;
  final double totalHours;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.hoursTaken,
    required this.totalHours,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (hoursTaken / totalHours).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF6A5AE0),
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Text(
              "${hoursTaken.toStringAsFixed(1)} hrs taken of ${totalHours.toStringAsFixed(0)} hrs",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
