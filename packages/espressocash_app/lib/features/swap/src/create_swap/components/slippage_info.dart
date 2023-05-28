import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../models/swap_seed.dart';

class SlippageInfo extends StatelessWidget {
  const SlippageInfo({
    super.key,
    required this.slippage,
    required this.onSlippageChanged,
  });

  final Slippage slippage;
  final ValueSetter<Slippage> onSlippageChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => _SlippageBottomSheet.show(context, onSlippageChanged),
          child: Text.rich(
            TextSpan(
              text: context.l10n.swapSlippageWarning,
              children: [
                TextSpan(
                  text: slippage.label,
                  style: const TextStyle(
                    color: CpColors.yellowDarkAccentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            style: const TextStyle(
              height: 1.3,
              fontSize: 14.5,
              color: CpColors.greyDarkAccentColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}

const _options = Slippage.values;

extension on Slippage {
  String get label {
    switch (this) {
      case Slippage.zpOne:
        return '0.1%';
      case Slippage.zpFive:
        return '0.5%';
      case Slippage.onePercent:
        return '1.0%';
    }
  }
}

class _SlippageBottomSheet extends StatelessWidget {
  const _SlippageBottomSheet({
    required this.onSlippageChange,
  });

  final ValueSetter<Slippage> onSlippageChange;

  static Future<void> show(
    BuildContext context,
    ValueSetter<Slippage> onSlippageChange,
  ) =>
      showModalBottomSheet(
        context: context,
        builder: (_) =>
            _SlippageBottomSheet(onSlippageChange: onSlippageChange),
        backgroundColor: CpColors.darkBackground,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  void _onTap(BuildContext context, Slippage slippage) {
    onSlippageChange(slippage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.swapSlippageTitle,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.swapSlippageExplanation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // TODO(KB): Migrate to slivers
              // ignore: avoid-shrink-wrap-in-lists, migrate later
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final slippage = _options.elementAt(index);

                  return CpButton(
                    text: slippage.label,
                    onPressed: () => _onTap(context, slippage),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
