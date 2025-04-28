import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/word.dart';
import '../models/lesson.dart';
import '../models/progress.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    String path = join('.dart_tool', 'german_learning.db');
    final db = await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
    await loadPredefinedWords(db);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Создание таблиц...');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Words(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT,
        translation TEXT,
        category TEXT,
        isFavorite INTEGER,
        level TEXT
      )
    ''');
    print('Таблица Words создана');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Lessons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        level TEXT
      )
    ''');
    print('Таблица Lessons создана');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Progress(
        userId INTEGER PRIMARY KEY,
        wordsLearned INTEGER,
        lessonsCompleted INTEGER,
        testsCompleted INTEGER DEFAULT 0
      )
    ''');
    print('Таблица Progress создана');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Settings(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
    print('Таблица Settings создана');
  }

  final List<Word> predefinedWords = [
    // Numbers
    Word(word: 'eins', translation: 'один', category: 'Numbers'),
    Word(word: 'zwei', translation: 'два', category: 'Numbers'),
    Word(word: 'drei', translation: 'три', category: 'Numbers'),

    // Pronouns
    Word(word: 'ich', translation: 'я', category: 'Pronouns'),
    Word(word: 'du', translation: 'ты', category: 'Pronouns'),
    Word(word: 'er', translation: 'он', category: 'Pronouns'),

    // Colors
    Word(word: 'rot', translation: 'красный', category: 'Colors'),
    Word(word: 'blau', translation: 'синий', category: 'Colors'),
    Word(word: 'grün', translation: 'зелёный', category: 'Colors'),

    // Food
    Word(word: 'Brot', translation: 'хлеб', category: 'Food'),
    Word(word: 'Käse', translation: 'сыр', category: 'Food'),
    Word(word: 'Wurst', translation: 'колбаса', category: 'Food'),

    // Fruits
    Word(word: 'Apfel', translation: 'яблоко', category: 'Fruits'),
    Word(word: 'Banane', translation: 'банан', category: 'Fruits'),
    Word(word: 'Orange', translation: 'апельсин', category: 'Fruits'),

    // Animals
    Word(word: 'Hund', translation: 'собака', category: 'Animals'),
    Word(word: 'Katze', translation: 'кошка', category: 'Animals'),
    Word(word: 'Vogel', translation: 'птица', category: 'Animals'),

    // Irregular Verbs
    Word(word: 'sein', translation: 'быть', category: 'Irregular Verbs'),
    Word(word: 'haben', translation: 'иметь', category: 'Irregular Verbs'),
    Word(word: 'werden', translation: 'становиться', category: 'Irregular Verbs'),
  ];

  Future<void> initializeUserProgress(int userId) async {
    try {
      final progress = await getProgress(userId);
      if (progress == null) {
        await insertProgress(Progress(
          userId: userId,
          wordsLearned: 0,
          lessonsCompleted: 0,
          testsCompleted: 0,
        ));
        print('Прогресс создан для пользователя $userId');
      } else {
        print('Прогресс уже существует для пользователя $userId');
      }
    } catch (e) {
      print('Ошибка при инициализации прогресса: $e');
    }
  }

  Future<void> loadPredefinedWords(Database db) async {
    try {
      for (var word in predefinedWords) {
        await db.insert(
          'Words',
          word.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print('Предопределенные слова загружены');
    } catch (e) {
      print('Ошибка при загрузке слов: $e');
    }
  }

  Future<void> saveLanguageLevel(String level) async {
    try {
      final db = await database;
      await db.insert(
        'Settings',
        {'key': 'languageLevel', 'value': level},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Уровень языка сохранен: $level');
    } catch (e) {
      print('Ошибка при сохранении уровня языка: $e');
    }
  }

  Future<String?> getLanguageLevel() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'Settings',
        where: 'key = ?',
        whereArgs: ['languageLevel'],
      );
      return maps.isNotEmpty ? maps.first['value'] as String? : null;
    } catch (e) {
      print('Ошибка при получении уровня языка: $e');
      return null;
    }
  }

  Future<void> resetProgress(int userId) async {
    try {
      final db = await database;
      await db.delete(
        'Progress',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      print('Статистика сброшена для пользователя $userId');
    } catch (e) {
      print('Ошибка при сбросе статистики: $e');
    }
  }

  Future<void> deleteAccount(int userId) async {
    try {
      final db = await database;
      await db.delete(
        'Progress',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      print('Аккаунт удален для пользователя $userId');
    } catch (e) {
      print('Ошибка при удалении аккаунта: $e');
    }
  }

  Future<void> insertProgress(Progress progress) async {
    try {
      final db = await database;
      await db.insert(
        'Progress',
        progress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Прогресс добавлен: ${progress.toMap()}');
    } catch (e) {
      print('Ошибка при добавлении прогресса: $e');
    }
  }

  Future<Progress?> getProgress(int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        'Progress',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (result.isNotEmpty) {
        return Progress(
          userId: result[0]['userId'] as int,
          wordsLearned: result[0]['wordsLearned'] as int,
          lessonsCompleted: result[0]['lessonsCompleted'] as int,
          testsCompleted: result[0]['testsCompleted'] as int,
        );
      }
      return null;
    } catch (e) {
      print('Ошибка при получении прогресса: $e');
      return null;
    }
  }

  Future<void> updateProgress(Progress progress) async {
    try {
      final db = await database;
      await db.update(
        'Progress',
        progress.toMap(),
        where: 'userId = ?',
        whereArgs: [progress.userId],
      );
      print('Прогресс обновлен: ${progress.toMap()}');
    } catch (e) {
      print('Ошибка при обновлении прогресса: $e');
    }
  }

  Future<void> incrementTestsCompleted(int userId) async {
    try {
      final progress = await getProgress(userId);
      if (progress != null) {
        await updateProgress(Progress(
          userId: progress.userId,
          wordsLearned: progress.wordsLearned,
          lessonsCompleted: progress.lessonsCompleted,
          testsCompleted: progress.testsCompleted + 1,
        ));
        print('Тесты обновлены для пользователя $userId');
      }
    } catch (e) {
      print('Ошибка при обновлении тестов: $e');
    }
  }

  Future<void> insertWord(Word word) async {
    try {
      final db = await database;
      await db.insert(
        'Words',
        word.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Слово добавлено: ${word.toMap()}');
    } catch (e) {
      print('Ошибка при добавлении слова: $e');
    }
  }

  Future<List<Word>> getWords() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('Words');
      return List.generate(maps.length, (i) => Word.fromMap(maps[i]));
    } catch (e) {
      print('Ошибка при получении слов: $e');
      return [];
    }
  }

  Future<void> updateWord(Word word) async {
    try {
      final db = await database;
      await db.update(
        'Words',
        word.toMap(),
        where: 'id = ?',
        whereArgs: [word.id],
      );
      print('Слово обновлено: ${word.toMap()}');
    } catch (e) {
      print('Ошибка при обновлении слова: $e');
    }
  }

  Future<void> deleteWord(int id) async {
    try {
      final db = await database;
      await db.delete(
        'Words',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Слово удалено с ID: $id');
    } catch (e) {
      print('Ошибка при удалении слова: $e');
    }
  }
}