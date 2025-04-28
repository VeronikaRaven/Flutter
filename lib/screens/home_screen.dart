import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'main_app_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper();
  String? selectedLevel;

  @override
  void initState() {
    super.initState();
    _loadLanguageLevel();
  }

  Future<void> _loadLanguageLevel() async {
    final level = await dbHelper.getLanguageLevel();
    if (level != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAppScreen(selectedLevel: level)),
      );
    }
  }

  void _navigateToMainApp(BuildContext context) {
    if (selectedLevel != null) {
      dbHelper.saveLanguageLevel(selectedLevel!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainAppScreen(selectedLevel: selectedLevel!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, выберите уровень')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор уровня'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedLevel,
              hint: Text('Выберите уровень'),
              items: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLevel = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToMainApp(context),
              child: Text('Начать обучение'),
            ),
          ],
        ),
      ),
    );
  }
}