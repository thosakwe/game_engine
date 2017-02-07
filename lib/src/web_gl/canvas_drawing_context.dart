import 'dart:html';
import 'dart:web_gl' as gl;
import 'package:color/color.dart';
import '../3d/object.dart';
import '../core/drawing_context.dart';

class CanvasDrawingContext implements DrawingContext {
  gl.RenderingContext _ctx;
  final CanvasElement _element;

  CanvasElement get element => _element;
  gl.RenderingContext get renderingContext => _ctx;

  CanvasDrawingContext(this._element) {
    _ctx = _element.getContext3d();
    _ctx
      ..enable(gl.DEPTH_TEST)
      ..depthFunc(gl.LEQUAL);
  }

  @override
  void clear(Color color) {
    var rgb = color.toRgbColor();
    _ctx
      ..clearColor(rgb.r, rgb.g, rgb.b, 1.0)
      ..clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
  }

  @override
  void object(Object3D obj, {int bufferUsage}) {
    var buf = _ctx.createBuffer();
    _ctx
      ..bindBuffer(gl.ARRAY_BUFFER, buf)
      ..bufferData(
          gl.ARRAY_BUFFER, obj.toBuffer(), bufferUsage ?? gl.STATIC_DRAW);
    _ctx.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, buf);
  }
}
