import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final void Function(DateTime selectedDay)? onDaySelected;

  const CalendarWidget({super.key, this.onDaySelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime today = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(today.year, today.month, 1);
    final lastDayOfMonth = DateTime(today.year, today.month + 1, 0);
    final totalDays = lastDayOfMonth.day;
    final weekDayOfFirst = firstDayOfMonth.weekday;

    final Map<int, List<String>> events = {
      5: ["Exam"],
      10: ["Deadline"],
      15: ["Hackathon"],
      20: ["Meeting"],
      25: ["Holiday"],
    };

    List<Widget> dayWidgets = [];

    // Пустые клетки
    for (int i = 1; i < weekDayOfFirst; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Дни месяца
    for (int day = 1; day <= totalDays; day++) {
      final isToday = day == today.day;
      final isSelected = selectedDay?.day == day;
      final hasEvent = events.containsKey(day);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDay = DateTime(today.year, today.month, day);
            });
            if (widget.onDaySelected != null) {
              widget.onDaySelected!(selectedDay!);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6A5AE0)
                        : (isToday ? Colors.grey[400] : Colors.grey[200]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                        color: isSelected || isToday ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              hasEvent
                  ? Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : const Color(0xFF6A5AE0),
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox(height: 6),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('MMMM yyyy').format(today),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 7 / 5.5,
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: dayWidgets,
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatefulWidget {
//   final Function(DateTime)? onDaySelected;

//   const CalendarWidget({super.key, this.onDaySelected});

//   @override
//   State<CalendarWidget> createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
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
//       child: TableCalendar(
//         firstDay: DateTime.utc(2020, 1, 1),
//         lastDay: DateTime.utc(2030, 12, 31),
//         focusedDay: _focusedDay,
//         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//           if (widget.onDaySelected != null) {
//             widget.onDaySelected!(selectedDay);
//           }
//         },
//         calendarStyle: CalendarStyle(
//           todayDecoration: BoxDecoration(
//             color: Colors.grey[300],
//             shape: BoxShape.circle,
//           ),
//           selectedDecoration: BoxDecoration(
//             color: const Color(0xFF6A5AE0),
//             shape: BoxShape.circle,
//           ),
//           selectedTextStyle: const TextStyle(color: Colors.white),
//           todayTextStyle: const TextStyle(color: Colors.black),
//           markersAlignment: Alignment.bottomCenter,
//           markerSizeScale: 0.2,
//           markerDecoration: BoxDecoration(
//             color: const Color(0xFF6A5AE0),
//             shape: BoxShape.circle,
//           ),
//         ),
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: true,
//           leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
//           rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
//           titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         daysOfWeekStyle: const DaysOfWeekStyle(
//           weekdayStyle: TextStyle(color: Colors.grey),
//           weekendStyle: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatefulWidget {
//   final Function(DateTime)? onDaySelected;
//   final Map<DateTime, List<String>>? events;

//   const CalendarWidget({super.key, this.onDaySelected, this.events});

//   @override
//   State<CalendarWidget> createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   List<String> _getEventsForDay(DateTime day) {
//     return widget.events?[DateTime.utc(day.year, day.month, day.day)] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
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
//       child: TableCalendar(
//         firstDay: DateTime.utc(2020, 1, 1),
//         lastDay: DateTime.utc(2030, 12, 31),
//         focusedDay: _focusedDay,
//         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//         eventLoader: _getEventsForDay,
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//           if (widget.onDaySelected != null) {
//             widget.onDaySelected!(selectedDay);
//           }
//         },
//         calendarStyle: CalendarStyle(
//           todayDecoration: BoxDecoration(
//             color: Colors.grey[300],
//             shape: BoxShape.circle,
//           ),
//           selectedDecoration: BoxDecoration(
//             color: const Color(0xFF6A5AE0),
//             shape: BoxShape.circle,
//           ),
//           selectedTextStyle: const TextStyle(color: Colors.white),
//           todayTextStyle: const TextStyle(color: Colors.black),
//           markersAlignment: Alignment.bottomCenter,
//           markerDecoration: const BoxDecoration(
//             color: Color(0xFF6A5AE0),
//             shape: BoxShape.circle,
//           ),
//         ),
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: true,
//           leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
//           rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
//           titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         daysOfWeekStyle: const DaysOfWeekStyle(
//           weekdayStyle: TextStyle(color: Colors.grey),
//           weekendStyle: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }
