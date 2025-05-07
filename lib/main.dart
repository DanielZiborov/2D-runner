import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_runner/managers/audio_manager.dart';
import 'package:flutter_2d_runner/my_app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  await FlameAudio.audioCache.loadAll(['collect.mp3', 'hit.mp3', 'music.mp3']);
  await AudioManager().init();
  runApp(const MyApp());
}
