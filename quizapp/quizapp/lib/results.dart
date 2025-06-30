import 'package:flutter/material.dart';
import 'package:quizapp/questions.dart';

class Results extends StatelessWidget {
  final List<String> selectedAnswers;

  const Results({required this.selectedAnswers, super.key});

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final score = calculateScore();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
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
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "RESULTS",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "You got $score out of ${questions.length} correct!",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 30),
                ...selectedAnswers.asMap().entries.map((entry) {
                  int index = entry.key;
                  String userAnswer = entry.value;
                  String correctAnswer = questions[index].correctAnswer;
                  bool isCorrect = userAnswer == correctAnswer;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green[100] : Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isCorrect
                          ? "Q${index + 1}: Your Answer: $userAnswer"
                          : "Q${index + 1}: Your Answer: $userAnswer\nCorrect: $correctAnswer",
                      style: TextStyle(
                        fontSize: 16,
                        color: isCorrect ? Colors.green[900] : Colors.red[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 45, 7, 98),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text("Restart Quiz"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
