import 'dart:convert';

import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

abstract class TxSigner {
  Future<Message> createSignedTx(OutgoingTransfer payment, MyAccount account);
}

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

class CpTxSigner implements TxSigner {
  CpTxSigner({
    required CryptopleaseClient cpClient,
  }) : _client = cpClient;

  final CryptopleaseClient _client;

  @override
  Future<Message> createSignedTx(
    OutgoingTransfer payment,
    MyAccount account,
  ) async {
    final recipient = await payment.getRecipient();
    final publicKey = recipient.toBase58();

    final createdPayment = await _client.createPayment(
      CreatePaymentRequestDto(
        senderAccount: account.wallet.address,
        escrowAccount: publicKey,
        amount: payment.amount.toInt(),
        cluster: isProd ? Cluster.mainnet : Cluster.devnet,
      ),
    );

    final tx = createdPayment.transaction;
    final decoded = base64Decode(tx);
    final byteArray = ByteArray(decoded);
    final compiled = CompiledMessage.fromSignedTransaction(byteArray);

    return Message.decompile(compiled);
  }
}
