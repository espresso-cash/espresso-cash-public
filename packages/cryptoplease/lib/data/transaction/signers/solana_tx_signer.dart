import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/data/transaction/tx_signer.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/solana.dart';

class SolanaTxSigner implements TxSigner {
  SolanaTxSigner({
    required SolanaClient solanaClient,
  }) : _client = solanaClient;

  final SolanaClient _client;

  @override
  Future<Message> createSignedTx(
    OutgoingTransfer payment,
    MyAccount account,
  ) async =>
      _client.createTransfer(
        sender: account.wallet,
        recipient: await payment.getRecipient(),
        tokenAddress: Ed25519HDPublicKey.fromBase58(payment.tokenAddress),
        amount: payment.amount,
        additionalFee: payment.map(
          splitKey: (p) => p.tokenAddress == Token.sol.address
              ? lamportsPerSignature
              : lamportsPerSignature + tokenProgramRent,
          direct: always(0),
        ),
        memo: payment.memo,
        reference: payment.allReferences.map(Ed25519HDPublicKey.fromBase58),
      );
}
