import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';

@injectable
class ORPService {
  ORPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final ORPRepository _repository;

  Future<OffRampPayment> createTransfer({
    required ECWallet account,
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
  }) async {
    final id = const Uuid().v4();

    final status = await _createTx(
      account: account,
      receiver: receiver,
      amount: amount,
    );

    final payment = OffRampPayment.transferFunds(
      id: id,
      receiver: receiver,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OffRampPayment> retryTransfer(
    ORPTransferFunds payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      account: account,
      receiver: payment.receiver,
      amount: payment.amount,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<ORPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
    required Ed25519HDPublicKey receiver,
  }) async {
    try {
      final dto = CreateDirectPaymentRequestDto(
        senderAccount: account.address,
        receiverAccount: receiver.toBase58(),
        referenceAccount: null,
        amount: amount.value,
        cluster: apiCluster,
      );
      final response = await _client.createDirectPayment(dto);
      final tx = await response
          .let((it) => it.transaction)
          .let(SignedTx.decode)
          .let((it) => it.resign(account));

      return ORPStatus.txCreated(tx, slot: response.slot);
    } on Exception {
      return const ORPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OffRampPayment> createSigned({
    required ECWallet account,
    required SignedTx tx,
  }) async {
    final id = const Uuid().v4();

    final signedTx = await tx.resign(account);

    final status = ORPStatus.txCreated(signedTx, slot: BigInt.zero);

    final payment = OffRampPayment.signTransaction(
      id: id,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }
}
