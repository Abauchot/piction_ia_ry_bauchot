import 'package:flutter/material.dart';
import 'package:piction_ia_ry_bauchot/forms/ChallengeForm.dart';
import 'package:piction_ia_ry_bauchot/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piction-ai-ry',
      home: ChallengeCreation(),
      theme: AppTheme.lightTheme, // Use the custom theme
    );
  }
}

class ChallengeCreation extends StatefulWidget {
  @override
  _ChallengeCreationState createState() => _ChallengeCreationState();
}

class _ChallengeCreationState extends State<ChallengeCreation> {
  final List<Map<String, String>> _challenges = [];
  void _addChallenge() {
    final form = ChallengeForm(firstWord: "", secondWord: "", description: "", forbidden1: "", forbidden2: "", forbidden3: "", errorMessage: "");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ajout d\'un challenge'),
              content: SingleChildScrollView(
                child: form,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (form.firstWord.isEmpty || form.secondWord.isEmpty || form.description.isEmpty) {
                      setState(() {
                        form.errorMessage = 'Veuillez remplir tous les champs requis.';
                      });
                    } else {
                      setState(() {
                        int challengeNumber = _challenges.length + 1;
                        _challenges.add({
                          'title': 'Challenge#$challengeNumber',
                          'description': '${form.firstWord} ${form.description} ${form.secondWord}',
                          'forbidden1': form.forbidden1,
                          'forbidden2': form.forbidden2,
                          'forbidden3': form.forbidden3,
                        });
                      });
                      Navigator.of(context).pop();
                      setState(() {}); // Ensure the state is updated
                    }
                  },
                  child: const Text('Ajouter'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(() {}); // Ensure the state is updated after the dialog is closed
    });
  }

  void _removeChallenge(int index) {
    setState(() {
      _challenges.removeAt(index);
    });
  }

  void _sendChallenge(int index) {
    // Placeholder function to send the challenge to the other team
    print('Challenge sent: ${_challenges[index]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piction-ai-ry'),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _challenges.length,
              itemBuilder: (context, index) {
                final challenge = _challenges[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(challenge['description']!),
                        const SizedBox(height: 8),
                        const Text(
                          'Mots interdits:',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${challenge['forbidden1']}, ${challenge['forbidden2']}, ${challenge['forbidden3']}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeChallenge(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send, color: Colors.blue),
                              onPressed: () => _sendChallenge(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _addChallenge,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un nouveau challenge'),
            ),
          ),
        ],
      ),
    );
  }
}