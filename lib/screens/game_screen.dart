import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2d_runner/game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MyGame(),
    );
  }
}
