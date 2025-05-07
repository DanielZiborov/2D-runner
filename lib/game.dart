import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2d_runner/actors/falcon.dart';
import 'package:flutter_2d_runner/actors/ostrich.dart';
import 'package:flutter_2d_runner/background.dart';
import 'package:flutter_2d_runner/constants/images.dart';
import 'package:flutter_2d_runner/indicators/hud.dart';
import 'package:flutter_2d_runner/managers/segment_manager.dart';
import 'package:flutter_2d_runner/objects/ground.dart';
import 'package:flutter_2d_runner/objects/question.dart';
import 'package:flutter_2d_runner/objects/rock.dart';
import 'package:flutter_2d_runner/objects/apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGame extends FlameGame with HasCollisionDetection, TapDetector {
  final BuildContext context;
  MyGame(this.context);

  late Ostrich _ostrich;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  double objectSpeed = 200;

  int applesCollected = 0;
  int health = 3;
  int questionsCollected = 0;

  int bestScore = 0;

  @override
  Future<void> onLoad() async {
    await _loadBestScore();

    final fileNames = Images.values.toList();

    await images.loadAll(fileNames);

    camera.viewfinder.anchor = Anchor.topLeft;

    add(Background());

    initializeGame();
  }

  void loadGameSegments(int segmentIndex, double xOffset) {
    // Автоматическая генерация земли
    for (int x = 0; x < 10; x++) {
      world.add(Ground(
        gridPosition: Vector2(x.toDouble(), 0),
        xOffset: xOffset,
      ));
    }

    // Добавляем остальные объекты
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case Rock:
          world.add(Rock(
            gridPosition: block.gridPosition,
            xOffset: xOffset,
          ));
          break;
        case Apple:
          world.add(Apple(
            gridPosition: block.gridPosition,
            xOffset: xOffset,
          ));
          break;
        case Falcon:
          world.add(Falcon(
            gridPosition: block.gridPosition,
            xOffset: xOffset,
          ));
        case Question:
          world.add(Question(
            gridPosition: block.gridPosition,
            xOffset: xOffset,
          ));
          break;
      }
    }
  }

  void initializeGame() {
    var segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad = segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ostrich = Ostrich(
      position: Vector2(128, canvasSize.y - 128),
    );
    world.add(_ostrich);

    camera.viewport.add(Hud());
  }

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getInt('bestScore') ?? 0;
  }

  Future<void> saveBestScoreIfNeeded() async {
    final currentScore = applesCollected + questionsCollected * 2;
    if (currentScore > bestScore) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('bestScore', currentScore);
    }
  }

  void endGame() async {
    await saveBestScoreIfNeeded();
  }

  // Обработка касания экрана
  @override
  void onTap() {
    // TODO: implement onTap
    super.onTap();
    _ostrich.onTap();
  }
}
