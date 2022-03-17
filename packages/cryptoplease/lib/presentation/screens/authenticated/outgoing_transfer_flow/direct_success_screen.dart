import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/transactions/create_transaction_link.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectSuccessScreen extends StatelessWidget {
  const DirectSuccessScreen({
    Key? key,
    required this.transfer,
  }) : super(key: key);

  final OutgoingTransferDirect transfer;

  void _onViewTransaction() {
    final signature = transfer.signature;
    if (signature == null) return;

    launch(createTransactionLink(signature));
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Builder(
          builder: (context) => DecoratedWindow(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.icons.successIconLightBg.svg(height: 50),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.sent,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 32),
                  ),
                  TextButton(
                    onPressed:
                        transfer.signature == null ? null : _onViewTransaction,
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
      );
}
