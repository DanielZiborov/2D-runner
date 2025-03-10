import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_2d_runner/background.dart';
import 'package:flutter_2d_runner/objects/ground.dart';
import 'package:flutter_2d_runner/obstacle_spawner.dart';
import 'package:flutter_2d_runner/actors/ostrich.dart';

class MyGame extends FlameGame {
  late Ostrich _ostrich;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'Backgrounds.png',
      'falconAnim.png',
      'Ground.png',
      'OstrichDeath.png',
      'OstrichDown.png',
      'OstrichJump.png',
      'OstrichRun.png',
      'Rock1.png',
      'Rock2.png',
      'Rock3.png',
      'tree1.png',
      'tree2.png',
      'star.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    _ostrich = Ostrich(
      position: Vector2(100, canvasSize.y-100),
    );
    world.add(_ostrich);

    // Добавляем компоненты
    add(Background());
    add(Ground());
    add(ObstacleSpawner());
  }
}
