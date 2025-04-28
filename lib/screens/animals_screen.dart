import 'package:flutter/material.dart';

class AnimalsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> animals = [
    {'animal': 'Hund', 'translation': '[hʊnt]', 'meaning': 'собака', 'image': 'assets/images/dog.png'},
    {'animal': 'Katze', 'translation': '[ˈkat͡sə]', 'meaning': 'кошка', 'image': 'assets/images/cat.png'},
    {'animal': 'Vogel', 'translation': '[ˈfoːɡl̩]', 'meaning': 'птица', 'image': 'assets/images/bird.png'},
    {'animal': 'Fisch', 'translation': '[fɪʃ]', 'meaning': 'рыба', 'image': 'assets/images/fish.png'},
    {'animal': 'Maus', 'translation': '[maʊ̯s]', 'meaning': 'мышь', 'image': 'assets/images/mouse.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Животные'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(animal['image']),
              title: Text(
                animal['animal'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${animal['translation']} - ${animal['meaning']}'),
            ),
          );
        },
      ),
    );
  }
}