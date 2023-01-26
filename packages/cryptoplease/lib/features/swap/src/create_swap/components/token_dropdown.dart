import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/tokens/token.dart';
import '../../../../../ui/colors.dart';

class TokenDropDown extends StatelessWidget {
  const TokenDropDown({
    Key? key,
    required this.current,
    required this.onTokenChanged,
    required this.availableTokens,
  }) : super(key: key);

  final Token current;
  final ValueSetter<Token> onTokenChanged;
  final Iterable<Token> availableTokens;

  @override
  Widget build(BuildContext context) {
    // Needed to keep dropdown opening downwards
    final availableTokens = this.availableTokens.toList()
      ..sort((t, _) => t == current ? 0 : 1);

    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    return Container(
      height: _itemHeight,
      width: _width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: CpColors.greenDropdownEnabled,
      ),
      child: DropdownButton<Token>(
        value: current,
        style: style,
        elevation: 0,
        isExpanded: true,
        itemHeight: _itemHeight + _spacing,
        dropdownColor: Colors.transparent,
        icon: const SizedBox.shrink(),
        underline: const SizedBox.shrink(),
        onChanged: (it) =>
            it == null || it == current ? ignore : onTokenChanged(it),
        items: availableTokens
            .map(
              (it) => DropdownMenuItem(
                value: it,
                child: _Item(label: it.symbol, selected: it == current),
              ),
            )
            .toList(),
        selectedItemBuilder: (context) => availableTokens
            .map((it) => _Item(label: it.symbol, selected: true))
            .toList(),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.label,
    required this.selected,
  }) : super(key: key);

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final title = Text(label, textAlign: TextAlign.center);
    final color = selected
        ? CpColors.greenDropdownEnabled
        : CpColors.greenDropdownDisabled;

    final Widget child;

    if (selected) {
      child = Row(
        children: [
          const SizedBox(width: _iconSize),
          Expanded(child: title),
          const Icon(Icons.expand_more, size: _iconSize)
        ],
      );
    } else {
      child = Center(child: title);
    }

    return Container(
      height: _itemHeight,
      width: _width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: ShapeDecoration(shape: const StadiumBorder(), color: color),
      child: child,
    );
  }
}

const _width = 250.0;
const _itemHeight = 55.0;
const _spacing = 8.0;
const _iconSize = 24.0;
