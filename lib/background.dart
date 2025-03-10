import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    final backgroundImage = game.images.fromCache('Backgrounds.png');
    sprite = Sprite(backgroundImage);
    size = gameRef.size; 
    position = Vector2.zero(); 
  }
}
