import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:diplomaapp/pages/dashboard/student_dashboard.dart';
import 'package:diplomaapp/pages/dashboard/instructor_dashboard.dart';
import 'package:diplomaapp/pages/dashboard/admin_dashboard.dart';


Future<void> handleLoginRedirect(BuildContext context) async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    Navigator.pushReplacementNamed(context, '/'); // На login
    return;
  }

  final role = user.userMetadata?['role'] ?? 'student';

  if (role == 'admin') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AdminDashboard()),
    );
  } else if (role == 'instructor') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const InstructorDashboard()),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const StudentDashboard()),
    );
  }
}
