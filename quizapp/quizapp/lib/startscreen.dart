import 'package:flutter/material.dart';
import 'package:quizapp/quizpage.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() {
    return _Start();
  }
}

class _Start extends State<Startscreen> {
  void pressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizPage()),
    );
  }

  @override
  Widget build(context) {
    return Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/quiz-logo.png',
              width: 200,
              height: 200,
              color: const Color.fromARGB(75, 0, 0, 0),
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            const Text(
              'Welcome to the Quiz App!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: pressed, child: const Text('Start Quiz')),
          ],
        ),
      ),
    );
  }
}
