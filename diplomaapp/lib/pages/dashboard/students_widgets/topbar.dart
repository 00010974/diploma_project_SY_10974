import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notification_panel.dart';
import '../../../services/auth_service.dart'; // для выхода
import 'package:diplomaapp/pages/profile/profile_page.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String userName = "Student";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? user?.email?.split('@')[0] ?? 'Student';
  }

  void _openNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.only(top: 80, right: 40),
        alignment: Alignment.topRight,
        child: NotificationPanel(),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Welcome text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back 👋",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),

        // Search icon
        IconButton(
          icon: const Icon(Icons.search, size: 28),
          onPressed: () {},
        ),
        const SizedBox(width: 8),

        // Notification icon
        IconButton(
          icon: const Icon(Icons.notifications_none, size: 28),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => Dialog(
                    insetPadding: const EdgeInsets.only(top: 80, right: 40),
                    alignment: Alignment.topRight,
                    child: NotificationPanel(),
                  ),
            );
          },
        ),

        // Profile Avatar с выпадающим меню
        PopupMenuButton<String>(
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onSelected: (value) {
            if (value == 'logout') {
              _logout(context);
            } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(user: FirebaseAuth.instance.currentUser!),
                  ),
                );
            } else if (value == 'settings') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings page coming soon!')),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('My Profile'),
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          ],
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
