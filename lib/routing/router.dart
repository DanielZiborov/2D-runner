import 'package:flutter_2d_runner/screens/game_over_screen.dart';
import 'package:flutter_2d_runner/screens/game_record_screen.dart';
import 'package:flutter_2d_runner/screens/game_screen.dart';
import 'package:flutter_2d_runner/screens/main_screen.dart';
import 'package:flutter_2d_runner/screens/options_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/play',
      builder: (context, state) => const GameScreen(),
    ),
    GoRoute(
      path: '/game_over',
      builder: (context, state) => const GameOverScreen(),
    ),
    GoRoute(
      path: '/game_record',
      builder: (context, state) => const GameRecordScreen(),
    ),
    GoRoute(
      path: '/options',
      builder: (context, state) => const OptionsScreen(),
    ),
  ],
);
