import 'dart:math';

class QuadraticEquation {
  final int a;
  final int b;
  final int c;
  final double? x1;
  final double? x2;

  QuadraticEquation()
      : a = Random().nextInt(5) + 1,
        b = Random().nextInt(11) - 5,
        c = Random().nextInt(11) - 5,
        x1 = null,
        x2 = null;

  late final double discriminant = (b * b - 4 * a * c).toDouble();

  String get condition => "$a x² + $b x + $c = 0";

  List<String> get solutions {
    if (discriminant < 0) return ["нет решения"];
    final root = sqrt(discriminant);
    final x1 = (-b + root) / (2 * a);
    final x2 = (-b - root) / (2 * a);

    // Если дискриминант == 0, корни одинаковые — возвращаем один
    if ((x1 - x2).abs() < 0.0001) {
      return [x1.toStringAsFixed(2)];
    }

    // Иначе оба
    return [
      x1.toStringAsFixed(2),
      x2.toStringAsFixed(2),
    ]..sort(); // Сортируем для надёжного сравнения
  }

  bool checkAnswer(String input) {
    final userInput = input.trim().toLowerCase();

    if (discriminant < 0) {
      return userInput == "нет решения";
    }

    final parts = userInput
        .split(RegExp(r'\s+'))
        .map((e) => double.tryParse(e.replaceAll(',', '.')))
        .whereType<double>()
        .map((e) => e.toStringAsFixed(2))
        .toList()
      ..sort();

    final correct = solutions;

    return parts.length == correct.length &&
        List.generate(parts.length, (i) => parts[i] == correct[i]).every((e) => e);
  }
}
