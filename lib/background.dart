import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    // Загружаем спрайт фона
    sprite = await gameRef.loadSprite('Backgrounds.png');
    size = gameRef.size; 
  }
}
