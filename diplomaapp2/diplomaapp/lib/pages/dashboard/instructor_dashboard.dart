import 'package:flutter/material.dart';
import '../widgets/topbar.dart';
import '../widgets/teacher_sidebar.dart';  
import '../courses/create_course_page.dart';
import '../courses/teacher_my_courses_page.dart';

class InstructorDashboard extends StatelessWidget {
  const InstructorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          if (!isMobile) const TeacherSidebar(selectedMenu: "Dashboard"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const TopBar(pageTitle: "Instructor Dashboard"),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: isMobile ? 1 : 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 4 / 3,
                      children: [
                        _dashboardCard(
                          context,
                          title: "Create New Course",
                          icon: Icons.add_circle_outline,
                          color: Colors.deepPurple,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const CreateCoursePage()),
                            );
                          },
                        ),
                        _dashboardCard(
                          context,
                          title: "My Courses",
                          icon: Icons.book_outlined,
                          color: Colors.orange,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const TeacherMyCoursesPage()),
                            );
                          },
                        ),
                        _dashboardCard(
                          context,
                          title: "Check Homeworks",
                          icon: Icons.assignment_turned_in_outlined,
                          color: Colors.green,
                          onTap: () {
                            // Здесь будет переход на проверку домашних заданий
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
