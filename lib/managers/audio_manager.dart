import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  AudioManager._internal();

  double _soundVolume = 0.5;
  double _musicVolume = 0.5;
  bool _musicPlaying = false;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _soundVolume = prefs.getDouble('soundVolume') ?? 0.5;
    _musicVolume = prefs.getDouble('musicVolume') ?? 0.5;
  }

  double get soundVolume => _soundVolume;
  double get musicVolume => _musicVolume;

  Future<void> setSoundVolume(double value) async {
    _soundVolume = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('soundVolume', value);
  }

  Future<void> setMusicVolume(double value) async {
    _musicVolume = value;
    await FlameAudio.bgm.audioPlayer.setVolume(value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('musicVolume', value);
  }

  void playSound(String name) async {
    FlameAudio.play('$name.mp3', volume: _soundVolume);
  }

  Future<void> playMusic() async {
    if (!_musicPlaying) {
      _musicPlaying = true;
      await FlameAudio.bgm.play('music.mp3', volume: _musicVolume);
    }
  }

  Future<void> stopMusic() async {
    _musicPlaying = false;
    await FlameAudio.bgm.stop();
  }
}
