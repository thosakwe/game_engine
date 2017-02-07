import 'dart:async';
import '../core/content_loader.dart';
import 'dart:html';

class XHRContentLoader implements ContentLoader {
  final Map<String, dynamic> _loaded = {};

  _convert(List<int> data, Type type) {
    switch (type) {
      case String:
        return new String.fromCharCodes(data);
      default:
        return data;
    }
  }

  @override
  Future<T> load<T>(String source) {
    var c = new Completer<T>();

    if (_loaded.containsKey(source)) return _loaded[c];

    var xhr = new HttpRequest()..open('GET', source);

    xhr
      ..onLoadEnd.listen((_) {
        var loaded = _convert(xhr.responseText.codeUnits, T);
        c.complete(_loaded[source] = loaded);
      })
      ..onError.listen((_) {
        c.completeError('Failed to load resource "$source".');
      });

    xhr.send();

    return c.future;
  }
}
