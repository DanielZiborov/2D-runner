import 'package:flame/components.dart';

class Obstacle extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    // Загружаем спрайт препятствия
    sprite = await gameRef.loadSprite('Rock1.png');
    size = Vector2(50, 50); // Размер препятствия
    position = Vector2(gameRef.size.x, gameRef.size.y - 100); // Позиция справа
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 200 * dt; // Двигаем препятствие влево
    if (position.x < -size.x) {
      removeFromParent(); // Удаляем препятствие, если оно ушло за экран
    }
  }
}
