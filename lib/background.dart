import 'package:flame/components.dart';
import 'package:flutter_2d_runner/constants/images.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    final backgroundImage = game.images.fromCache(Images["Background"]!);
    sprite = Sprite(backgroundImage);
    size = gameRef.size; 
    position = Vector2.zero(); 
  }
}
