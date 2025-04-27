import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpUIPage extends StatefulWidget {
  const SignUpUIPage({super.key});

  @override
  State<SignUpUIPage> createState() => _SignUpUIPageState();
}

class _SignUpUIPageState extends State<SignUpUIPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _selectedRole = 'student'; // 👈 выбранная роль
  String? _error;

  Future<void> _signUp() async {
    try {
      setState(() => _error = null);

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        setState(() => _error = "Passwords do not match!");
        return;
      }

      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCred.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'role': _selectedRole, // 👈 сохраняем выбранную роль
          'createdAt': DateTime.now(),
        });
      
        if (_selectedRole == 'instructor') {
          Navigator.pushReplacementNamed(context, '/teacherDashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/studentDashboard');
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = "Unknown error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text("📘 Register.",
                      style: GoogleFonts.montserrat(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Create a new account",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 32),

                  // 👤 Поля для ввода
                  _textField(Icons.person, "Name", _nameController),
                  const SizedBox(height: 16),
                  _textField(Icons.email, "Email", _emailController),
                  const SizedBox(height: 16),
                  _textField(Icons.lock, "Password", _passwordController, obscure: true),
                  const SizedBox(height: 16),
                  _textField(Icons.lock, "Confirm Password", _confirmPasswordController, obscure: true),

                  const SizedBox(height: 24),
                  // 👑 Выбор роли
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      labelText: "Select your role",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: 'student', child: Text("Student")),
                      DropdownMenuItem(value: 'instructor', child: Text("Instructor")),
                      DropdownMenuItem(value: 'admin', child: Text("Admin")),
                    ],
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],

                  const SizedBox(height: 24),

                  // 🔥 Кнопка регистрации
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A5AE0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 233, 232, 240))),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),

          // 🟪 Правая часть (картинка/промо)
          if (width > 900)
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6A5AE0),
                ),
                child: Center(
                  child: Image.network(
                    'https://i.imgur.com/Vz6FCOy.png',
                    width: 400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _textField(IconData icon, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
