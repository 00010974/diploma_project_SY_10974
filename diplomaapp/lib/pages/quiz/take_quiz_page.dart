import 'package:flutter/material.dart';
import '../../models/quiz.dart';

class TakeQuizPage extends StatefulWidget {
  final Quiz quiz;

  TakeQuizPage({required this.quiz});

  @override
  _TakeQuizPageState createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  Map<int, int> answers = {}; // questionIndex: selectedOption

  void _submit() {
    int correct = 0;
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      if (answers[i] == widget.quiz.questions[i].answerIndex) {
        correct++;
      }
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Результат"),
        content: Text("Вы набрали $correct из ${widget.quiz.questions.length}"),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qs = widget.quiz.questions;
    return Scaffold(
      appBar: AppBar(title: Text(widget.quiz.title)),
      body: ListView.builder(
        itemCount: qs.length,
        itemBuilder: (ctx, i) {
          final q = qs[i];
          return Card(
            child: Column(
              children: [
                Text(q.question, style: TextStyle(fontWeight: FontWeight.bold)),
                ...List.generate(q.options.length, (j) {
                  return RadioListTile(
                    title: Text(q.options[j]),
                    value: j,
                    groupValue: answers[i],
                    onChanged: (v) => setState(() => answers[i] = v as int),
                  );
                }),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _submit,
      ),
    );
  }
}
