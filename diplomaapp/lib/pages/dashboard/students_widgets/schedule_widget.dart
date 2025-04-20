// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ScheduleWidget extends StatelessWidget {
//   final DateTime? selectedDate;

//   final Map<String, List<Map<String, String>>>? customTasks;

//   const ScheduleWidget({super.key, this.selectedDate, this.customTasks});

//   @override
//   Widget build(BuildContext context) {
//     // Фейковые задачи для разных дней
//     final Map<String, List<Map<String, String>>> allTasks = {
//       '2025-04-20': [
//         {"time": "10:00 AM", "task": "UI/UX Design Class"},
//         {"time": "01:00 PM", "task": "Flutter LMS Dashboard Project"},
//       ],
//       '2025-04-21': [
//         {"time": "09:00 AM", "task": "Data Structures Revision"},
//         {"time": "04:00 PM", "task": "Team Meeting"},
//       ],
//       '2025-04-25': [
//         {"time": "11:00 AM", "task": "Hackathon Preparation"},
//         {"time": "03:00 PM", "task": "Research on Firebase Integration"},
//       ],
//     };

//     String dateKey = selectedDate != null
//         ? DateFormat('yyyy-MM-dd').format(selectedDate!)
//         : DateFormat('yyyy-MM-dd').format(DateTime.now());

//     List<Map<String, String>> todayTasks = allTasks[dateKey] ?? [];

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             selectedDate != null
//                 ? "Schedule for ${DateFormat('MMMM d, yyyy').format(selectedDate!)}"
//                 : "Today's Schedule",
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           todayTasks.isEmpty
//               ? const Center(
//                   child: Text(
//                     "No events scheduled 📭",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 )
//               : ListView.builder(
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: todayTasks.length,
//                   itemBuilder: (context, index) {
//                     final task = todayTasks[index];
//                     return AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF6A5AE0),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               task["time"]!,
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 12),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Text(
//                               task["task"]!,
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diplomaapp/services/notification_service.dart';

class ScheduleWidget extends StatefulWidget {
  final DateTime? selectedDate;
  final Map<String, List<Map<String, String>>>? customTasks;

  const ScheduleWidget({super.key, this.selectedDate, this.customTasks});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  late Map<String, List<Map<String, String>>> _allTasks;

  @override
  void initState() {
    super.initState();
    _allTasks =
        widget.customTasks ??
        {
          '2025-04-20': [
            {"time": "10:00 AM", "task": "UI/UX Design Class"},
            {"time": "01:00 PM", "task": "Flutter LMS Dashboard Project"},
          ],
          '2025-04-21': [
            {"time": "09:00 AM", "task": "Data Structures Revision"},
            {"time": "04:00 PM", "task": "Team Meeting"},
          ],
          '2025-04-25': [
            {"time": "11:00 AM", "task": "Hackathon Preparation"},
            {"time": "03:00 PM", "task": "Research on Firebase Integration"},
          ],
        };
  }

  Future<void> _addNewTask() async {
    final _taskController = TextEditingController();
    final _timeController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _timeController,
                  decoration: const InputDecoration(
                    hintText: "Enter time (e.g., 02:00 PM)",
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    hintText: "Enter task name",
                  ),
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
                  if (_taskController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty) {
                    final dateKey =
                        widget.selectedDate != null
                            ? DateFormat(
                              'yyyy-MM-dd',
                            ).format(widget.selectedDate!)
                            : DateFormat('yyyy-MM-dd').format(DateTime.now());
                    final newTask = {
                      "time": _timeController.text.trim(),
                      "task": _taskController.text.trim(),
                    };
                    setState(() {
                      _allTasks.putIfAbsent(dateKey, () => []);
                      _allTasks[dateKey]!.add(newTask);
                    });
                    DateTime scheduledDateTime = DateFormat.jm().parse(
                      _timeController.text,
                    );
                    scheduledDateTime = DateTime(
                      widget.selectedDate?.year ?? DateTime.now().year,
                      widget.selectedDate?.month ?? DateTime.now().month,
                      widget.selectedDate?.day ?? DateTime.now().day,
                      scheduledDateTime.hour,
                      scheduledDateTime.minute,
                    );

                    NotificationService.scheduleNotification(
                      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                      title: 'Upcoming Task',
                      body: 'Task: ${_taskController.text}',
                      scheduledTime: scheduledDateTime.subtract(
                        const Duration(minutes: 10),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  Future<void> _editTask(int index, String time, String task) async {
    final _taskController = TextEditingController(text: task);
    final _timeController = TextEditingController(text: time);

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _timeController,
                  decoration: const InputDecoration(hintText: "Enter time"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    hintText: "Enter task name",
                  ),
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
                  if (_taskController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty) {
                    final dateKey =
                        widget.selectedDate != null
                            ? DateFormat(
                              'yyyy-MM-dd',
                            ).format(widget.selectedDate!)
                            : DateFormat('yyyy-MM-dd').format(DateTime.now());

                    setState(() {
                      _allTasks[dateKey]![index] = {
                        "time": _timeController.text.trim(),
                        "task": _taskController.text.trim(),
                      };
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String dateKey =
        widget.selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.selectedDate!)
            : DateFormat('yyyy-MM-dd').format(DateTime.now());

    List<Map<String, String>> todayTasks = _allTasks[dateKey] ?? [];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.selectedDate != null
                      ? "Schedule for ${DateFormat('MMMM d, yyyy').format(widget.selectedDate!)}"
                      : "Today's Schedule",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: _addNewTask,
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF6A5AE0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          todayTasks.isEmpty
              ? const Center(
                child: Text(
                  "No events scheduled 📭",
                  style: TextStyle(color: Colors.grey),
                ),
              )
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _allTasks[dateKey]!.removeAt(index);
                      });
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Task deleted")));
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _editTask(index, task["time"]!, task["task"]!);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6A5AE0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                task["time"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                task["task"]!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ScheduleWidget extends StatefulWidget {
//   final DateTime? selectedDate;
//   final Map<String, List<Map<String, String>>>? customTasks;

//   const ScheduleWidget({super.key, this.selectedDate, this.customTasks});

//   @override
//   State<ScheduleWidget> createState() => _ScheduleWidgetState();
// }

// class _ScheduleWidgetState extends State<ScheduleWidget> {
//   late Map<String, List<Map<String, String>>> _allTasks;

//   @override
//   void initState() {
//     super.initState();
//     _allTasks = widget.customTasks ?? {};
//   }

//   void _addTask(String time) async {
//     TextEditingController controller = TextEditingController();

//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('New Task'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: "Enter task name"),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 final dateKey = DateFormat('yyyy-MM-dd').format(widget.selectedDate ?? DateTime.now());
//                 final newTask = {
//                   "time": time,
//                   "task": controller.text,
//                 };
//                 setState(() {
//                   _allTasks.putIfAbsent(dateKey, () => []);
//                   _allTasks[dateKey]!.add(newTask);
//                 });
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String dateKey = widget.selectedDate != null
//         ? DateFormat('yyyy-MM-dd').format(widget.selectedDate!)
//         : DateFormat('yyyy-MM-dd').format(DateTime.now());

//     final List<Map<String, String>> todayTasks = _allTasks[dateKey] ?? [];

//     final List<String> hours = [
//       "09:00 AM",
//       "10:00 AM",
//       "11:00 AM",
//       "12:00 PM",
//       "01:00 PM",
//       "02:00 PM",
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Today's Schedule",
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 16),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: hours.length,
//             itemBuilder: (context, index) {
//               final hour = hours[index];
//               final taskAtHour = todayTasks.firstWhere(
//                 (task) => task["time"] == hour,
//                 orElse: () => {},
//               );

//               final bool hasTask = taskAtHour.isNotEmpty;

//               return GestureDetector(
//                 onTap: () {
//                   if (!hasTask) _addTask(hour);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                   decoration: BoxDecoration(
//                     color: hasTask ? const Color(0xFFE7E6FB) : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: hasTask
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               taskAtHour["task"] ?? "Task",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF6A5AE0),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               hour,
//                               style: const TextStyle(fontSize: 12, color: Colors.black54),
//                             ),
//                           ],
//                         )
//                       : Center(
//                           child: Icon(Icons.add, color: Colors.grey[500]),
//                         ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
