import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../../../ui/button.dart';

class GridPhrase extends StatefulWidget {
  const GridPhrase({
    super.key,
    required this.callback,
    required this.correctPhrase,
  });

  final ValueSetter<String> callback;
  final String correctPhrase;

  @override
  State<GridPhrase> createState() => _GridPhraseState();
}

class _GridPhraseState extends State<GridPhrase> {
  IMap<int, String> _data = IMap();
  late final Iterable<String> _options;

  @override
  void initState() {
    super.initState();
    _options = widget.correctPhrase.split(' ')..shuffle();
  }

  void _onClicked(int position, String value) {
    if (_data.containsKey(position)) {
      _data = _data.remove(position);
    } else {
      _data = _data.add(position, value);
    }
    widget.callback(_data.values.join(' '));
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          const double spacing = 12;
          const int columns = 3;
          final itemWidth =
              ((constraints.maxWidth - (columns - 1) * spacing) / columns)
                  .floorToDouble();

          return Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: spacing,
            children: _options.mapIndexed((int position, String word) {
              final bool selected = _data.containsKey(position);

              return CpButton(
                width: itemWidth,
                size: CpButtonSize.micro,
                onPressed: () => _onClicked(position, word),
                variant:
                    selected ? CpButtonVariant.dark : CpButtonVariant.inverted,
                text: word,
              );
            }).toList(),
          );
        },
      );
}
