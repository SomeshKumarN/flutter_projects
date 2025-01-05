import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: result['correct_answer'] == result['user_answer']
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  ((result['question_index'] as int) + 1).toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result['question'].toString(),
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    SizedBox(height: 5),
                    Text(result['correct_answer'].toString(),
                        style: GoogleFonts.lato(
                          color: Colors.purpleAccent,
                          fontSize: 12,
                        )),
                    SizedBox(height: 5),
                    Text(result['user_answer'].toString(),
                        style: GoogleFonts.lato(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                        )),
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
