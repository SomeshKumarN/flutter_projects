import 'package:flutter/material.dart';

class ResultText extends StatelessWidget {
  const ResultText({
    required this.quizResults,
    super.key,
  });
  final List<Map<String, Object>> quizResults;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: quizResults.map((result) {
            return Row(children: [
              Text(((result['question_index'] as int) + 1).toString()),
              Expanded(
                child: Column(
                  children: [
                    Text(result['question'].toString()),
                    SizedBox(height: 5),
                    Text(result['correct_answer'].toString()),
                    SizedBox(height: 5),
                    Text(result['user_answer'].toString()),
                  ],
                ),
              )
            ]);
          }).toList(),
        ),
      ),
    );

    // [

    //   Text(((quizResults['question_index'] as int) + 1).toString()),
    //   Text(quizResults['question'].toString()),
    //   Text(quizResults['correct_answer'].toString()),
    //   Text(quizResults['user_answer'].toString()),
    // ]);
  }
}
