import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

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
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 24),
      padding: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: CpColors.greenDropdown,
      ),
      child: DropdownButton<Token>(
        value: current,
        underline: const SizedBox.shrink(),
        isExpanded: true,
        icon: const Icon(Icons.expand_more),
        dropdownColor: CpColors.greenDropdown,
        style: style,
        items: availableTokens
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Center(child: Text(e.symbol)),
                ),
              ),
            )
            .toList(),
        onChanged: (t) => t == null ? ignore : onTokenChanged(t),
        selectedItemBuilder: (context) => availableTokens
            .map(
              (t) => Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Center(child: Text(t.symbol)),
              ),
            )
            .toList(),
      ),
    );
  }
}
