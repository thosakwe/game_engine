import 'package:axe/browser.dart' as axe;
import 'package:axe/3d.dart' as axe;

main() =>
    new axe.BrowserGameRunner(width: 600, height: 400).run(new CubeGame());

class CubeGame extends axe.WebGLGame {
  final axe.RegularPolyhedron cube =
      new axe.RegularPolyhedron(6, new axe.Vector3(10.0, 10.0, 10.0));

  @override
  void draw(axe.DrawingContext ctx) {
    ctx.clear(axe.Colors.BLACK);
  }
}
