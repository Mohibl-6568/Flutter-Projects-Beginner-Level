import 'package:flutter/material.dart';
import 'package:quizapp/answerbutton.dart';
import 'package:quizapp/questions.dart';
import 'package:quizapp/results.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var currentquestion = 0;
  final List<String> selectedAnswers = [];

  void nextQuestion(String ans) {
    selectedAnswers.add(ans);

    if (currentquestion < questions.length - 1) {
      setState(() {
        currentquestion++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Results(selectedAnswers: selectedAnswers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[currentquestion];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 26, 2, 80),
              Color.fromARGB(255, 45, 7, 98),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...question.getShuffledAnswers().map(
              (answer) =>
                  AnswerButton(answer, onTap: () => nextQuestion(answer)),
            ),
          ],
        ),
      ),
    );
  }
}
