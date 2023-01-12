import 'package:flutter/material.dart';

import '../../../../../core/tokens/token.dart';
import '../../../../../ui/colors.dart';

class TokenDropDown extends StatefulWidget {
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
  State<TokenDropDown> createState() => _TokenDropDownState();
}

class _TokenDropDownState extends State<TokenDropDown> {
  late List<Token> tokens;

  @override
  void initState() {
    super.initState();
    tokens = widget.availableTokens.toList();
    _sort(widget.current);
  }

  void _onChanged(Token? token) {
    if (token == null || token == widget.current) return;
    setState(() => _sort(token));
    widget.onTokenChanged(token);
  }

  // Needed to keep dropdown opening downwards
  List<Token> _sort(Token token) => tokens..sort((t, _) => t == token ? 0 : 1);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    return Container(
      height: _itemHeight,
      width: _width,
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: CpColors.greenDropdownEnabled,
      ),
      child: DropdownButton<Token>(
        value: widget.current,
        style: style,
        elevation: 0,
        isExpanded: true,
        itemHeight: _itemHeight + _spacing,
        dropdownColor: Colors.transparent,
        icon: const SizedBox.shrink(),
        underline: const SizedBox.shrink(),
        onChanged: _onChanged,
        items: tokens
            .map(
              (it) => DropdownMenuItem(
                value: it,
                child: _Item(label: it.symbol, selected: it == widget.current),
              ),
            )
            .toList(),
        selectedItemBuilder: (context) => tokens
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
