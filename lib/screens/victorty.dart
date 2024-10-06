import 'package:flutter/material.dart';
import '../component/school_pride_confetti.dart';

class Victory extends StatefulWidget {
  @override
  _VictoryState createState() => _VictoryState();
}

class _VictoryState extends State<Victory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Victoire'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Victoire de l\'équipe [Nom de l\'équipe]',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildTeamSummary('Résumé de la partie des rouges'),
                      const SizedBox(height: 20),
                      buildTeamSummary('Résumé de la partie des bleus'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SchoolPrideConfetti(), // Add the confetti component here
        ],
      ),
    );
  }

  Widget buildTeamSummary(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        buildPlayerRow('placeholder', ''),
        const SizedBox(height: 10),
        buildPlayerRow('placeholder', ''),
        const SizedBox(height: 10),
        buildPlayerRow('placeholder', ''),
      ],
    );
  }

  Widget buildPlayerRow(String playerName, String score) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'lib/utils/images/Becca.jpg', // Placeholder pour l'image
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(playerName, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      buildTag('Poulet'),
                      buildTag('Volaille'),
                      buildTag('Oiseau'),
                    ],
                  ),
                ],
              ),
            ),
            Text(score, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget buildTag(String tag) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}