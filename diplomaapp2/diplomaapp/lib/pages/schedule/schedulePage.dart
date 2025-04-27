import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diplomaapp/pages/widgets/topbar.dart';
import 'package:diplomaapp/pages/widgets/sidebar.dart';
import 'schedule_widgets/add_event_modal.dart';
import 'schedule_widgets/category_list.dart';
import 'schedule_widgets/time_slot_list.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> events = [
    {
      'time': '08:00 AM',
      'title': 'Envato Mastery',
      'subtitle': 'Learn a new parts',
      'color': Colors.orange[100],
      'startHour': 8,
      'endHour': 9,
    },
    {
      'time': '10:00 AM',
      'title': 'UI/UX Design Basic',
      'subtitle': 'Complete Task 12',
      'color': Colors.purple[100],
      'startHour': 10,
      'endHour': 12,
    },
    {
      'time': '01:00 PM',
      'title': 'Mastering Git & Vercel App',
      'subtitle': 'Learn a new parts',
      'color': Colors.green[100],
      'startHour': 13,
      'endHour': 14,
    },
    {
      'time': '04:00 PM',
      'title': 'Live Class',
      'subtitle': 'How to Make Money from...',
      'color': Colors.yellow[100],
      'startHour': 16,
      'endHour': 18,
    },
  ];

  void _openAddEventModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddEventModal(
        onAdd: (newEvent) {
          setState(() {
            events.add(newEvent);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Schedule"), // Левая боковая панель
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: TopBar(pageTitle: "My Schedule"), // ✅ передаем заголовок страницы
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Левая часть - расписание
                        Expanded(
                          flex: 2,
                          child: TimeSlotList(events: events),
                        ),
                        const SizedBox(width: 24),
                        // Правая панель
                        Container(
                          width: 350,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _openAddEventModal,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add New Event', style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6A5AE0),
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _buildCalendar(),
                                const SizedBox(height: 24),
                                const CategoryList(),
                              ],
                            ),
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
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('MMMM yyyy').format(now),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        CalendarDatePicker(
          initialDate: now,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          onDateChanged: (date) {},
        ),
      ],
    );
  }
}
