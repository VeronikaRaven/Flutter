import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/word.dart';
import '../models/progress.dart';
import 'dart:math';

class TestCategoryScreen extends StatefulWidget {
  final String category;

  const TestCategoryScreen({required this.category});

  @override
  _TestCategoryScreenState createState() => _TestCategoryScreenState();
}

class _TestCategoryScreenState extends State<TestCategoryScreen> {
  final dbHelper = DatabaseHelper();
  List<Word> allWords = [];
  List<Word> testWords = [];
  int score = 0;
  int currentQuestionIndex = 0;
  bool isLoading = true;
  String? errorMessage;
  bool isReverseQuestion = false; // false = de->ru, true = ru->de
  late Word currentWord;

  @override
  void initState() {
    super.initState();
    _loadWords();
    _initializeUserProgress();
  }

  Future<void> _initializeUserProgress() async {
    await dbHelper.initializeUserProgress(1);
  }

  Future<void> _loadWords() async {
    try {
      final loadedWords = await dbHelper.getWords();
      setState(() {
        allWords = loadedWords;
        testWords = loadedWords
            .where((word) => word.category == widget.category)
            .toList();

        if (testWords.length < 3) {
          errorMessage = 'Для теста нужно минимум 3 слова в категории';
        } else {
          testWords = testWords.take(5).toList();
          testWords.shuffle();
          _prepareQuestion();
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Ошибка загрузки слов: $e';
        isLoading = false;
      });
    }
  }

  void _prepareQuestion() {
    if (currentQuestionIndex < testWords.length) {
      // Случайно выбираем направление перевода (50/50)
      isReverseQuestion = Random().nextBool();
      currentWord = testWords[currentQuestionIndex];
    }
  }

  List<Map<String, dynamic>> _generateAnswerOptions() {
    // Для правильного ответа
    final correctAnswer = isReverseQuestion 
        ? currentWord.word 
        : currentWord.translation;

    // Собираем все возможные неправильные варианты
    final allPossibleOptions = allWords
        .where((word) => word.id != currentWord.id)
        .toList();

    // Выбираем уникальные варианты (исключая дубликаты)
    final uniqueOptions = <Word>[];
    final usedTranslations = <String>{correctAnswer};

    for (var word in allPossibleOptions) {
      final option = isReverseQuestion ? word.word : word.translation;
      if (!usedTranslations.contains(option)) {
        usedTranslations.add(option);
        uniqueOptions.add(word);
        if (uniqueOptions.length >= 2) break;
      }
    }

    // Если не набрали 2 уникальных варианта, добавляем любые
    while (uniqueOptions.length < 2 && allPossibleOptions.isNotEmpty) {
      final word = allPossibleOptions.removeLast();
      final option = isReverseQuestion ? word.word : word.translation;
      if (!usedTranslations.contains(option)) {
        uniqueOptions.add(word);
        usedTranslations.add(option);
      }
    }

    // Формируем варианты ответов
    final options = [
      {
        'text': correctAnswer,
        'isCorrect': true,
        'isWord': isReverseQuestion,
      },
      {
        'text': isReverseQuestion ? uniqueOptions[0].word : uniqueOptions[0].translation,
        'isCorrect': false,
        'isWord': isReverseQuestion,
      },
      {
        'text': uniqueOptions.length > 1 
            ? (isReverseQuestion ? uniqueOptions[1].word : uniqueOptions[1].translation)
            : 'Нет варианта', // fallback, теоретически не должно случиться
        'isCorrect': false,
        'isWord': isReverseQuestion,
      },
    ]..shuffle();

    return options;
  }

  void _nextQuestion(bool isCorrect) async {
    if (isCorrect) {
      setState(() => score++);
      final currentProgress = await dbHelper.getProgress(1);
      if (currentProgress != null) {
        await dbHelper.updateProgress(Progress(
          userId: currentProgress.userId,
          wordsLearned: currentProgress.wordsLearned + 1,
          lessonsCompleted: currentProgress.lessonsCompleted,
          testsCompleted: currentProgress.testsCompleted,
        ));
      }
    }

    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex < testWords.length) {
        _prepareQuestion();
      }
    });
  }

  void _finishTest() async {
    final progress = await dbHelper.getProgress(1);
    if (progress != null) {
      await dbHelper.updateProgress(Progress(
        userId: progress.userId,
        wordsLearned: progress.wordsLearned,
        lessonsCompleted: progress.lessonsCompleted,
        testsCompleted: progress.testsCompleted + 1,
      ));
    }
    Navigator.pop(context);
  }

  Widget _buildQuestion() {
    final options = _generateAnswerOptions();
    final questionText = isReverseQuestion
        ? 'Как будет по-немецки "${currentWord.translation}"?'
        : 'Как переводится слово "${currentWord.word}"?';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Вопрос ${currentQuestionIndex + 1}/5:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          questionText,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 30),
        ...options.map((option) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => _nextQuestion(option['isCorrect']),
              child: Text(
                option['text'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        )).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Загрузка...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Ошибка')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Вернуться'),
              ),
            ],
          ),
        ),
      );
    }

    if (currentQuestionIndex >= testWords.length) {
      return Scaffold(
        appBar: AppBar(title: Text('Результат')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Тест завершен!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Правильных ответов: $score из 5',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Процент успеха: ${(score / 5 * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _finishTest,
                child: Text('Завершить'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Тест: ${widget.category}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildQuestion(),
      ),
    );
  }
}