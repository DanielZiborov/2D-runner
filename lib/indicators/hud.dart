import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/constants/images.dart';
import 'package:flutter_2d_runner/game.dart';
import 'heart.dart';

class Hud extends PositionComponent with HasGameReference<MyGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: '${game.applesCollected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 20),
    );
    add(_scoreTextComponent);

    final appleSprite = await game.loadSprite(Images["Apple"]!);
    add(
      SpriteComponent(
        sprite: appleSprite,
        position: Vector2(game.size.x - 100, 20),
        size: Vector2.all(40),
        anchor: Anchor.center,
      ),
    );

    const heartOffsetX = 40; // Отступ между сердцами (расстояние между ними)
    final heartStartX = game.size.x - 120 - heartOffsetX; // Начальная позиция для сердец

    for (var i = 1; i <= game.health; i++) {

      final positionX = heartStartX - (i - 1) * heartOffsetX;

      await add(
        HeartHealthComponent(
          heartNumber: i,
          position: Vector2(positionX.toDouble(), 10),
          size: Vector2.all(32),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = '${game.applesCollected}';
  }
}
