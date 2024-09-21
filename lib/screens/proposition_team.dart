import 'package:flutter/material.dart';
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
      home: PropositionTeam(),
      theme: ThemeData.light(), // Utiliser le thème clair
    );
  }
}

class PropositionTeam extends StatefulWidget {
  @override
  _PropositionState createState() => _PropositionState();
}

class _PropositionState extends State<PropositionTeam> {
  late Timer _timer;
  int _start = 300; // 300 secondes
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
            const Center(
              child: Text(
                'Les propositions de votre équipier',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Image.asset('lib/utils/images/Becca.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPlaceholderPhrase('Phrase 1'),
            const SizedBox(height: 8),
            _buildPlaceholderPhrase('Phrase 2'),
            const SizedBox(height: 8),
            _buildPlaceholderPhrase('Phrase 3'),
            const SizedBox(height: 8),
            _buildPlaceholderPhrase('Phrase 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderPhrase(String phrase) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        phrase,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}