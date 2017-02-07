import 'package:color/color.dart';
import '../3d/object.dart';

abstract class DrawingContext {
  void clear(Color color);
  void object(Object3D obj);
}
