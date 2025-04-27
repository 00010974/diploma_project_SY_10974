import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:diplomaapp/models/course.dart';
import 'package:diplomaapp/services/course_service.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/premium_banner.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import '../widgets/tasks_list.dart';
import '../widgets/schedule_widget.dart';
import '../widgets/course_card.dart';
import '../courses/create_course_page.dart';
import '../lesson/teacher_course_detail_page.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  DateTime? _selectedDate;
  Map<String, List<Map<String, String>>> _customTasks = {};

  void _addNewTask(String time, String taskName) {
    final dateKey = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (!_customTasks.containsKey(dateKey)) {
      _customTasks[dateKey] = [];
    }
    _customTasks[dateKey]!.add({"time": time, "task": taskName});
    setState(() {});
  }

  void _showAddTaskDialog() {
    final _timeController = TextEditingController();
    final _taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time (e.g. 10:00 AM)'),
            ),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_timeController.text.isNotEmpty && _taskController.text.isNotEmpty) {
                _addNewTask(_timeController.text, _taskController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacherId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Dashboard"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TopBar(pageTitle: "Teacher Dashboard"),
                  const SizedBox(height: 24),
                  const PremiumBanner(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Courses created by teacher
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "My Created Courses",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => CreateCoursePage()),
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text("Create Course"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: StreamBuilder<List<Course>>(
                                  stream: CourseService().getCoursesForUser(teacherId, 'teacher'),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(child: CircularProgressIndicator());
                                    }

                                    final courses = snapshot.data!;
                                    if (courses.isEmpty) {
                                      return const Text("You have not created any courses yet.");
                                    }

                                    return ListView.builder(
                                      itemCount: courses.length,
                                      itemBuilder: (context, index) {
                                        final course = courses[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 12.0),
                                          child: CourseCard(
                                            title: course.title,
                                            hoursTaken: course.enrolledStudentIds.length.toDouble(),
                                            totalHours: 20, // TODO: Dynamic or editable
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => TeacherCourseDetailPage(course: course),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Tasks / Calendar
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CalendarWidget(
                                  onDaySelected: (date) => setState(() => _selectedDate = date),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Schedule", style: Theme.of(context).textTheme.titleLarge),
                                    IconButton(
                                      onPressed: _showAddTaskDialog,
                                      icon: const Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ScheduleWidget(
                                  key: ValueKey(_selectedDate),
                                  selectedDate: _selectedDate,
                                  customTasks: _customTasks,
                                ),
                              ],
                            ),
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
