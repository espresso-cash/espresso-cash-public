import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana_pay.dart';

import '../../../../config.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/tokens/token.dart';
import 'odp_request_flow.dart';

class ODPLinkListener extends StatefulWidget {
  const ODPLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<ODPLinkListener> createState() => _ODPLinkListenerState();
}

class _ODPLinkListenerState extends State<ODPLinkListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final solanaPayRequest = tryParse(link);
      if (solanaPayRequest != null) {
        if (solanaPayRequest.splToken != Token.usdc.publicKey) {
          // This is not USDC token, silently ignore for now
          return true;
        }

        _processSolanaPayRequest(solanaPayRequest);

        return true;
      }

      return false;
    });
  }

  Future<void> _processSolanaPayRequest(SolanaPayRequest request) async {
    final odpRequest = await createAndSaveODPRequest(
      amountInUsdc: request.amount ?? Decimal.zero,
      receiver: request.recipient,
      reference: request.reference?.firstOrNull,
      label: request.label,
    );

    if (!mounted) return;

    await context.confirmODPRequest(odpRequest);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

SolanaPayRequest? tryParse(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          (link.host == 'solana.$cpLinkDomain' ||
              link.host == 'sol.$cpLinkDomain' ||
              link.host == solanaPayHost) &&
          link.pathSegments.any((s) => s.isNotEmpty)
      ? Uri(
          scheme: 'solana',
          path: link.pathSegments.firstOrNull,
          queryParameters: link.queryParameters,
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}
