class Quiz {
  final String id;
  final String courseId;
  final String title;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.courseId,
    required this.title,
    required this.questions,
  });

  factory Quiz.fromMap(String id, Map<String, dynamic> data) {
    List<Question> qs = (data['questions'] as List)
        .map((q) => Question.fromMap(q))
        .toList();

    return Quiz(
      id: id,
      courseId: data['courseId'],
      title: data['title'],
      questions: qs,
    );
  }

  Map<String, dynamic> toMap() => {
        'courseId': courseId,
        'title': title,
        'questions': questions.map((q) => q.toMap()).toList(),
      };
}

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory Question.fromMap(Map<String, dynamic> map) => Question(
        question: map['question'],
        options: List<String>.from(map['options']),
        answerIndex: map['answerIndex'],
      );

  Map<String, dynamic> toMap() => {
        'question': question,
        'options': options,
        'answerIndex': answerIndex,
      };
}
