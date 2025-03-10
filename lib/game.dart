import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_2d_runner/actors/falcon.dart';
import 'package:flutter_2d_runner/background.dart';
import 'package:flutter_2d_runner/managers/segment_manager.dart';
import 'package:flutter_2d_runner/objects/ground.dart';
import 'package:flutter_2d_runner/objects/platform_block.dart';
import 'package:flutter_2d_runner/objects/star.dart';
import 'package:flutter_2d_runner/actors/ostrich.dart';

class MyGame extends FlameGame {
  late Ostrich _ostrich;
  double objectSpeed = 0.0;

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
      'block.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    add(Background());

    initializeGame();

    // Добавляем компоненты
    // add(Background());
    // add(Ground());
    // add(ObstacleSpawner());
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case Ground:
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
        case Star:
        case Falcon:
      }
    }
  }

  void initializeGame() {
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ostrich = Ostrich(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ostrich);
  }
}
