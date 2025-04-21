import 'package:flutter/material.dart';

class TimeSlotList extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const TimeSlotList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    const double hourHeight = 81.0; // Высота часа

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Верхняя панель недели
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Schedule Task",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Week ${DateTime.now().weekday} of ${DateTime.now().month}/${DateTime.now().year}",
                  style: const TextStyle(
                    color: Color(0xFF6A5AE0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Само тело таймлайна
          SizedBox(
            height: hourHeight * 10,
            child: Stack(
              children: [
                // Часы времени
                ...List.generate(10, (index) {
                  final hour = 8 + index;
                  final displayTime = TimeOfDay(hour: hour, minute: 0).format(context);

                  return Positioned(
                    top: index * hourHeight,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            displayTime,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE0E0E0),
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Карточки событий
                ...events.map((event) {
                  final int startHour = event['startHour'];
                  final int endHour = event['endHour'] ?? (startHour + 1);
                  final double top = (startHour - 8) * hourHeight;
                  final double height = (endHour - startHour) * hourHeight;

                  return Positioned(
                    top: top,
                    left: 80,
                    right: 16,
                    height: height,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (event['color'] ?? Colors.blue[100]).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: event['color'] ?? Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  event['title'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.more_vert, size: 18),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event['subtitle'] ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            event['time'] ?? '',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
