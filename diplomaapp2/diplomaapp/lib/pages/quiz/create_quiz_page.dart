import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../../services/quiz_service.dart';

class CreateQuizPage extends StatefulWidget {
  final String courseId;
  CreateQuizPage({required this.courseId});

  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final _titleCtrl = TextEditingController();
  final List<Question> _questions = [];
  final _quizService = QuizService();

  void _addQuestionDialog() {
    String q = '';
    List<String> opts = ['', '', '', ''];
    int correct = 0;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Добавить вопрос'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(onChanged: (v) => q = v, decoration: InputDecoration(labelText: "Вопрос")),
            ...List.generate(4, (i) {
              return TextField(
                onChanged: (v) => opts[i] = v,
                decoration: InputDecoration(labelText: "Вариант ${i + 1}"),
              );
            }),
            DropdownButton<int>(
              value: correct,
              onChanged: (v) => setState(() => correct = v!),
              items: List.generate(4, (i) => DropdownMenuItem(value: i, child: Text("Правильный: ${i + 1}"))),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Сохранить"),
            onPressed: () {
              setState(() {
                _questions.add(Question(question: q, options: opts, answerIndex: correct));
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> _submitQuiz() async {
    final quiz = Quiz(
      id: '',
      courseId: widget.courseId,
      title: _titleCtrl.text,
      questions: _questions,
    );
    await _quizService.createQuiz(quiz);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Тест создан")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создание теста")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: InputDecoration(labelText: 'Название теста')),
            ElevatedButton(onPressed: _addQuestionDialog, child: Text("Добавить вопрос")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _submitQuiz, child: Text("Сохранить тест")),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(_questions[i].question),
                  subtitle: Text("Правильный: ${_questions[i].options[_questions[i].answerIndex]}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
