import 'package:flutter/material.dart';

class GameRecordScreen extends StatelessWidget {
  const GameRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My record"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Your last best score is"),
      ),
    );
  }
}