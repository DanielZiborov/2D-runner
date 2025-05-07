import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/constants/images.dart';
import 'package:flutter_2d_runner/game.dart';
import 'package:flutter_2d_runner/indicators/heart.dart';

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

  late TextComponent _appleTextComponent;
  late TextComponent _questionTextComponent;

  @override
  Future<void> onLoad() async {
    // Счётчик яблок
    _appleTextComponent = TextComponent(
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
    add(_appleTextComponent);

    final appleSprite = await game.loadSprite(Images["Apple"]!);
    add(
      SpriteComponent(
        sprite: appleSprite,
        position: Vector2(game.size.x - 100, 20),
        size: Vector2.all(40),
        anchor: Anchor.center,
      ),
    );

    // Счётчик решённых вопросов
    _questionTextComponent = TextComponent(
      text: '${game.questionsCollected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 60),
    );
    add(_questionTextComponent);

    final questionSprite = await game.loadSprite(Images["Question"]!); // убедись, что есть картинка с ключом "Question"
    add(
      SpriteComponent(
        sprite: questionSprite,
        position: Vector2(game.size.x - 100, 60),
        size: Vector2.all(40),
        anchor: Anchor.center,
      ),
    );

    // Отрисовка сердец
    const heartOffsetX = 40;
    final heartStartX = game.size.x - 120 - heartOffsetX;

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
    _appleTextComponent.text = '${game.applesCollected}';
    _questionTextComponent.text = '${game.questionsCollected}';
  }
}
