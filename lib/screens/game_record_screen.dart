import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameRecordScreen extends StatefulWidget {
  const GameRecordScreen({super.key});

  @override
  State<GameRecordScreen> createState() => _GameRecordScreenState();
}

class _GameRecordScreenState extends State<GameRecordScreen> {
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    _loadBestScore();
  }

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.getInt('bestScore') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My record"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Your best score is $bestScore",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
