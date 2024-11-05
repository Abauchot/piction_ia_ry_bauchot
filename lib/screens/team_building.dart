import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:piction_ia_ry_bauchot/player_services.dart';

class TeamBuilding extends StatefulWidget {
  final String gameId;

  const TeamBuilding({super.key, required this.gameId});

  @override
  _TeamBuildingState createState() => _TeamBuildingState();
}

class _TeamBuildingState extends State<TeamBuilding> {
  final storage = const FlutterSecureStorage();
  List<String> teamRed = [];
  List<String> teamBlue = [];

  @override
  void initState() {
    super.initState();
    _addPlayerToTeam();
  }

  Future<void> _addPlayerToTeam() async {
    final playerName = await storage.read(key: 'player_name');
    final token = await storage.read(key: 'auth_token');
    final apiUrl = dotenv.env['API_URL'];

    if (playerName == null || token == null || apiUrl == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la récupération des informations du joueur ou du token.'),
          ),
        );
      }
      return;
    }

    // Décider de la couleur de l'équipe
    String color;
    if (teamRed.length <= teamBlue.length) {
      color = 'red';
    } else {
      color = 'blue';
    }

    final url = Uri.parse('$apiUrl/game_sessions/${widget.gameId}/join');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'color': color,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Données de réponse: $responseData');

      await updateTeamNames(responseData, teamRed, teamBlue, apiUrl, token);

      if (mounted) {
        setState(() {});
      }
    } else {
      print('Statut de la réponse: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la récupération des données de la session de jeu.'),
          ),
        );
      }
    }
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
            children: <Widget>[
              const Text(
                'Team Building',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              PrettyQr(
                data: '${dotenv.env['API_URL']}/game_sessions/${widget.gameId}',
                errorCorrectLevel: QrErrorCorrectLevel.M,
                size: 200,
                roundEdges: true,
                elementColor: Colors.white,
              ),
              const SizedBox(height: 20),
              _buildTeamContainer('Équipe Rouge', teamRed, Colors.red),
              const SizedBox(height: 20),
              _buildTeamContainer('Équipe Bleue', teamBlue, Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'En attente que des joueurs rejoignent... 🕒 \n Partagez le code de jeu avec vos amis pour les inviter à rejoindre votre équipe !',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamContainer(String teamName, List<String> teamMembers, Color color) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$teamName\n',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: teamMembers.join('\n'),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
