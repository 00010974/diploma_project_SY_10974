import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../auth/signup_ui_page.dart';

class LoginUIPage extends StatefulWidget {
  const LoginUIPage({super.key});

  @override
  State<LoginUIPage> createState() => _LoginUIPageState();
}

class _LoginUIPageState extends State<LoginUIPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();
  String? _error;

  Future<void> _signIn() async {
    try {
      setState(() => _error = null);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      await _auth.signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = "Unknown error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          // LEFT
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text("📘 Courses.",
                      style: GoogleFonts.montserrat(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Let’s sign in to your account",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 32),
                  _socialBtn("Google", Icons.g_mobiledata),
                  const SizedBox(height: 12),
                  _socialBtn("Facebook", Icons.facebook),
                  const SizedBox(height: 24),
                  const Center(child: Text("or sign in with email")),
                  const SizedBox(height: 24),
                  _textField(Icons.email, "Email", _emailController),
                  const SizedBox(height: 16),
                  _textField(Icons.lock, "Password", _passwordController, obscure: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?"),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A5AE0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Sign In", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 244, 243, 246))),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Doesn't have an account? ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const SignUpUIPage()),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Color(0xFF6A5AE0), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),

          // RIGHT
          if (width > 900)
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6A5AE0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        "Explore a Universe of\nKnowledge with Us!",
                        style: GoogleFonts.montserrat(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "The Courses Dashboard is your compass to a world of knowledge.\nFind, enroll, and dive into transformative courses.",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 32),
                      Image.network(
                        'https://i.imgur.com/Vz6FCOy.png',
                        width: 400,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _socialBtn(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
