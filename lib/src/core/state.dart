import 'dart:async';
import 'package:game_loop/game_loop_common.dart';
import 'content_loader.dart';
import 'drawing_context.dart';

class GameStateManager {
  GameState _current;
  final Map<String, GameState> _states = {};

  final ContentLoader loader;

  GameStateManager(this.loader);

  GameState get current => _current;

  Future activate(String name) async {
    if (!_states.containsKey(name))
      throw new ArgumentError(
          'GameStateManager does not contain a GameState with the name "$name".');

    if (_current != null) await _current.unload(loader);
    var state = _current = _states[name];
    return await state.preload(loader);
  }

  void register(String name, GameState state(GameStateManager manager)) {
    if (_states.containsKey(name))
      throw new StateError(
          'GameStateManager already contains a GameState with the name "$name".');
    else {
      _states[name] = state(this);
    }
  }

  void update(GameLoop gameLoop) => _current?.update(gameLoop);

  void draw(DrawingContext ctx, GameLoop gameLoop) =>
      _current?.draw(ctx, gameLoop);
}

class GameState {
  final GameStateManager manager;

  GameState(this.manager);

  Future preload(ContentLoader loader) async {}

  Future unload(ContentLoader loader) async {}

  void startup() {}

  void update(GameLoop gameLoop) {}

  void draw(DrawingContext ctx, GameLoop gameLoop) {}
}
