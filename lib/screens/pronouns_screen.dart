import 'package:flutter/material.dart';

class PronounsScreen extends StatelessWidget {
  final List<Map<String, String>> pronouns = [
    {'pronoun': 'ich', 'translation': 'я'},
    {'pronoun': 'du', 'translation': 'ты'},
    {'pronoun': 'er', 'translation': 'он'},
    {'pronoun': 'sie', 'translation': 'она'},
    {'pronoun': 'es', 'translation': 'оно'},
    {'pronoun': 'wir', 'translation': 'мы'},
    {'pronoun': 'ihr', 'translation': 'вы (множественное число)'},
    {'pronoun': 'sie', 'translation': 'они'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Местоимения'),
      ),
      body: ListView.builder(
        itemCount: pronouns.length,
        itemBuilder: (context, index) {
          final pronoun = pronouns[index];
          return ListTile(
            title: Text(pronoun['pronoun']!),
            subtitle: Text(pronoun['translation']!),
          );
        },
      ),
    );
  }
}