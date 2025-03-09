import 'package:flame/game.dart';
import 'package:flutter_2d_runner/background.dart';  // Импортируем компонент фона
import 'package:flutter_2d_runner/ground.dart';
import 'package:flutter_2d_runner/obstacle_spawner.dart';// Импортируем компонент препятствий
import 'package:flutter_2d_runner/ostrich.dart';   // Импортируем компонент страуса

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Добавляем компоненты
    add(Background());
    add(Ground());
    add(Ostrich());
    add(ObstacleSpawner());
  }
}
