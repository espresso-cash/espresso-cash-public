part of 'encoder.dart';

class SerializableString extends Iterable<int> {
  SerializableString(String string) : _data = utf8.encode(string);

  final Iterable<int> _data;

  int get size => _data.length;

  @override
  Iterator<int> get iterator => _data.iterator;
}
