import 'package:flutter/material.dart';
import 'package:expense_tracker/image_background.dart';

class Onaddbutton extends StatefulWidget {
  const Onaddbutton({super.key});

  @override
  State<Onaddbutton> createState() {
    return _MyCustomFormState();
  }
}

class _MyCustomFormState extends State<Onaddbutton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ImageBackground(
        //imagePath: 'assets/images/bg.jpg', // fixed path
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Add Your Expense',
                /*style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),*/
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logic to add a new expense
                },
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
