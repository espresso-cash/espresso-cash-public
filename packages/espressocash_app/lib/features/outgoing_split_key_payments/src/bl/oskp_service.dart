import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/amount.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'repository.dart';

@injectable
class OSKPService {
  OSKPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final OSKPRepository _repository;

  Future<OutgoingSplitKeyPayment> create({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    final status = await _createTx(amount: amount, account: account);

    final id = const Uuid().v4();

    final payment = OutgoingSplitKeyPayment(
      id: id,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingSplitKeyPayment> retry(
    OutgoingSplitKeyPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(amount: payment.amount, account: account);

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OutgoingSplitKeyPayment> cancel(
    OutgoingSplitKeyPayment payment, {
    required Ed25519HDPublicKey account,
  }) async {
    final status = payment.status;

    final OSKPStatus newStatus;
    if (status is OSKPStatusTxFailure) {
      newStatus = const OSKPStatus.canceled(txId: null);
    } else {
      final escrow = status.mapOrNull(
        linksReady: (it) => it.escrow,
        cancelTxFailure: (it) => it.escrow,
      );

      if (escrow == null) {
        return payment;
      }

      newStatus = await _createCancelTx(
        escrow: await Ed25519HDKeyPair.fromPrivateKeyBytes(
          privateKey: escrow.bytes,
        ),
        account: account,
      );
    }

    final newPayment = payment.copyWith(status: newStatus);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OSKPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    try {
      final escrowAccount = await Ed25519HDKeyPair.random();
      final privateKey = await EscrowPrivateKey.fromKeyPair(escrowAccount);

      final dto = CreatePaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrowAccount.address,
        amount: amount.value,
        cluster: apiCluster,
      );

      final tx = await _client
          .createPayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(account));

      return OSKPStatus.txCreated(tx, escrow: privateKey);
    } on Exception {
      return const OSKPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OSKPStatus> _createCancelTx({
    required Ed25519HDKeyPair escrow,
    required Ed25519HDPublicKey account,
  }) async {
    final privateKey = await EscrowPrivateKey.fromKeyPair(escrow);

    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: account.toBase58(),
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final tx = await _client
          .receivePayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(LocalWallet(escrow)));

      return OSKPStatus.cancelTxCreated(tx, escrow: privateKey);
    } on Exception {
      return OSKPStatus.cancelTxFailure(
        escrow: privateKey,
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
