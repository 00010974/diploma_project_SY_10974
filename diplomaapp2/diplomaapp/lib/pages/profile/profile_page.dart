// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../services/auth_service.dart';
// import 'edit_profile_page.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';


// class ProfilePage extends StatelessWidget {
//   final User user;


//   const ProfilePage({super.key, required this.user});

//   Future<Map<String, dynamic>> _fetchUserProfile() async {
//     final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//     return doc.data() ?? {};
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Supabase.instance.client.auth.currentUser;
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text('Profile', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _fetchUserProfile(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final data = snapshot.data ?? {};
//           final photoUrl = data['photoUrl'] ?? 'https://i.imgur.com/BoN9kdC.png';
//           final about = data['about'] ?? "Learning is my passion. I love coding, building apps, and improving myself every day!";

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(photoUrl),
//                   backgroundColor: Colors.grey,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   user.displayName ?? "No Name",
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 FutureBuilder<String>(
//                   future: AuthService().getUserRole(user.uid),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     }
//                     final role = snapshot.data ?? 'student';
//                     return Text(
//                       role[0].toUpperCase() + role.substring(1),
//                       style: const TextStyle(color: Colors.grey, fontSize: 16),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   user.email ?? "No email",
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => EditProfilePage(user: FirebaseAuth.instance.currentUser!),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF6A5AE0),
//                     minimumSize: const Size(160, 48),
//                   ),
//                   child: const Text('Edit Profile'),
//                 ),
//                 const SizedBox(height: 32),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'About',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   about,
//                   style: const TextStyle(fontSize: 16, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 48),
//                 ElevatedButton.icon(
//                   onPressed: () async {
//                     await AuthService().signOut();
//                   },
//                   icon: const Icon(Icons.logout),
//                   label: const Text("Log Out"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     minimumSize: const Size(200, 48),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>?> _fetchUserProfile(String userId) async {
    final response = await Supabase.instance.client
        .from('students')
        .select()
        .eq('id', userId)
        .maybeSingle();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user found")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserProfile(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong...",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data ?? {};
          final fullName = data['full_name'] ?? 'Unknown User';
          final email = data['email'] ?? 'No email';
          final role = data['role'] ?? 'student';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  role[0].toUpperCase() + role.substring(1),
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Здесь можно потом сделать переход на EditProfilePage
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Editing is coming soon!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A5AE0),
                    minimumSize: const Size(160, 48),
                  ),
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data['about'] ?? "Learning is my passion. I love coding, building apps, and improving myself every day!",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Log Out"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(200, 48),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
