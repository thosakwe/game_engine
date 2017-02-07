import 'package:vector_math/vector_math.dart';
import 'object.dart';

abstract class Polyhedron implements Object3D {
  final Vector3 _position = new Vector3.zero();
  final Vector3 _rotation = new Vector3.zero();
  final Vector3 _scale = new Vector3(1.0, 1.0, 1.0);

  @override
  Vector3 get position => _position;

  @override
  Vector3 get rotation => _rotation;

  @override
  Vector3 get scale => _scale;
}
