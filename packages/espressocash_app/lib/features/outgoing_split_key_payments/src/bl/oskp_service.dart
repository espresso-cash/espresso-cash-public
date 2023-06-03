import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/amount.dart';
import '../../../../core/api_version.dart';
import '../../../../core/escrow_private_key.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'repository.dart';

@injectable
class OSKPService {
  const OSKPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final OSKPRepository _repository;

  Future<OutgoingSplitKeyPayment> create({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    const apiVersion = SplitKeyApiVersion.smartContract;
    final status = await _createTx(
      amount: amount,
      account: account,
      apiVersion: apiVersion,
    );

    final id = const Uuid().v4();

    final payment = OutgoingSplitKeyPayment(
      id: id,
      amount: amount,
      created: DateTime.now(),
      status: status,
      apiVersion: apiVersion,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingSplitKeyPayment> retry(
    OutgoingSplitKeyPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      amount: payment.amount,
      account: account,
      apiVersion: payment.apiVersion,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OutgoingSplitKeyPayment> cancel(
    OutgoingSplitKeyPayment payment, {
    required ECWallet account,
  }) async {
    final status = payment.status;

    final OSKPStatus newStatus;
    if (status is OSKPStatusTxFailure) {
      newStatus = OSKPStatus.canceled(
        txId: null,
        timestamp: DateTime.now(),
      );
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
        apiVersion: payment.apiVersion,
      );
    }

    final newPayment = payment.copyWith(status: newStatus);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OSKPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
    required SplitKeyApiVersion apiVersion,
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

      final CreatePaymentResponseDto response;
      switch (apiVersion) {
        case SplitKeyApiVersion.manual:
          response = await _client.createPayment(dto);
          break;
        case SplitKeyApiVersion.smartContract:
          response = await _client.createPaymentEc(dto);
          break;
      }
      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account))
          .letAsync((it) => it.resign(LocalWallet(escrowAccount)));

      return OSKPStatus.txCreated(tx, escrow: privateKey, slot: response.slot);
    } on Exception {
      return const OSKPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OSKPStatus> _createCancelTx({
    required Ed25519HDKeyPair escrow,
    required ECWallet account,
    required SplitKeyApiVersion apiVersion,
  }) async {
    final privateKey = await EscrowPrivateKey.fromKeyPair(escrow);

    try {
      final dto = CancelPaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final String transaction;
      final BigInt slot;
      final SignedTx tx;

      switch (apiVersion) {
        case SplitKeyApiVersion.manual:
          final dto = ReceivePaymentRequestDto(
            receiverAccount: account.address,
            escrowAccount: escrow.address,
            cluster: apiCluster,
          );
          final response = await _client.receivePayment(dto);
          transaction = response.transaction;
          slot = response.slot;
          tx = await transaction
              .let(SignedTx.decode)
              .let((it) => it.resign(LocalWallet(escrow)));
          break;
        case SplitKeyApiVersion.smartContract:
          final response = await _client.cancelPaymentEc(dto);
          transaction = response.transaction;
          slot = response.slot;
          tx = await transaction
              .let(SignedTx.decode)
              .let((it) => it.resign(account));
          break;
      }

      return OSKPStatus.cancelTxCreated(
        tx,
        escrow: privateKey,
        slot: slot,
      );
    } on Exception {
      return OSKPStatus.cancelTxFailure(
        escrow: privateKey,
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
