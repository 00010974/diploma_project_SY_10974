import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diplomaapp/models/course.dart';
import 'package:diplomaapp/models/lesson.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diplomaapp/services/course_service.dart';

import '../widgets/calendar_widget.dart';
import '../widgets/course_card.dart';
import '../widgets/premium_banner.dart';
import '../widgets/schedule_widget.dart';
import '../widgets/sidebar.dart';
import '../widgets/tasks_list.dart';
import '../widgets/topbar.dart';
import '../courses/course_details_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  DateTime? _selectedDate;
  Map<String, List<Map<String, String>>> _customTasks =
      {}; // Для добавления задач

  void _addNewTask(String time, String taskName) {
    final dateKey =
        _selectedDate != null
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
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (e.g. 10:00 AM)',
                ),
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
                if (_timeController.text.isNotEmpty &&
                    _taskController.text.isNotEmpty) {
                  _addNewTask(_timeController.text, _taskController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  TopBar(pageTitle: "Dashboard"),
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
                                height: 180,
                                child: StreamBuilder<List<Course>>(
                                  stream: CourseService().getStudentCourses(FirebaseAuth.instance.currentUser!.uid),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                                    final courses = snapshot.data!;
                                    if (courses.isEmpty) return const Text("You are not enrolled in any courses.");

                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: courses.length,
                                      itemBuilder: (context, index) {
                                        final course = courses[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: CourseCard(
                                            title: course.title,
                                            hoursTaken: 3.2, // TODO: Заменить на реальное время, если есть
                                            totalHours: 10, // TODO: или убрать
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => CourseDetailPage(course: course),
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

                              const SizedBox(height: 24),
                              const TasksList(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),

                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CalendarWidget(
                                  onDaySelected: (selectedDate) {
                                    setState(() {
                                      _selectedDate = selectedDate;
                                    });
                                  },
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Schedule",
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                    IconButton(
                                      onPressed: _showAddTaskDialog,
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: ScheduleWidget(
                                    key: ValueKey(_selectedDate),
                                    selectedDate: _selectedDate,
                                    customTasks: _customTasks,
                                  ),
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
