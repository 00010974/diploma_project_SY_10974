import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '', role = 'student';
  bool isLogin = true;

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(onChanged: (v) => email = v, decoration: InputDecoration(labelText: 'Email')),
            TextField(onChanged: (v) => password = v, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            if (!isLogin)
              DropdownButton<String>(
                value: role,
                items: ['student', 'instructor'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (v) => setState(() => role = v!),
              ),
            ElevatedButton(
              child: Text(isLogin ? 'Login' : 'Register'),
              onPressed: () async {
                if (isLogin) await _auth.signInWithEmail(email, password);
                else await _auth.registerWithEmail(email, password, role);
              },
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin ? 'No account? Register' : 'Have an account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
