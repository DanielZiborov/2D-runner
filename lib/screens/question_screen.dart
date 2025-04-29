import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final String equation;
  final Function(String) onSubmit;

  const QuestionScreen({
    super.key,
    required this.equation,
    required this.onSubmit,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submitAnswer() {
    final answer = _controller.text;
    widget.onSubmit(answer);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Решите уравнение'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.equation),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Ваш ответ'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitAnswer,
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
