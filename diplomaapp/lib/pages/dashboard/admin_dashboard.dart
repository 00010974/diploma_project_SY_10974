import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🛠️ Admin Panel")),
      body: const Center(child: Text("Welcome, Admin!")),
    );
  }
}
