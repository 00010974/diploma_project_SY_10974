import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                                      title:
                                          "Mastering Git & Vercel Deployment",
                                      hoursTaken: 2.5,
                                      totalHours: 6,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => const CourseDetailPage(
                                                  title:
                                                      "Mastering Git & Vercel Deployment",
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
                                                  title:
                                                      "Advanced Flutter Web Techniques",
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
