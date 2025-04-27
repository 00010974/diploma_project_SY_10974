// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'; // 👈 обязательно!
// import 'pages/auth/login_ui_page.dart';
// import 'pages/dashboard/admin_dashboard.dart';
// import 'pages/dashboard/instructor_dashboard.dart';
// import 'pages/dashboard/student_dashboard.dart';
// import 'pages/payment/subscription_plan_page.dart';
// import 'services/notification_service.dart';
// import 'supabase_config.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SupabaseConfig.initialize();
//   await NotificationService.init();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Campus LMS',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       debugShowCheckedModeBanner: false,
//       home: const LoginUIPage(), // 👈 ВСЕГДА сначала открываем Login
//       routes: {
//         '/payment': (context) => const SubscriptionPlanPage(),
//       },
//     );
//   }
// }

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   Future<String?> _getUserRole(String userId) async {
//     final response = await Supabase.instance.client
//         .from('students')
//         .select('role')
//         .eq('id', userId)
//         .maybeSingle(); // чтобы не упасть, если нет данных

//     if (response != null && response['role'] != null) {
//       return response['role'] as String;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<AuthState>(
//       stream: Supabase.instance.client.auth.onAuthStateChange,
//       builder: (context, snapshot) {
//         final session = Supabase.instance.client.auth.currentSession;
//         final user = session?.user;

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (user == null) {
//           return const LoginUIPage();
//         }

//         return FutureBuilder<String?>(
//           future: _getUserRole(user.id),
//           builder: (context, roleSnapshot) {
//             if (roleSnapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final role = roleSnapshot.data ?? 'student';

//             switch (role) {
//               case 'admin':
//                 return const AdminDashboard();
//               case 'instructor':
//                 return const InstructorDashboard();
//               default:
//                 return const StudentDashboard();
//             }
//           },
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/auth/login_ui_page.dart';
import 'pages/dashboard/admin_dashboard.dart';
import 'pages/dashboard/instructor_dashboard.dart';
import 'pages/dashboard/student_dashboard.dart';
import 'pages/payment/subscription_plan_page.dart';
import 'services/notification_service.dart';
import 'supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus LMS',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const LoginUIPage(),
      routes: {
        '/payment': (context) => const SubscriptionPlanPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<String?> _getUserRole(String userId) async {
    // Сначала ищем в students
    final student = await Supabase.instance.client
        .from('students')
        .select('role')
        .eq('id', userId)
        .maybeSingle();

    if (student != null && student['role'] != null) {
      return student['role'] as String;
    }

    // Если не студент, ищем в teachers
    final teacher = await Supabase.instance.client
        .from('teachers')
        .select('role')
        .eq('id', userId)
        .maybeSingle();

    if (teacher != null && teacher['role'] != null) {
      return teacher['role'] as String;
    }

    // Если нигде нет — считаем студентом
    return 'student';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        final user = session?.user;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (user == null) {
          return const LoginUIPage();
        }

        return FutureBuilder<String?>(
          future: _getUserRole(user.id),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final role = roleSnapshot.data ?? 'student';

            switch (role) {
              case 'admin':
                return const AdminDashboard();
              case 'instructor':
                return const InstructorDashboard();
              default:
                return const StudentDashboard();
            }
          },
        );
      },
    );
  }
}