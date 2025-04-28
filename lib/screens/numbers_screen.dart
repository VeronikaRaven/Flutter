import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  final List<Map<String, String>> numbers = [
    {'number': 'null', 'translation': '[nul]', 'meaning': 'ноль'},
    {'number': 'eins', 'translation': '[ains]', 'meaning': 'один'},
    {'number': 'zwei', 'translation': '[tsvai]', 'meaning': 'два'},
    {'number': 'drei', 'translation': '[drai]', 'meaning': 'три'},
    {'number': 'vier', 'translation': '[fiːɐ̯]', 'meaning': 'четыре'},
    {'number': 'fünf', 'translation': '[fʏnf]', 'meaning': 'пять'},
    {'number': 'sechs', 'translation': '[zɛks]', 'meaning': 'шесть'},
    {'number': 'sieben', 'translation': '[ˈziːbn̩]', 'meaning': 'семь'},
    {'number': 'acht', 'translation': '[axt]', 'meaning': 'восемь'},
    {'number': 'neun', 'translation': '[nɔɪ̯n]', 'meaning': 'девять'},
    {'number': 'zehn', 'translation': '[tseːn]', 'meaning': 'десять'},
    {'number': 'zwanzig', 'translation': '[ˈtsvantsɪç]', 'meaning': 'двадцать'},
    {'number': 'dreißig', 'translation': '[ˈdʁaɪ̯sɪç]', 'meaning': 'тридцать'},
    {'number': 'fünfzig', 'translation': '[ˈfʏnftsɪç]', 'meaning': 'пятьдесят'},
    {'number': 'hundert', 'translation': '[ˈhʊndɐt]', 'meaning': 'сто'},
    {'number': 'einhunderteins', 'translation': '[ainhʊndɐtaɪ̯ns]', 'meaning': 'сто один'},
    {'number': 'fünfhundert', 'translation': '[ˈfʏnfhʊndɐt]', 'meaning': 'пятьсот'},
    {'number': 'tausend', 'translation': '[ˈtaʊ̯znt]', 'meaning': 'тысяча'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Цифры'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          final number = numbers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.format_list_numbered, color: Colors.blue),
              title: Text(
                number['number']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${number['translation']} - ${number['meaning']}'),
            ),
          );
        },
      ),
    );
  }
}