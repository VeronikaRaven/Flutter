import 'package:flutter/material.dart';

class FruitsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> fruits = [
    {'fruit': 'Banane', 'translation': '[baˈnaːnə]', 'meaning': 'банан', 'image': 'assets/images/banana.png'},
    {'fruit': 'Orange', 'translation': '[oˈʁaŋə]', 'meaning': 'апельсин', 'image': 'assets/images/orange.png'},
    {'fruit': 'Erdbeere', 'translation': '[ˈeːɐ̯tˌbeːʁə]', 'meaning': 'клубника', 'image': 'assets/images/strawberry.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фрукты'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(fruit['image']),
              title: Text(
                fruit['fruit'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${fruit['translation']} - ${fruit['meaning']}'),
            ),
          );
        },
      ),
    );
  }
}