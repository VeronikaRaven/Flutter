import 'package:flutter/material.dart';
import 'dictionary_screen.dart';
import 'tests_screen.dart';
import 'profile_screen.dart';

class WordsScreen extends StatefulWidget {
  final String selectedLevel;

  WordsScreen({required this.selectedLevel});

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
  Text('Слова'),
  DictionaryScreen(),
  TestsScreen(),
  ProfileScreen(),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уровень: ${widget.selectedLevel}'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Слова',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Словарь',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Тесты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}