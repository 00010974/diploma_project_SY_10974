import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notification_panel.dart';
import '../../services/auth_service.dart';
import 'package:diplomaapp/pages/basket/basket_page.dart';
import 'package:diplomaapp/pages/profile/profile_page.dart';


class TopBar extends StatefulWidget {
  final String pageTitle;

  const TopBar({super.key, required this.pageTitle});
  

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String userName = "Student";

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    userName = user?.userMetadata?['full_name'] ?? user?.email?.split('@')[0] ?? 'Student';
  }

  void _openNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.only(top: 80, right: 40),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Название страницы
          Text(
            widget.pageTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),

          // Иконка поиска
          IconButton(icon: const Icon(Icons.search, size: 28), onPressed: () {}),

          const SizedBox(width: 8),

          // Корзина
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BasketPage()),
              );
            },
          ),

          // Уведомления
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 28),
            onPressed: () {
              _openNotifications(context);
            },
          ),


          
          // Аватар + меню
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                _logout(context);
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(),
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
      ),
    );
  }
}
