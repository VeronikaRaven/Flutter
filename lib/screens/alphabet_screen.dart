import 'package:flutter/material.dart';

class AlphabetScreen extends StatelessWidget {
  final List<Map<String, String>> alphabet = [
    {'letter': 'A a', 'transcription': '[aː]'},
    {'letter': 'B b', 'transcription': '[beː]'},
    {'letter': 'C c', 'transcription': '[tseː]'},
    {'letter': 'D d', 'transcription': '[deː]'},
    {'letter': 'E e', 'transcription': '[eː]'},
    {'letter': 'F f', 'transcription': '[ɛf]'},
    {'letter': 'G g', 'transcription': '[geː]'},
    {'letter': 'H h', 'transcription': '[haː]'},
    {'letter': 'I i', 'transcription': '[iː]'},
    {'letter': 'J j', 'transcription': '[jɔt]'},
    {'letter': 'K k', 'transcription': '[kaː]'},
    {'letter': 'L l', 'transcription': '[ɛl]'},
    {'letter': 'M m', 'transcription': '[ɛm]'},
    {'letter': 'N n', 'transcription': '[ɛn]'},
    {'letter': 'O o', 'transcription': '[oː]'},
    {'letter': 'P p', 'transcription': '[peː]'},
    {'letter': 'Q q', 'transcription': '[kuː]'},
    {'letter': 'R r', 'transcription': '[ɛr]'},
    {'letter': 'S s', 'transcription': '[ɛs]'},
    {'letter': 'T t', 'transcription': '[teː]'},
    {'letter': 'U u', 'transcription': '[uː]'},
    {'letter': 'V v', 'transcription': '[faʊ]'},
    {'letter': 'W w', 'transcription': '[veː]'},
    {'letter': 'X x', 'transcription': '[ɪks]'},
    {'letter': 'Y y', 'transcription': '[ˈʏpsilɔn]'},
    {'letter': 'Z z', 'transcription': '[tsɛt]'},
    {'letter': 'Ä ä', 'transcription': '[ɛː]'},
    {'letter': 'Ö ö', 'transcription': '[øː]'},
    {'letter': 'Ü ü', 'transcription': '[yː]'},
    {'letter': 'ß', 'transcription': '[ɛsˈtsɛt]'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Немецкий алфавит'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemCount: alphabet.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final item = alphabet[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Text(
                    item['letter']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  item['transcription']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}