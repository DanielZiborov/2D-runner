import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/widgets/menu_button.dart';
import 'package:go_router/go_router.dart';

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
            MenuButton(
              onPressed: () {
                context.push("/play");
              },
              title: "Play",
            ),
            const SizedBox(
              height: 10,
            ),
            MenuButton(
              onPressed: () {
                context.push("/options");
              },
              title: "Options",
            ),
            const SizedBox(
              height: 10,
            ),
            MenuButton(
              onPressed: () {
                context.push("/game_record");
              },
              title: "Record",
            ),
          ],
        ),
      ),
    );
  }
}
