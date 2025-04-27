// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   Future<User?> registerWithEmail(
//     String email,
//     String password,
//     String role,
//   ) async {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     User? user = result.user;

//     // Save role in Firestore
//     await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
//       'email': email,
//       'role': role,
//     });
//     return user;
//   }

//   Future<User?> signInWithEmail(String email, String password) async {
//     UserCredential result = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return result.user;
//   }

//   Future<void> signOut() async => await _auth.signOut();

//   Future<String> getUserRole(String uid) async {
//     final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     return doc['role'] ?? 'student';
//   }
// }



import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Stream для отслеживания состояния авторизации
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Вход с email и паролем
  Future<User?> signInWithEmail(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  // Выход
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Получение роли пользователя по его ID
  Future<String> getUserRole(String userId) async {
    final response = await _supabase
        .from('students')
        .select('role')
        .eq('id', userId)
        .maybeSingle();

    if (response != null && response['role'] != null) {
      return response['role'] as String;
    } else {
      return 'student'; // дефолтная роль
    }
  }
}

