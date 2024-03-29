import 'package:espressocash_common/espressocash_common.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../config.dart';

extension SolanaClientExt on SolanaClient {
  Future<CryptoAmount?> getUsdcBalance(String address) async {
    try {
      final usdcTokenAccount = await findAssociatedTokenAddress(
        owner: Ed25519HDPublicKey.fromBase58(address),
        mint: Ed25519HDPublicKey.fromBase58(Token.usdc.address),
      );

      final balance = await rpcClient
          .getTokenAccountBalance(
            usdcTokenAccount.toBase58(),
            commitment: Commitment.confirmed,
          )
          .value;

      return CryptoAmount(
        value: int.parse(balance.amount),
        cryptoCurrency: Currency.usdc,
      );
    } on Exception {
      return null;
    }
  }
}

SolanaPayRequest? tryParseSolanaPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          link.host == espressoCashLinkDomain &&
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
