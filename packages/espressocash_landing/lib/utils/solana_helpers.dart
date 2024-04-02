import 'package:solana/solana_pay.dart';

import '../config.dart';

SolanaPayRequest? tryParseEcRequest(Uri link) {
  final isProperHost =
      link.scheme == 'https' && link.host == espressoCashLinkDomain ||
          link.host == 'localhost';

  if (!isProperHost) return null;

  final Map<String, String> queryParams = link.queryParameters;

  if (queryParams['t'] != 's' && queryParams['t'] != 'solanapay') {
    return null;
  }

  final url = Uri(
    scheme: 'solana',
    path: queryParams['recipient'] ?? queryParams['r'],
    queryParameters: {
      'amount': queryParams['amount'] ?? queryParams['a'],
      'reference': queryParams['reference'] ?? queryParams['p'],
      'label': queryParams['label'] ?? queryParams['l'],
      'spl-token': queryParams['spl-token'] ?? mainnetUsdc.toBase58(),
    },
  );

  return SolanaPayRequest.tryParse(url.toString());
}
