import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<String> fetchPlayerName(int playerId, String apiUrl, String token) async {
  final url = Uri.parse('$apiUrl/players/$playerId');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['name'];
  } else {
    print('Échec de la récupération du nom du joueur pour l\'ID: $playerId');
    return 'Inconnu';
  }
}

Future<void> updateTeamNames(
    Map<String, dynamic> responseData,
    List<String> teamRed,
    List<String> teamBlue,
    String apiUrl,
    String token,
    ) async {
  // get names for red team
  if (responseData['red_team'] != null) {
    teamRed.clear();
    teamRed.addAll(await Future.wait(
      (responseData['red_team'] as List<dynamic>).map(
            (id) => fetchPlayerName(id as int, apiUrl, token),
      ),
    ));
  } else {
    teamRed.clear();
  }
  // get names for blue team
  if (responseData['blue_team'] != null) {
    teamBlue.clear();
    teamBlue.addAll(await Future.wait(
      (responseData['blue_team'] as List<dynamic>).map(
            (id) => fetchPlayerName(id as int, apiUrl, token),
      ),
    ));
  } else {
    teamBlue.clear();
  }
}
