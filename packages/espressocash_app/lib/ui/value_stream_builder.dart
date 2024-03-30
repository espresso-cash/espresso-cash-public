import 'package:flutter/widgets.dart';

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value);
typedef ValueStreamFactory<T> = (Stream<T>, T) Function();

extension ValueExt<T> on (Stream<T>, T) {
  (Stream<U>, U) map<U>(U Function(T value) fn) => ($1.map<U>(fn), fn($2));
}

class ValueStreamBuilder<T> extends StatefulWidget {
  const ValueStreamBuilder({
    super.key,
    required this.create,
    required this.builder,
  });

  final ValueStreamFactory<T> create;
  final ValueWidgetBuilder<T> builder;

  @override
  State<ValueStreamBuilder<T>> createState() => _ValueStreamBuilderState();
}

class _ValueStreamBuilderState<T> extends State<ValueStreamBuilder<T>> {
  late final _stream = widget.create();

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: _stream.$1,
        initialData: _stream.$2,
        builder: (context, snapshot) => widget.builder(
          context,
          snapshot.data as T,
        ),
      );
}
