import 'package:flutter/material.dart';
import 'words_screen.dart'; // Экран всех слов
import 'dictionary_screen.dart'; // Экран словаря
import 'tests_screen.dart'; // Экран тестов
import 'profile_screen.dart'; // Экран профиля

class MainAppScreen extends StatelessWidget {
  final String selectedLevel;

  MainAppScreen({required this.selectedLevel});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Количество вкладок
      child: Scaffold(
        appBar: AppBar(
          title: Text('Уровень: $selectedLevel'),
          bottom: TabBar(
            isScrollable: true, // Вкладки можно прокручивать
            tabs: [
              Tab(text: 'Алфавит'), // Текстовая вкладка
              Tab(text: 'Словарь'), // Текстовая вкладка
              Tab(text: 'Тесты'), // Текстовая вкладка
              Tab(text: 'Профиль'), // Текстовая вкладка
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WordsScreen(), // Экран всех слов
            DictionaryScreen(), // Экран словаря
            TestsScreen(), // Экран тестов
            ProfileScreen(), // Экран профиля
          ],
        ),
      ),
    );
  }
}