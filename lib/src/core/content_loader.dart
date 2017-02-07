import 'dart:async';

abstract class ContentLoader {
  Future<T> load<T>(String source);
}
