import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/game.dart';
import '../managers/segment_manager.dart';

class Ground extends SpriteComponent with HasGameReference<MyGame> {
  final Vector2 gridPosition;
  double xOffset;

  final UniqueKey _blockKey = UniqueKey();
  final Vector2 velocity = Vector2.zero(); 

  Ground({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final groundImage = game.images.fromCache('Ground.png');
    sprite = Sprite(groundImage);
    position = Vector2(
      gridPosition.x * size.x + xOffset,
      game.size.y - gridPosition.y * size.y,
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    if (gridPosition.x == 9 && position.x > game.lastBlockXPosition) {
      game.lastBlockKey = _blockKey;
      game.lastBlockXPosition = position.x + size.x;
    }
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed; // Земля двигается вместе с объектами

    position += velocity * dt;

    // Удаляем объекты, если они выходят за экран
    if (position.x < -size.x) {
      removeFromParent();
      if (gridPosition.x == 0) {
        game.loadGameSegments(
          Random().nextInt(segments.length),
          game.lastBlockXPosition,
        );
      }
    }

    // Обновляем последний блок
    if (gridPosition.x == 9) {
      if (game.lastBlockKey == _blockKey) {
        print("последний блок:");
        print("${position.x + size.x - 10}");
        game.lastBlockXPosition = position.x + size.x - 10;
      }
    }

    super.update(dt);
  }
}
