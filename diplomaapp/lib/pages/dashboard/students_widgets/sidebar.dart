import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Логотип
            Row(
              children: const [
                Icon(Icons.menu_book, color: Color(0xFF6A5AE0), size: 28),
                SizedBox(width: 8),
                Text(
                  "Courses.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),

            // Навигация
            Expanded(
              child: ListView(
                children: [
                  _navItem(Icons.dashboard, "Dashboard", selected: true),
                  _navItem(Icons.schedule, "Schedule"),
                  _navItem(Icons.message, "Message"),
                  _navItem(Icons.payment, "Payment"),
                  const Divider(height: 32),
                  _navItem(Icons.book, "My Courses"),
                  _navItem(Icons.explore, "Discover"),
                  const Divider(height: 32),
                  _navItem(Icons.support_agent, "Support"),
                  _navItem(Icons.settings, "Setting"),
                ],
              ),
            ),

            // Блок рекламы снизу
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6A5AE0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "24/7 Access to Your Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 36),
                    ),
                    child: Text(
                      "Get Premium",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: selected
          ? BoxDecoration(
              color: const Color(0xFFE7E6FB),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: ListTile(
        leading: Icon(icon, color: selected ? const Color(0xFF6A5AE0) : Colors.black54),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF6A5AE0) : Colors.black87,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          // Навигация по клику можно настроить позже
        },
      ),
    );
  }
}
