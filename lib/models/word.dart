class Word {
  final int? id;
  final String word;
  final String translation;
  final String category;
  bool isFavorite;

  Word({
    this.id,
    required this.word,
    required this.translation,
    required this.category,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'translation': translation,
      'category': category,
      'isFavorite': isFavorite ? 1 : 0, // SQLite хранит логические значения как 0 или 1
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      word: map['word'],
      translation: map['translation'],
      category: map['category'],
      isFavorite: map['isFavorite'] == 1, // Преобразование обратно в boolean
    );
  }
}