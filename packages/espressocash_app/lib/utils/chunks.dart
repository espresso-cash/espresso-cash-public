extension IterableX<T> on Iterable<T> {
  Iterable<List<T>> chunks(int size) sync* {
    if (isEmpty) return;

    List<T> chunk = <T>[];
    for (final element in this) {
      chunk.add(element);
      if (chunk.length == size) {
        yield chunk;
        chunk = <T>[];
      }
    }
    if (chunk.isNotEmpty) {
      yield chunk;
    }
  }
}
