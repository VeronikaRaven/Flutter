import 'package:flutter/material.dart';

class IrregularVerbsScreen extends StatelessWidget {
  final List<Map<String, String>> verbs = [
    {
      'verb': 'sein',
      'translation': 'быть',
      'conjugation': 'ich bin, du bist, er/sie/es ist',
    },
    {
      'verb': 'haben',
      'translation': 'иметь',
      'conjugation': 'ich habe, du hast, er/sie/es hat',
    },
    {
      'verb': 'werden',
      'translation': 'становиться',
      'conjugation': 'ich werde, du wirst, er/sie/es wird',
    },
    {
      'verb': 'gehen',
      'translation': 'идти',
      'conjugation': 'ich gehe, du gehst, er/sie/es geht',
    },
    {
      'verb': 'kommen',
      'translation': 'приходить',
      'conjugation': 'ich komme, du kommst, er/sie/es kommt',
    },
    {
      'verb': 'machen',
      'translation': 'делать',
      'conjugation': 'ich mache, du machst, er/sie/es macht',
    },
    {
      'verb': 'lesen',
      'translation': 'читать',
      'conjugation': 'ich lese, du liest, er/sie/es liest',
    },
    {
      'verb': 'essen',
      'translation': 'есть',
      'conjugation': 'ich esse, du isst, er/sie/es isst',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Неправильные глаголы'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: verbs.length,
        itemBuilder: (context, index) {
          final verb = verbs[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text(
                verb['verb']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Перевод: ${verb['translation']}'),
                  Text('Склонение: ${verb['conjugation']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}