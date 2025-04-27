import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final String title;

  const CourseDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final double progress = 0.45; // Пример прогресса 45%

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Картинка курса
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Прогресс
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Progress",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF6A5AE0),
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 8),
              Text("${(progress * 100).toStringAsFixed(1)}% completed",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 24),

          // Описание курса
          const Text(
            "About this Course",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Learn to master your skills and start generating passive income streams. "
            "This course includes practical projects, tips and tricks from industry experts.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Список модулей
          const Text(
            "Modules",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _moduleItem(
              title: "Introduction & Setup", duration: "8 min", completed: true),
          _moduleItem(
              title: "Fundamentals of Passive Income", duration: "14 min", completed: true),
          _moduleItem(
              title: "Building Your First Product", duration: "22 min", completed: false),
          _moduleItem(
              title: "Marketing Strategies", duration: "18 min", completed: false),
          _moduleItem(
              title: "Scaling Up Your Business", duration: "30 min", completed: false),
        ],
      ),
    );
  }

  Widget _moduleItem({required String title, required String duration, required bool completed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            duration,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}




