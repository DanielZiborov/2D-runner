import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/actors/falcon.dart';
import 'package:flutter_2d_runner/constants/images.dart';
import 'package:flutter_2d_runner/game.dart';
import 'package:flutter_2d_runner/objects/ground.dart';
import 'package:flutter_2d_runner/objects/question.dart';
import 'package:flutter_2d_runner/objects/rock.dart';
import 'package:flutter_2d_runner/objects/apple.dart';
import 'package:flutter_2d_runner/quadratic_equation.dart';
import 'package:flutter_2d_runner/screens/question_screen.dart';
import 'package:go_router/go_router.dart';

class Ostrich extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<MyGame> {
  bool hitByEnemy = false;

  int horizontalDirection = 0;
  final velocity = Vector2.zero();
  final moveSpeed = 200.0;

  final double gravity = 45;
  final double jumpSpeed = 1000;
  final double terminalVelocity = 150;

  bool hasJumped = false;

  final Vector2 fromAbove = Vector2(0, -1);
  bool isOnGround = false;

  Ostrich({
    required super.position,
  }) : super(size: Vector2.all(100), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(Images["Ostrich"]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
      ),
    );
    add(CircleHitbox());
  }

  // Этот метод будет вызываться при касании экрана
  void onTap() {
    hasJumped = true;
  }

  @override
  void update(double dt) {
    velocity.x = 0; // Персонаж не двигается по оси X

    // Применяем гравитацию
    velocity.y += gravity;

    // Логика прыжка
    if (hasJumped) {
      if (isOnGround) {
        velocity.y = -jumpSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }

    // Ограничиваем скорость падения (терминальная скорость)
    velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    // Применяем скорость по Y
    position += velocity * dt;

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }

    if (other is Apple) {
      other.removeFromParent();
      game.applesCollected++;
    }

    if (other is Question) {
      other.removeFromParent();

      // Ставим игру на паузу
      game.paused = true;

      //случайное уравнение
      final quadraticEquation = QuadraticEquation();

      // Показываем модальное окно с уравнением
      showDialog(
        context: game.context,
        builder: (BuildContext context) {
          return QuestionScreen(
            equation: quadraticEquation.condition,
            onSubmit: (answer) {
              // Проверка ответа
              if (quadraticEquation.checkAnswer(answer)) {
                log("Правильный ответ!");
                game.questionsCollected++;
              } else {
                // Неправильный ответ
                log("Неправильный ответ!");
              }
              game.paused = false;
            },
          );
        },
      );
    }

    // if (other is Falcon || other is Rock) {
    //   hit();
    // }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
      if (game.health <= 0) {
        Future.microtask(() {
          game.context.go('/game_over');
        });
      }
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 6,
        ),
      )..onComplete = () {
          hitByEnemy = false;
        },
    );
  }
}
