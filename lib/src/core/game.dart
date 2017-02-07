import 'dart:async';
import 'package:game_loop/game_loop_common.dart';
import 'content_loader.dart';
import 'drawing_context.dart';
import 'queueable.dart';

abstract class Game implements Queueable {
  ContentLoader get loader;
  GameLoop get gameLoop;

  Future preload();

  Future unload();

  void startup();

  void update();

  void draw(DrawingContext ctx);
}
