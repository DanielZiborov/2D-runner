import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 211, 137),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.cyan),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text("Play"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.cyan),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text("Options"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.cyan),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text("Record"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.cyan),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text("Statistics"),
            ),
          ],
        ),
      ),
    );
  }
}
