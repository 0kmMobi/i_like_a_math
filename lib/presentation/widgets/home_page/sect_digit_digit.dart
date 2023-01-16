import 'package:flutter/material.dart';

class Digit extends StatelessWidget {
  final int currentDigit;
  const Digit({Key? key, required this.currentDigit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(currentDigit.toString(),
          style: const TextStyle(fontFamily: 'Roboto', fontSize: 120) //, backgroundColor: Colors.green)
      ),
    );
  }
}
