import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/transactions/create_transaction_link.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/theme.dart';

class TxResultScreen extends StatelessWidget {
  const TxResultScreen({
    Key? key,
    required this.signature,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final TransactionId? signature;
  final String text;
  final SvgGenImage icon;

  void _onViewTransaction() {
    final signature = this.signature;
    if (signature == null) return;

    launchUrl(Uri.parse(createTransactionLink(signature)));
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: CpAppBar(),
            body: CpContentPadding(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon.svg(height: 50),
                    const SizedBox(height: 16),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 32),
                    ),
                    if (signature != null)
                      TextButton(
                        onPressed: _onViewTransaction,
                        child: Text(
                          context.l10n.viewTransaction,
                          style: const TextStyle(color: CpColors.yellowColor),
                        ),
                      ),
                    const SizedBox(height: kToolbarHeight),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
