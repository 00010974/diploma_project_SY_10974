import 'package:flutter/material.dart';
import '../dashboard/students_widgets/calendar_widget.dart';
import '../dashboard/students_widgets/course_card.dart';
import '../dashboard/students_widgets/premium_banner.dart';
import '../dashboard/students_widgets/schedule_widget.dart';
import '../dashboard/students_widgets/sidebar.dart';
import '../dashboard/students_widgets/tasks_list.dart';
import '../dashboard/students_widgets/topbar.dart';
import '../dashboard/students_widgets/notification_panel.dart';
import '../courses/course_details_page.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const TopBar(),
                  const SizedBox(height: 24),
                  const PremiumBanner(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Row( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Courses + Tasks
                        Expanded(
                          flex: 2,
                          child: ListView(
                            children: [
                              const Text(
                                "My Courses",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),

                              SizedBox(
                                height: 160,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    CourseCard(
                                      title:
                                          "Envato Mastery: Build Passive Income",
                                      hoursTaken: 3.2,
                                      totalHours: 10,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const CourseDetailPage(
                                                  title:
                                                      "Envato Mastery: Build Passive Income",
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                    CourseCard(
                                      title: "Mastering Git & Vercel Deployment",
                                      hoursTaken: 2.5,
                                      totalHours: 6,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const CourseDetailPage(
                                                  title: "Mastering Git & Vercel Deployment",
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                    CourseCard(
                                      title: "Advanced Flutter Web Techniques",
                                      hoursTaken: 1.0,
                                      totalHours: 8,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const CourseDetailPage(
                                                  title: "Advanced Flutter Web Techniques",
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),
                              const TasksList(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Calendar + Schedule
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: const [
                              CalendarWidget(),
                              SizedBox(height: 24),
                              ScheduleWidget(),
                            ],
                          ),
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
}
