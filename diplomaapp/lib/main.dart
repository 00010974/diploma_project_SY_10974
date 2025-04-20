import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/auth/login_ui_page.dart';
import 'pages/dashboard/admin_dashboard.dart';
import 'pages/dashboard/instructor_dashboard.dart';
import 'pages/dashboard/student_dashboard.dart';
import 'services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:diplomaapp/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus LMS',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        final user = snapshot.data;
        if (user == null) return LoginUIPage();

        // Получаем роль из Firestore
        return FutureBuilder<String>(
          future: AuthService().getUserRole(user.uid),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final role = roleSnapshot.data ?? 'student'; // Если роль не найдена, по умолчанию 'student'

            switch (role) {
              case 'admin':
                return AdminDashboard(); // Создадим этот класс позже
              case 'instructor':
                return InstructorDashboard(); // Создадим этот класс позже
              default:
                return StudentDashboard(); // Создадим этот класс позже
            }
          },
        );
      },
    );
  }
}

