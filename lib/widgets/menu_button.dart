import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  void Function()? onPressed;
  String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.cyan),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      child: Text(title),
    );
  }
}
