import 'package:flame/components.dart';
import 'package:flutter_2d_runner/obstacle.dart';

class ObstacleSpawner extends Component with HasGameRef {
  late Timer _timer;

  @override
  void onMount() {
    _timer = Timer(2, onTick: _spawnObstacle, repeat: true); // Спавним каждые 2 секунды
    _timer.start();
    super.onMount();
  }

  void _spawnObstacle() {
    gameRef.add(Obstacle()); // Добавляем препятствие в игру
  }

  @override
  void update(double dt) {
    _timer.update(dt); // Обновляем таймер
  }
}
