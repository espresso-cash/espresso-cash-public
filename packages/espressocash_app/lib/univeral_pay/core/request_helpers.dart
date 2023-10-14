import 'package:solana/solana_pay.dart';

import '../config.dart';

SolanaPayRequest? tryParseUniversalPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == urlScheme &&
          link.host == espressoUniversalPayDomain &&
          link.queryParameters['t'] == 'solanapay' &&
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

extension SolanaPayRequestExt on SolanaPayRequest {
  Uri toUniversalPayLink() {
    final link = Uri.parse(toUrl());

    return link.replace(
      scheme: urlScheme,
      path: '/',
      host: espressoUniversalPayDomain,
      queryParameters: {
        't': 'solanapay',
        'recipient': link.path,
        ...link.queryParameters,
      },
    );
  }
}
