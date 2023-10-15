import 'package:solana/solana_pay.dart';

import '../config.dart';

SolanaPayRequest? tryParseUniversalPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          link.host == espressoUniversalPayDomain &&
          link.queryParameters['t'] == 'universalpay' &&
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
      scheme: 'https',
      path: '/',
      host: espressoUniversalPayDomain,
      queryParameters: {
        't': 'universalpay',
        'recipient': link.path,
        ...link.queryParameters,
      },
    );
  }
}
