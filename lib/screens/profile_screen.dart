import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/progress.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dbHelper = DatabaseHelper();
  Progress? progress;
  String? selectedLevel;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadProgress();
    await _loadLanguageLevel();
  }

  Future<void> _loadProgress() async {
    final loadedProgress = await dbHelper.getProgress(1); // UserID = 1
    setState(() {
      progress = loadedProgress;
    });
  }

  Future<void> _loadLanguageLevel() async {
    final level = await dbHelper.getLanguageLevel();
    setState(() {
      selectedLevel = level;
    });
  }

  double _calculateSuccessRate() {
    if (progress == null || progress!.testsCompleted == 0) {
      return 0.0;
    }
    // 5 вопросов в каждом тесте
    final totalQuestions = progress!.testsCompleted * 5;
    return (progress!.wordsLearned / totalQuestions) * 100;
  }

  void _resetStatistics() async {
    await dbHelper.resetProgress(1); // UserID = 1
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Статистика успешно сброшена')),
    );
    _loadProgress();
  }

  void _deleteAccount() async {
    await dbHelper.deleteAccount(1); // UserID = 1
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Аккаунт успешно удален')),
    );
    _loadProgress();
  }

  void _resetLanguageLevel() async {
    await dbHelper.saveLanguageLevel('');
    setState(() {
      selectedLevel = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Уровень языка сброшен')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Language Level Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Текущий уровень',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        selectedLevel != null
                            ? 'Уровень: $selectedLevel'
                            : 'Уровень не выбран',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _resetLanguageLevel,
                            child: Text('Сбросить уровень'),
                          ),
                          ElevatedButton(
                            onPressed: _resetStatistics,
                            child: Text('Сбросить статистику'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Progress Statistics Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Статистика прогресса',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (progress != null) ...[
                        Text(
                          'Пройдено тестов: ${progress!.testsCompleted}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Выучено слов: ${progress!.wordsLearned}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Процент успешности: ${_calculateSuccessRate().toStringAsFixed(2)}%',
                          style: TextStyle(fontSize: 18),
                        ),
                      ] else
                        Text('Нет данных о прогрессе'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Account Management Section
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Управление аккаунтом',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _deleteAccount,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text('Удалить аккаунт'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}