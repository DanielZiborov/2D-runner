import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2d_runner/actors/falcon.dart';
import 'package:flutter_2d_runner/game.dart';
import 'package:flutter_2d_runner/objects/ground.dart';
import 'package:flutter_2d_runner/objects/rock.dart';
import 'package:flutter_2d_runner/objects/star.dart';

class Ostrich extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<MyGame> {
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
      game.images.fromCache('OstrichRun.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(32),
        stepTime: 0.15,
      ),
    );
    add(CircleHitbox());
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Мы больше не управляем горизонтальным движением с помощью стрелок.
    // Вместо этого позволяем только прыгать.
    horizontalDirection = 0;

    // Прыжок по-прежнему работает, если нажата клавиша "Space"
    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    return true;
  }

  @override
  void update(double dt) {
    // Персонаж не двигается по оси X, поэтому скорость по X остаётся 0
    velocity.x = 0;

    // Для вертикального движения применяем гравитацию
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

    // Применяем скорость по Y (т.е. вертикальное движение)
    position += velocity * dt;

    // Логика для переворота персонажа (если он должен смотреть в другую сторону)
    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }

    if (other is Star) {
      other.removeFromParent();
    }

    if (other is Falcon || other is Rock) {
      hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    if (!hitByEnemy) {
      hitByEnemy = true;
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
