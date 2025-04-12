import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter_2d_runner/game.dart';

class Rock extends SpriteComponent with HasGameReference<MyGame> {
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();

  Rock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final rockImage = game.images.fromCache('Rock1.png'); 
    sprite = Sprite(rockImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;  // Камень двигается влево
    position += velocity * dt;

    // Если объект выходит за экран, удаляем его
    if (position.x < -size.x) {
      removeFromParent();
    }
    super.update(dt);
  }
}

