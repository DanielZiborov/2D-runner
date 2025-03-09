import 'package:flame/components.dart';

class Ostrich extends SpriteAnimationComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    // Загружаем спрайт-лист
    final ostrichRunSheet = await gameRef.loadSprite('OstrichJump.png');
    
    // Создаем анимацию из спрайт-листа. Указываем количество кадров по горизонтали (4 кадра) и размер каждого кадра (128x128)
    final ostrichRunAnimation = SpriteAnimation.fromFrameData(
      ostrichRunSheet.image,
      SpriteAnimationData.sequenced(
        amount: 2,             // Количество кадров (4 кадра в спрайте)
        stepTime: 0.15,         // Время между кадрами
        textureSize: Vector2.all(32),  // Размер каждого кадра в спрайте
      ),
    );

    // Устанавливаем анимацию для страуса
    animation = ostrichRunAnimation;
    
    size = Vector2.all(100); // Размер персонажа
    position = Vector2(100, gameRef.size.y - 150); // Начальная позиция
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Логика движения персонажа, если нужно
  }
}
