import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value);
typedef ValueStreamFactory<T> = ValueStream<T> Function();

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
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        initialData: _stream.value,
        builder: (context, snapshot) => widget.builder(
          context,
          snapshot.data as T,
        ),
      );
}
