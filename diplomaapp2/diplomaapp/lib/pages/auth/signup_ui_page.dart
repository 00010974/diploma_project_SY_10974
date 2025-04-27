import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  String _selectedRole = 'student'; // Default role
  String? _error;
  bool _isLoading = false;

  Future<void> _signUp() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });

    try {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        setState(() {
          _error = "Passwords do not match!";
          _isLoading = false;
        });
        return;
      }

      // Register user
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name, 'role': _selectedRole},
      );

      final user = response.user;

      if (user == null) {
        setState(() {
          _error = "Registration failed. Please try again.";
          _isLoading = false;
        });
        return;
      }

      // Добавляем в таблицу 'students' или 'teachers'
      final table = _selectedRole == 'instructor' ? 'teachers' : 'students';
      await Supabase.instance.client.from(table).insert({
        'id': user.id,
        'full_name': name,
        'email': email,
        'role': _selectedRole,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/'); // Go to login
      }
    } on AuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (e) {
      setState(() {
        _error = "Unknown error occurred";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                  Text(
                    "📘 Register.",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),

                  _textField(Icons.person, "Name", _nameController),
                  const SizedBox(height: 16),
                  _textField(Icons.email, "Email", _emailController),
                  const SizedBox(height: 16),
                  _textField(
                    Icons.lock,
                    "Password",
                    _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  _textField(
                    Icons.lock,
                    "Confirm Password",
                    _confirmPasswordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 24),

                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Select your role",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'student',
                        child: Text("Student"),
                      ),
                      DropdownMenuItem(
                        value: 'instructor',
                        child: Text("Instructor"),
                      ),
                      DropdownMenuItem(value: 'admin', child: Text("Admin")),
                    ],
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  ],

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A5AE0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
                decoration: const BoxDecoration(color: Color(0xFF6A5AE0)),
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

  Widget _textField(
    IconData icon,
    String hint,
    TextEditingController controller, {
    bool obscure = false,
  }) {
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
