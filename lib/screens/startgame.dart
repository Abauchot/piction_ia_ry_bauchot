import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:piction_ia_ry_bauchot/utils/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:piction_ia_ry_bauchot/component/qr_code_popup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piction-ai-ry',
      home: StartGame(),
      theme: AppTheme.lightTheme,
    );
  }
}

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

const storage = FlutterSecureStorage();

class _StartGameState extends State<StartGame> {
  Future<void> _createGame() async {
    final String apiUrl = '${dotenv.env['API_URL']}/game_sessions';

    try {
      final token = await storage.read(key: 'auth_token');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          // Ajoutez les données nécessaires pour créer une session de jeu
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Game session created successfully!'),
          ),
        );
        // Naviguer vers une autre page ou effectuer d'autres actions
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating game session: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please try again.'),
        ),
      );
    }
  }

  void _showQrCodeScannerPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 500,
          child: QrCodeScannerPopup(),
        );
      },
    ).then((scannedData) {
      if (scannedData != null) {
        // Traitez les données scannées ici
        print('Scanned QR Code: $scannedData');
        // Par exemple, naviguez vers une autre page avec ces données
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piction-ai-ry'),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Hello, ready to play ? 🎨',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Piction.ia.ry est un jeu pour 4 joueurs en 2 équipes, où un joueur doit dessiner '
                    'une image sans utiliser des mots interdits, et l\'autre doit deviner le défi. '
                    'Les rôles changent à chaque manche, et le jeu continue jusqu\'à ce que tous les défis soient résolus '
                    'ou que le temps soit écoulé. Les erreurs coûtent des points, et chaque mot correct en rapporte.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _createGame,
                icon: const Icon(Icons.group),
                label: const Text('Create a new game'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showQrCodeScannerPopup,
                icon: const Icon(Icons.qr_code),
                label: const Text('Join a game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
