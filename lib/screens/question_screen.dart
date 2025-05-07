import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            decoration: const InputDecoration(
              labelText: 'Ваш ответ',
            ),
            inputFormatters: [
              _DecimalInputFormatter(),
            ],
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

class _DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final input = newValue.text;

    // Максимум два числа
    final parts = input.split(' ');
    if (parts.length > 2) return oldValue;

    // Каждую часть проверяем отдельно
    for (final part in parts) {
      if (part.isEmpty) continue;

      // Проверка на максимум 1 точку
      if ('.'.allMatches(part).length > 1) return oldValue;

      // Проверка на максимум 2 знака после точки
      final split = part.split('.');
      if (split.length == 2 && split[1].length > 2) return oldValue;
    }

    return newValue;
  }
}
