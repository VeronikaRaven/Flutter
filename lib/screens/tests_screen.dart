import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'test_category_screen.dart'; // Импортируем созданный экран

class TestsScreen extends StatefulWidget {
  const TestsScreen({Key? key}) : super(key: key);

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final dbHelper = DatabaseHelper();

  // Список категорий с иконками
  final List<Map<String, dynamic>> categories = [
    {'title': 'Цифры', 'icon': Icons.format_list_numbered, 'category': 'Numbers'},
    {'title': 'Цвета', 'icon': Icons.color_lens, 'category': 'Colors'},
    {'title': 'Местоимения', 'icon': Icons.people, 'category': 'Pronouns'},
    {'title': 'Еда', 'icon': Icons.fastfood, 'category': 'Food'},
    {'title': 'Фрукты', 'icon': Icons.local_offer, 'category': 'Fruits'},
    {'title': 'Животные', 'icon': Icons.pets, 'category': 'Animals'},
    {'title': 'Неправильные глаголы', 'icon': Icons.edit, 'category': 'Irregular Verbs'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тесты'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(category['icon']),
              title: Text(category['title']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestCategoryScreen(category: category['category']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}