import 'package:flutter/material.dart';

class InstructorDashboard extends StatelessWidget {
  const InstructorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎓 Instructor Dashboard")),
      body: const Center(child: Text("Welcome, Instructor!")),
    );
  }
}
