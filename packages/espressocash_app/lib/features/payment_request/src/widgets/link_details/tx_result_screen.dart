import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../../core/presentation/utils.dart';
import '../../../../../core/transactions/create_transaction_link.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/theme.dart';

class TxResultScreen extends StatefulWidget {
  const TxResultScreen({
    super.key,
    required this.signature,
    required this.text,
    required this.icon,
  });

  final TransactionId? signature;
  final String text;
  final SvgGenImage icon;

  @override
  State<TxResultScreen> createState() => _TxResultScreenState();
}

class _TxResultScreenState extends State<TxResultScreen> {
  void _onViewTransaction() {
    final signature = widget.signature;
    if (signature == null) return;

    context.openLink(createTransactionLink(signature));
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
                    widget.icon.svg(height: 50),
                    const SizedBox(height: 16),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 32),
                    ),
                    if (widget.signature != null)
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
