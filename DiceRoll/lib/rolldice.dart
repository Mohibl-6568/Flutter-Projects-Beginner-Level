import 'package:flutter/material.dart';
import 'dart:math';

class Rolldice extends StatefulWidget {
  const Rolldice({super.key});
  @override
  State<Rolldice> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<Rolldice> {
  var activediceimage = 'assets/images/dice-1.png';
  void rollDice() {
    setState(() {
      switch (getRandomDiceNumber()) {
        case 1:
          activediceimage = 'assets/images/dice-1.png';
        case 2:
          activediceimage = 'assets/images/dice-2.png';
        case 3:
          activediceimage = 'assets/images/dice-3.png';
        case 4:
          activediceimage = 'assets/images/dice-4.png';
        case 5:
          activediceimage = 'assets/images/dice-5.png';
        case 6:
          activediceimage = 'assets/images/dice-6.png';
      }
    });
  }

  int getRandomDiceNumber() {
    final random = Random();
    return random.nextInt(6) + 1;
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(activediceimage, width: 200),
        const SizedBox(height: 25),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 25),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
