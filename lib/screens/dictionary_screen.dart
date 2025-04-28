import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/word.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final dbHelper = DatabaseHelper();
  List<Word> words = [];
  List<Word> favoriteWords = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final allWords = await dbHelper.getWords();
    final favWords = allWords.where((word) => word.isFavorite).toList();
    setState(() {
      favoriteWords = favWords;
      if (selectedCategory != null) {
        words = allWords.where((word) => word.category == selectedCategory).toList();
      } else {
        words = allWords;
      }
    });
  }

  void _selectCategory(String? category) {
    setState(() {
      selectedCategory = category;
    });
    _loadWords();
  }

  Future<void> _addWord() async {
    final wordController = TextEditingController();
    final translationController = TextEditingController();
    final categoryController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить слово'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: wordController, decoration: InputDecoration(labelText: 'Слово')),
            TextField(controller: translationController, decoration: InputDecoration(labelText: 'Перевод')),
            TextField(controller: categoryController, decoration: InputDecoration(labelText: 'Категория')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена')),
          ElevatedButton(
            onPressed: () async {
              final newWord = Word(
                word: wordController.text,
                translation: translationController.text,
                category: categoryController.text,
              );
              await dbHelper.insertWord(newWord);
              _loadWords();
              Navigator.pop(context);
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  Future<void> _editWord(Word word) async {
    final wordController = TextEditingController(text: word.word);
    final translationController = TextEditingController(text: word.translation);
    final categoryController = TextEditingController(text: word.category);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Редактировать слово'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: wordController, decoration: InputDecoration(labelText: 'Слово')),
            TextField(controller: translationController, decoration: InputDecoration(labelText: 'Перевод')),
            TextField(controller: categoryController, decoration: InputDecoration(labelText: 'Категория')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена')),
          ElevatedButton(
            onPressed: () async {
              final updatedWord = Word(
                id: word.id,
                word: wordController.text,
                translation: translationController.text,
                category: categoryController.text,
                isFavorite: word.isFavorite,
              );
              await dbHelper.updateWord(updatedWord);
              _loadWords();
              Navigator.pop(context);
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteWord(int id) async {
    await dbHelper.deleteWord(id);
    _loadWords();
  }

  void _toggleFavorite(Word word) async {
    final updatedWord = Word(
      id: word.id,
      word: word.word,
      translation: word.translation,
      category: word.category,
      isFavorite: !word.isFavorite,
    );
    await dbHelper.updateWord(updatedWord);
    _loadWords();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Словарь'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Все слова'),
              Tab(text: 'Избранное'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Все слова
            ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                return ListTile(
                  title: Text(word.word),
                  subtitle: Text('${word.translation} (${word.category})'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          word.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: word.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () => _toggleFavorite(word),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editWord(word),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteWord(word.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Избранные слова
            ListView.builder(
              itemCount: favoriteWords.length,
              itemBuilder: (context, index) {
                final word = favoriteWords[index];
                return ListTile(
                  title: Text(word.word),
                  subtitle: Text('${word.translation} (${word.category})'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () => _toggleFavorite(word),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteWord(word.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addWord,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}