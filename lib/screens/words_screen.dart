import 'package:flutter/material.dart';
import 'alphabet_screen.dart'; // Алфавит
import 'irregular_verbs_screen.dart'; // Неправильные глаголы
import 'numbers_screen.dart'; // Цифры
import 'colors_screen.dart'; // Цвета
import 'pronouns_screen.dart'; // Местоимения
import 'food_screen.dart'; // Еда
import 'fruits_screen.dart'; // Фрукты
import 'animals_screen.dart'; // Животные

class WordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Слова'),
      ),
      body: ListView(
        children: [
          _buildCategoryCard(
            context,
            title: 'Алфавит',
            icon: Icons.text_fields,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlphabetScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Неправильные глаголы',
            icon: Icons.edit,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IrregularVerbsScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Цифры',
            icon: Icons.format_list_numbered,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NumbersScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Цвета',
            icon: Icons.palette,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorsScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Местоимения',
            icon: Icons.people,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PronounsScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Еда',
            icon: Icons.restaurant,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Фрукты',
            icon: Icons.local_pizza,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FruitsScreen()),
            ),
          ),
          _buildCategoryCard(
            context,
            title: 'Животные',
            icon: Icons.pets,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnimalsScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}