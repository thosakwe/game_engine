import 'package:vector_math/vector_math.dart';
import 'polyhedron.dart';

class RegularPolyhedron extends Polyhedron {
  final Vector3 _size;
  final int nSides;

  RegularPolyhedron(this.nSides, this._size);

  @override
  Vector3 get size => _size;
}
