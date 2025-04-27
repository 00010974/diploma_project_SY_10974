import 'package:flutter/material.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assignments = [
      {
        "title": "Flutter Project: Build Dashboard",
        "dueDate": "April 25, 2025",
        "submitted": false,
      },
      {
        "title": "Quiz on Data Structures",
        "dueDate": "April 28, 2025",
        "submitted": true,
      },
      {
        "title": "Essay: Future of AI",
        "dueDate": "May 1, 2025",
        "submitted": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments 📄'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment["title"]! as String,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Due: ${assignment["dueDate"]}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    assignment["submitted"] == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Submitted",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Submitting "${assignment["title"]}"...')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A5AE0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Submit Assignment'),
                          ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
