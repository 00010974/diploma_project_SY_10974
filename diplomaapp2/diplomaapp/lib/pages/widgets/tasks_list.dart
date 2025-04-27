import 'package:flutter/material.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final List<Map<String, dynamic>> tasks = [
    {"title": "Finish Flutter LMS Dashboard", "done": false},
    {"title": "Study for Data Structures Exam", "done": false},
    {"title": "Submit Homework on Time", "done": true},
    {"title": "Join Group Project Call", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return _taskItem(index);
          },
        ),
      ],
    );
  }

  Widget _taskItem(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tasks[index]['done'] ? Colors.green[100] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: tasks[index]['done'] ? Colors.green : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: tasks[index]['done'],
            activeColor: const Color(0xFF6A5AE0),
            onChanged: (value) {
              setState(() {
                tasks[index]['done'] = value!;
              });
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
              child: Text(
                tasks[index]['title'],
                key: ValueKey<bool>(tasks[index]['done']),
                style: TextStyle(
                  fontSize: 14,
                  decoration: tasks[index]['done']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: tasks[index]['done'] ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
