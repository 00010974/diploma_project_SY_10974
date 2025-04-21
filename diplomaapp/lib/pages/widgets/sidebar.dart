import 'package:flutter/material.dart';
import 'package:diplomaapp/pages/schedule/schedulePage.dart';
import 'package:diplomaapp/pages/message/message_page.dart';
import 'package:diplomaapp/pages/dashboard/student_dashboard.dart';

class Sidebar extends StatefulWidget {
  final String selectedMenu;

  const Sidebar({super.key, required this.selectedMenu});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  bool _isCollapsed = false;
  late AnimationController _controller;

  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  void _toggleSidebar() {
    setState(() {
      _isCollapsed = !_isCollapsed;
      _isCollapsed ? _controller.forward() : _controller.reverse();
    });
  }

  void _onMenuSelect(String menuName) {
    if (menuName == widget.selectedMenu) {
      return; // Если уже выбран - ничего не делаем
    }

    if (menuName == "Schedule") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SchedulePage()),
      );
    } else if (menuName == "Dashboard") {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => const StudentDashboard()),
        );
    }else if (menuName == "Message") {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => MessagePage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      _isCollapsed = true; // Always collapsed on mobile
    }

    return AnimatedContainer(
      duration: _duration,
      width: _isCollapsed ? 70 : 250,
      color: Colors.white,
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _navItem(Icons.dashboard, "Dashboard"),
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
          _buildCollapseButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _isCollapsed
          ? const Icon(Icons.menu_book, size: 32, color: Color(0xFF6A5AE0))
          : Row(
              children: const [
                Icon(Icons.menu_book, color: Color(0xFF6A5AE0), size: 32),
                SizedBox(width: 12),
                Text(
                  "Courses.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
    );
  }

  Widget _navItem(IconData icon, String label) {
    final bool isSelected = widget.selectedMenu == label;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        color: isSelected ? const Color(0xFFE7E6FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _onMenuSelect(label),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Tooltip(
                  message: _isCollapsed ? label : "",
                  child: Icon(
                    icon,
                    color: isSelected ? const Color(0xFF6A5AE0) : Colors.black54,
                  ),
                ),
                if (!_isCollapsed) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF6A5AE0) : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapseButton() {
    return IconButton(
      icon: Icon(_isCollapsed ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left),
      onPressed: _toggleSidebar,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
