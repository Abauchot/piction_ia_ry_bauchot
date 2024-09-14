import 'package:flutter/material.dart';
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
      home: TeamBuilding(),
      theme: AppTheme.lightTheme,
    );
  }
}

class TeamBuilding extends StatefulWidget {
  @override
  _TeamBuildingState createState() => _TeamBuildingState();
}
class _TeamBuildingState extends State<TeamBuilding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piction-ai-ry'),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center (
        child: Padding(
          padding : const EdgeInsets.all(16.0),
        )
      )
    );
  }
}