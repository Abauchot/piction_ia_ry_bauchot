import 'package:flutter/material.dart';
import 'package:piction_ia_ry_bauchot/utils/theme.dart';
import 'package:piction_ia_ry_bauchot/forms/LoginForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piction-ai-ry',
      home: Login(),
      theme: AppTheme.lightTheme, // Use the custom theme
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piction-ai-ry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Add some space between the title and the form
            LoginForm(),
          ],
        ),
      ),
    );
  }
}