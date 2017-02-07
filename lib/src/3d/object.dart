import 'dart:typed_data';
import 'package:vector_math/vector_math.dart';

abstract class Object3D {
  Vector3 get position;
  Vector3 get rotation;
  Vector3 get scale;
  Vector3 get size;

  Float32List toBuffer();
}
