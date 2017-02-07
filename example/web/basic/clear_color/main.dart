import 'package:axe/browser.dart' as axe;

main() => new axe.BrowserGameRunner(width: 600, height: 400)
    .run(new ClearColorGame());

class ClearColorGame extends axe.WebGLGame {
  @override
  void draw(axe.DrawingContext ctx) {
    ctx.clear(axe.Colors.BLUE);
  }
}
