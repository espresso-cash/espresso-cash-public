import 'package:solana/solana_pay.dart';

import '../config.dart';

SolanaPayRequest? tryParseSolanaPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          link.host == espressoCashLinkDomain &&
          (link.queryParameters['t'] == 'solanapay' ||
              link.queryParameters['t'] == 'espressopay') &&
          link.queryParameters['recipient'] != null
      ? Uri(
          scheme: 'solana',
          path: link.queryParameters['recipient'],
          queryParameters: {...link.queryParameters}
            ..remove('t')
            ..remove('recipient'),
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}
