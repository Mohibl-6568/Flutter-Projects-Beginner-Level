import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  //final String imagePath;
  final Widget child;

  const ImageBackground({
    //required this.imagePath,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),
        child,
      ],
    );
  }
}
