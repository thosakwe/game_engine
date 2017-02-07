import 'dart:async';
import 'game.dart';

abstract class GameRunner {
  Future run(Game game);
}
