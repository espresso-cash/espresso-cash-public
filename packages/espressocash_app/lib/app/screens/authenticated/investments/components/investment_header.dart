import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';
import 'action_section.dart';
import 'balance_section.dart';

class InvestmentHeader extends StatelessWidget {
  const InvestmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const insets = EdgeInsets.symmetric(horizontal: 24);

    return DecoratedBox(
      decoration: const BoxDecoration(color: CpColors.darkBackground),
      child: Column(
        children: const [
          SizedBox(
            height: 130,
            child: BalanceSection(padding: insets),
          ),
          SizedBox(
            height: 150,
            child: ButtonSection(padding: insets),
          ),
        ],
      ),
    );
  }
}
