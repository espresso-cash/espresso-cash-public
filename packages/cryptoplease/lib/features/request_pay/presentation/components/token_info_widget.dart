import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  static const _radius = Radius.circular(40);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        decoration: const BoxDecoration(
          color: CpColors.backgroundAccentColor,
          borderRadius: BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Assets.icons.info.svg(
                          color: CpColors.yellowColor,
                          height: 24,
                        ),
                      ),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(
                      text: '1 ${token.symbol} is equal to \$1',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  context.l10n.usdcExplanation,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      );
}
