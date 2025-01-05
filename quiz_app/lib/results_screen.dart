import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/result_text.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.choosenAnsers,
    required this.onRestart,
    super.key,
  });
  final List<String> choosenAnsers;
  final void Function() onRestart;

  List<Map<String, Object>> getResultSummary() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnsers.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].question,
        "correct_answer": questions[i].answerOptions[0],
        "user_answer": choosenAnsers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getResultSummary();
    final numOfTotalQuestion = choosenAnsers.length;
    final numOfCorrectAnswer = summaryData.where((element) {
      return (element['correct_answer'] == element['user_answer']);
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'You answered $numOfCorrectAnswer out of $numOfTotalQuestion questions correctly!'),
              SizedBox(height: 30),
              ResultText(quizResults: summaryData),
              SizedBox(height: 30),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh),
                onPressed: onRestart,
                label: Text('Restart Quiz!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
