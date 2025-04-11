import 'package:flame/components.dart';
import 'package:flutter_2d_runner/actors/falcon.dart';
import 'package:flutter_2d_runner/objects/rock.dart';
import 'package:flutter_2d_runner/objects/star.dart';

class Block {
  final Vector2 gridPosition;
  final Type blockType;
  Block(this.gridPosition, this.blockType);
}

final segments = [
  segment0,
  segment1,
  segment2,
  segment3,
];

final segment0 = [
  Block(Vector2(8, 1), Rock),
];

final segment1 = [
  Block(Vector2(3, 3), Star),
];

final segment2 = [
  Block(Vector2(3, 1), Rock),
  Block(Vector2(4, 1), Rock),
];

final segment3 = [
  Block(Vector2(5, 1), Falcon),
  Block(Vector2(9, 2), Star),
];
