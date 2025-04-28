import 'package:flutter/material.dart';

class ColorsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> colors = [
    {'color': 'rot', 'translation': '[ʁoːt]', 'meaning': 'красный', 'code': Colors.red},
    {'color': 'blau', 'translation': '[blaʊ̯]', 'meaning': 'синий', 'code': Colors.blue},
    {'color': 'grün', 'translation': '[ɡʁyːn]', 'meaning': 'зелёный', 'code': Colors.green},
    {'color': 'gelb', 'translation': '[ɡɛlp]', 'meaning': 'жёлтый', 'code': Colors.yellow},
    {'color': 'schwarz', 'translation': '[ʃvaʁts]', 'meaning': 'чёрный', 'code': Colors.black},
    {'color': 'weiß', 'translation': '[vaɪ̯s]', 'meaning': 'белый', 'code': Colors.white},
    {'color': 'orange', 'translation': '[oˈʁaŋə]', 'meaning': 'оранжевый', 'code': Colors.orange},
    {'color': 'lila', 'translation': '[ˈliːla]', 'meaning': 'фиолетовый', 'code': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Цвета'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          return Card(
            color: color['code'],
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                color['color'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: color['code'] == Colors.black ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                '${color['translation']} - ${color['meaning']}',
                style: TextStyle(
                  color: color['code'] == Colors.black ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}