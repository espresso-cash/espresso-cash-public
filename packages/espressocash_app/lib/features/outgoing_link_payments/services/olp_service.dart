import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../core/amount.dart';
import '../../../core/escrow_private_key.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@injectable
class OLPService {
  const OLPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final OLPRepository _repository;

  Future<OutgoingLinkPayment> create({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    final escrowAccount = await Ed25519HDKeyPair.random();
    final escrowPrivateKey = await EscrowPrivateKey.fromKeyPair(escrowAccount);

    final status = await _createTx(
      amount: amount,
      account: account,
      escrow: escrowAccount,
    );

    final id = const Uuid().v4();

    final payment = OutgoingLinkPayment(
      id: id,
      amount: amount,
      created: DateTime.now(),
      status: status,
      escrow: escrowPrivateKey,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingLinkPayment> retry(
    OutgoingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final escrowAccount = await Ed25519HDKeyPair.random();
    final escrowPrivateKey = await EscrowPrivateKey.fromKeyPair(escrowAccount);

    final status = await _createTx(
      amount: payment.amount,
      account: account,
      escrow: escrowAccount,
    );

    final newPayment = payment.copyWith(
      escrow: escrowPrivateKey,
      status: status,
    );

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OutgoingLinkPayment> cancel(
    OutgoingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = payment.status;

    final OLPStatus newStatus;
    if (status is OLPStatusTxFailure) {
      newStatus = OLPStatus.canceled(
        txId: null,
        timestamp: DateTime.now(),
      );
    } else {
      final escrow = await status.mapOrNull(
        linkReady: (it) async =>
            await payment.escrow?.keyPair.then((v) => v.publicKey),
        cancelTxFailure: (it) async => it.escrowPubKey,
        recovered: (it) async => it.escrowPubKey,
      );

      if (escrow == null) {
        return payment;
      }

      newStatus = await _createCancelTx(
        escrow: escrow,
        account: account,
      );
    }

    final newPayment = payment.copyWith(status: newStatus);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OLPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    try {
      final dto = CreatePaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrow.address,
        amount: amount.value,
        cluster: apiCluster,
      );

      final CreatePaymentResponseDto response =
          await _client.createPaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account))
          .letAsync((it) => it.resign(LocalWallet(escrow)));

      return OLPStatus.txCreated(tx, slot: response.slot);
    } on Exception {
      return const OLPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OLPStatus> _createCancelTx({
    required Ed25519HDPublicKey escrow,
    required ECWallet account,
  }) async {
    try {
      final dto = CancelPaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrow.toBase58(),
        cluster: apiCluster,
      );

      final response = await _client.cancelPaymentEc(dto);
      final transaction = response.transaction;
      final slot = response.slot;
      final tx = await transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account));

      return OLPStatus.cancelTxCreated(
        tx,
        slot: slot,
        escrowPubKey: escrow,
      );
    } on Exception {
      return OLPStatus.cancelTxFailure(
        reason: TxFailureReason.creatingFailure,
        escrowPubKey: escrow,
      );
    }
  }
}
