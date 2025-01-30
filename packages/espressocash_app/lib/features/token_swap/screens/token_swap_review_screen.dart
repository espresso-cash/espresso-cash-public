import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../tokens/token.dart';

class TokenSwapReviewScreen extends StatelessWidget {
  const TokenSwapReviewScreen({
    super.key,
    required this.payAmount,
    required this.payToken,
    required this.receiveAmount,
    required this.receiveToken,
  });

  static Future<Decimal?> push(
    BuildContext context, {
    required Token payToken,
    required String payAmount,
    required Token receiveToken,
    required String receiveAmount,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TokenSwapReviewScreen(
            payAmount: payAmount,
            payToken: payToken,
            receiveAmount: receiveAmount,
            receiveToken: receiveToken,
          ),
        ),
      );

  final String payAmount;
  final Token payToken;
  final String receiveAmount;
  final Token receiveToken;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CpColors.deepGreyColor,
        body: Stack(
          children: [
            SafeArea(
              minimum: const EdgeInsets.only(bottom: 40),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(31),
                  topRight: Radius.circular(31),
                ),
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints viewportConstraints,
                  ) =>
                      DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 36),
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: CpColors.deepGreyColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(31),
                                  topRight: Radius.circular(31),
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                          CpBottomButton(
                            text: 'Confirm Swap',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
