import 'package:flutter/material.dart';
import 'package:piction_ia_ry_bauchot/utils/theme.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piction-ai-ry',
      home: PromptChallenge(),
      theme: AppTheme.lightTheme, // Use the custom theme
    );
  }
}

class PromptChallenge extends StatefulWidget {
  @override
  _PromptChallengeState createState() => _PromptChallengeState();
}

class _PromptChallengeState extends State<PromptChallenge> {
  late Timer _timer;
  int _start = 300; //normally 300
  String _timeMessage = '';
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timeMessage = 'Temps écoulé';
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piction-ai-ry'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _start > 0
                    ? 'Temps restant: ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}'
                    : _timeMessage,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Votre challenge',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Placeholder d\'une phrase',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildForbiddenWord('Mot 1'),
                      _buildForbiddenWord('Mot 2'),
                      _buildForbiddenWord('Mot 3'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 300, // Adjusted height
              width: double.infinity, // Adjusted width to take full width
              child: Center(
                child: Image.asset('lib/utils/images/Becca.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Action for regenerating the image
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Regénérer (-50 pts)'),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                    onPressed: () {
                      // Action for sending the image
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Envoyer')
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promptController,
                      decoration: const InputDecoration(
                        labelText: 'Entrez le prompt de l\'image',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.upload),
                    onPressed: () {
                      // Action for uploading the prompt
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForbiddenWord(String word) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.red,
      child: Text(
        word,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}