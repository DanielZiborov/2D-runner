import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/constants/images.dart';
import 'package:flutter_2d_runner/game.dart';

class Question extends SpriteComponent with HasGameReference<MyGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Question({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    final questionImage = game.images.fromCache(Images["Question"]!);
    sprite = Sprite(questionImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(
      SizeEffect.by(
        Vector2(-24, -24),
        EffectController(
          duration: .75,
          reverseDuration: .5,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
