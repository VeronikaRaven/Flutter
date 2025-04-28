import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  final List<Map<String, dynamic>> foods = [
    {
      'food': 'Apfel',
      'translation': '[ˈap͡fl̩]',
      'meaning': 'яблоко',
      'image': 'assets/images/apple.png'
    },
    {
      'food': 'Brot',
      'translation': '[bʁoːt]',
      'meaning': 'хлеб',
      'image': 'assets/images/bread.png'
    },
    {
      'food': 'Käse',
      'translation': '[kɛːzə]',
      'meaning': 'сыр',
      'image': 'assets/images/cheese.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Еда'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(food['image']),
              title: Text(
                food['food'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${food['translation']} - ${food['meaning']}'),
            ),
          );
        },
      ),
    );
  }
}