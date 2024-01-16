import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String quizResult;
  final VoidCallback onPressed;
  const DialogBox(
      {super.key, required this.onPressed, required this.quizResult});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[100],
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                quizResult,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                'Start again',
              ),
            )
          ],
        ),
      ),
    );
  }
}
