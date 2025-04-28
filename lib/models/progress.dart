class Progress {
  final int userId;
  final int wordsLearned;
  final int lessonsCompleted;
  final int testsCompleted;

  Progress({
    required this.userId,
    required this.wordsLearned,
    required this.lessonsCompleted,
    required this.testsCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'wordsLearned': wordsLearned,
      'lessonsCompleted': lessonsCompleted,
      'testsCompleted': testsCompleted,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      userId: map['userId'] as int,
      wordsLearned: map['wordsLearned'] as int,
      lessonsCompleted: map['lessonsCompleted'] as int,
      testsCompleted: map['testsCompleted'] as int,
    );
  }
}