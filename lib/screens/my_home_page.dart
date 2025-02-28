import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/core/consts/string_consts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final game = FlameGame();

  @override
  void initState() {
    super.initState();
    _loadSprite();
  }

  Future<void> _loadSprite() async {
    final sprite = await game.loadSprite(StringConsts.dinoSpritesTardGif); // Загружаем спрайт
    final spriteComponent = SpriteComponent()
      ..sprite = sprite // Устанавливаем спрайт
      ..size = Vector2(128, 128) // Устанавливаем размер (как квадрат 128x128)
      ..position = Vector2(100, 100); // Устанавливаем начальную позицию

    game.add(spriteComponent); // Добавляем компонент в игру
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          StringConsts.title,
        ),
      ),
      body: GameWidget(
        game: game,
      ),
    );
  }
}
