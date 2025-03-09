import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "GAME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            const Text(
              "OVER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              color: Colors.red,
              style: const ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(fontSize: 30),
                ),
              ),
              icon: const Icon(Icons.replay),
            ),
          ],
        ),
      ),
    );
  }
}
