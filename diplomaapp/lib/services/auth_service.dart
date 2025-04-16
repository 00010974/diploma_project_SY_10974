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



import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithEmail(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCred.user;
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<String> getUserRole(String uid) async {
    // Твоя реализация получения роли из Firestore
    return 'student';
  }
}
