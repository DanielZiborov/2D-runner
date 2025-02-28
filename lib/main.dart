import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/my_app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}
