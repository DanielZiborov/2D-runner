import 'package:flutter_2d_runner/screens/game_screen.dart';
import 'package:flutter_2d_runner/screens/main_screen.dart';
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
  ],
);
