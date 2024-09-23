import 'package:flutter/material.dart';

class ChallengeForm extends StatefulWidget {

  String firstWord = '';
  String secondWord = '';
  String description = '';
  String forbidden1 = '';
  String forbidden2 = '';
  String forbidden3 = '';
  String errorMessage = '';

  ChallengeForm({super.key, required this.firstWord, required this.secondWord, required this.description, required this.forbidden1, required this.forbidden2, required this.forbidden3, required this.errorMessage});

  @override
  State<ChallengeForm> createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Premier mot'),
          onChanged: (value) {
            widget.firstWord = value;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.description = 'SUR';
                });
              },
              child: const Text('SUR'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.description = 'DANS';
                });
              },
              child: const Text('DANS'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.description += ' UN';
                });
              },
              child: const Text('UN'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.description += ' UNE';
                });
              },
              child: const Text('UNE'),
            ),
          ],
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Deuxième mot'),
          onChanged: (value) {
            widget.secondWord = value;
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Mot interdit 1'),
          onChanged: (value) {
            widget.forbidden1 = value;
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Mot interdit 2'),
          onChanged: (value) {
            widget.forbidden2 = value;
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Mot interdit 3'),
          onChanged: (value) {
            widget.forbidden3 = value;
          },
        ),
        if (widget.errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
