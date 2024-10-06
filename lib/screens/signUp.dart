import 'package:flutter/material.dart';
import 'package:piction_ia_ry_bauchot/utils/theme.dart';
import 'package:piction_ia_ry_bauchot/forms/SignUpForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piction-ai-ry',
      home: SignUp(),
      theme: AppTheme.lightTheme, // Use the custom theme
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PiCtion-ai-ry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign up !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Add some space between the title and the form
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
