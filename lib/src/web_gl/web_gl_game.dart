import 'dart:async';
import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'package:sync/mutex.dart';
import '../core/core.dart' as core;
import 'canvas_drawing_context.dart';
import 'xhr_content_loader.dart';

import 'package:game_loop/game_loop_common.dart';

class BrowserGameRunner implements core.GameRunner {
  CanvasElement _element;
  CanvasElement get element => _element;

  BrowserGameRunner({CanvasElement element, int width, int height}) {
    if (element != null)
      _element = element;
    else {
      var $canvas = _element = new CanvasElement();
      $canvas
        ..width = width ?? window.innerWidth
        ..height = height ?? window.innerHeight;
      document.body.append($canvas);
    }
  }

  @override
  Future run(core.Game game) {
    if (game is WebGLGame) {
      var ctx = new CanvasDrawingContext(element);
      game._gameLoop = new GameLoopHtml(element);

      return game.preload().then((_) {
        game.startup();
        game.gameLoop
          ..onUpdate = (_) {
            game
              ..update()
              ..draw(ctx);
          }
          ..start();
      });
    } else
      throw new ArgumentError('BrowserGameRunner only supports WebGL games.');
  }
}

abstract class WebGLGame extends core.Game {
  final core.ContentLoader _loader = new XHRContentLoader();
  GameLoop _gameLoop;
  final Mutex _mutex = new Mutex();

  @override
  GameLoop get gameLoop => _gameLoop;

  @override
  core.ContentLoader get loader => _loader;

  @override
  void queue(action()) {
    _mutex.acquire().then((_) {
      try {
        action();
      } finally {
        _mutex.release();
      }
    });
  }

  @override
  void draw(core.DrawingContext ctx) {}

  @override
  Future preload() async {}

  @override
  Future unload() async {}

  @override
  void startup() {}

  @override
  void update() {}
}
