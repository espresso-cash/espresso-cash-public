import 'package:solana/solana_pay.dart';

import '../config.dart';

SolanaPayRequest? tryParseSolanaPayRequest(Uri link) {
  final isEcRequest =
      link.scheme == 'https' && link.host == espressoCashLinkDomain;

  if (!isEcRequest) return SolanaPayRequest.tryParse(link.toString());

  final Map<String, String> queryParams = link.queryParameters;

  final url = Uri(
    scheme: 'solana',
    path: queryParams['recipient'] ?? queryParams['r'],
    queryParameters: {
      'amount': queryParams['amount'] ?? queryParams['a'],
      'reference': queryParams['reference'] ?? queryParams['p'],
      'label': queryParams['label'] ?? queryParams['l'],
      'spl-token': queryParams['spl-token'],
    },
  );

  return SolanaPayRequest.tryParse(url.toString());
}
