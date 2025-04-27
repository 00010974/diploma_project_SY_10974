import 'package:flutter/material.dart';

class NotificationPanel extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "🎉 Congratulations! You've Mastered the Course!",
      "time": "20 mins ago"
    },
    {
      "title": "📝 Your Opinion Matters! Share your thoughts.",
      "time": "1 hour ago"
    },
    {
      "title": "💳 Payment Success! Course journey begins.",
      "time": "1 week ago"
    },
    {
      "title": "🎉 Congratulations! You've Mastered another Course!",
      "time": "1 month ago"
    },
    {
      "title": "💳 Payment Success! Enrollment complete.",
      "time": "2 months ago"
    },
  ];

  NotificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.settings, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            ...notifications.map((notif) => _notificationItem(notif)).toList(),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text("See all"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(Map<String, String> notif) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notifications_active, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'] ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  notif['time'] ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
