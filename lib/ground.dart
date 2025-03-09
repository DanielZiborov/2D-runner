import 'package:flame/components.dart';

class Ground extends PositionComponent with HasGameRef {
  late SpriteComponent ground1;
  late SpriteComponent ground2;

  @override
  Future<void> onLoad() async {
    final sprite = await gameRef.loadSprite('Ground.png');

    // Первая часть земли
    ground1 = SpriteComponent(
      sprite: sprite,
      size: Vector2(gameRef.size.x, 50), 
      position: Vector2(0, gameRef.size.y - 50),
    );

    // Вторая часть земли (идёт сразу за первой)
    ground2 = SpriteComponent(
      sprite: sprite,
      size: Vector2(gameRef.size.x, 50),
      position: Vector2(gameRef.size.x, gameRef.size.y - 50),
    );

    add(ground1);
    add(ground2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    double speed = 100; // Скорость движения земли

    // Двигаем обе части влево
    ground1.position.x -= speed * dt;
    ground2.position.x -= speed * dt;

    // Если первая часть ушла за экран, переносим её вправо
    if (ground1.position.x < -gameRef.size.x) {
      ground1.position.x = ground2.position.x + gameRef.size.x;
    }

    // Если вторая часть ушла за экран, переносим её вправо
    if (ground2.position.x < -gameRef.size.x) {
      ground2.position.x = ground1.position.x + gameRef.size.x;
    }
  }
}
