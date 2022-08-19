import 'dart:convert';

import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/data/transaction/tx_signer.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:solana/encoder.dart';

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
