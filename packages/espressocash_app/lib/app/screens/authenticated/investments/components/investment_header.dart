import 'package:flutter/material.dart';

import '../../../../../features/ramp/widgets/ramp_buttons.dart';
import 'balance_section.dart';

class InvestmentHeader extends StatelessWidget {
  const InvestmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const insets = EdgeInsets.symmetric(horizontal: 24);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xff2D2B2C)),
      child: Column(
        children: const [
          SizedBox(
            height: 130,
            child: BalanceSection(padding: insets),
          ),
          Divider(color: Color(0xff4B4B4B), height: 8),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 8.0),
            child: RampButtons(),
          ),
        ],
      ),
    );
  }
}
