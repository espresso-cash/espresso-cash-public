import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

final _options = ['0.1', '0.5', '1.0'].map(Decimal.parse);

class SlippageBottomSheet extends StatelessWidget {
  const SlippageBottomSheet({
    Key? key,
    required this.onSlippageChange,
  }) : super(key: key);

  final ValueSetter<Decimal> onSlippageChange;

  static Future<void> show(
    BuildContext context,
    ValueSetter<Decimal> onSlippageChange,
  ) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => SlippageBottomSheet(onSlippageChange: onSlippageChange),
        backgroundColor: CpColors.darkBackground,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  void _onTap(BuildContext context, Decimal slippage) {
    onSlippageChange(slippage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Slippage tolerance',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Slippage is the difference observed due to  changing market conditions between the moment the transaction is submitted and its verification.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final slippage = _options.elementAt(index);
                  final label = '$slippage%';

                  return CpButton(
                    text: label,
                    onPressed: () => _onTap(context, slippage),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
