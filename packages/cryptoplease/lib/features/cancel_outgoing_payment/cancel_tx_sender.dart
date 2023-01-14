import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../config.dart';
import '../../core/transactions/resign_tx.dart';
import '../../core/transactions/tx_sender.dart';
import 'cancel_outgoing_payment.dart';

@injectable
class CancelTxSender {
  CancelTxSender({
    required TxSender txSender,
    required CryptopleaseClient cryptopleaseClient,
  })  : _txSender = txSender,
        _client = cryptopleaseClient;

  final TxSender _txSender;
  final CryptopleaseClient _client;

  Future<CancelStatus> processCancelEscrow({
    required Ed25519HDPublicKey wallet,
    required Ed25519HDKeyPair escrow,
    CancelStatus? status,
  }) async {
    if (status == null) {
      return _createReversalPayment(wallet, escrow);
    }

    return status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.tx),
      success: (status) async => status,
      txFailure: (_) => _createReversalPayment(wallet, escrow),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.tx),
      txEscrowFailure: (status) async => status,
    );
  }

  Future<CancelStatus> _createReversalPayment(
    Ed25519HDPublicKey wallet,
    Ed25519HDKeyPair escrow,
  ) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: wallet.toBase58(),
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final tx = await _client
          .receivePayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(escrow));

      return CancelStatus.txCreated(tx);
    } on Exception {
      return const CancelStatus.txFailure();
    }
  }

  Future<CancelStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => CancelStatus.txSent(tx),
      invalidBlockhash: (_) => const CancelStatus.txFailure(),
      failure: (_) => const CancelStatus.txEscrowFailure(),
      networkError: (_) => CancelStatus.txSendFailure(tx),
    );
  }

  Future<CancelStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => CancelStatus.success(txId: tx.id),
      failure: (_) => const CancelStatus.txEscrowFailure(),
      networkError: (_) => CancelStatus.txWaitFailure(tx),
    );
  }
}
