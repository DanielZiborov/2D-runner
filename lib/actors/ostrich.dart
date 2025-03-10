import 'package:flame/components.dart';
import 'package:flutter_2d_runner/game.dart';

class Ostrich extends SpriteAnimationComponent with HasGameRef<MyGame> {
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
  }
}
