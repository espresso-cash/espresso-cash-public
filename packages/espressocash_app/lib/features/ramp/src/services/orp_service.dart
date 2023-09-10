import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/amount.dart';
import '../../../accounts/models/ec_wallet.dart';
import '../../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';

@injectable
class ORPService {
  const ORPService(this._repository);

  final ORPRepository _repository;

  Future<OffRampPayment> createORP({
    required ECWallet account,
    required SignedTx tx,
    required String provider,
    required CryptoAmount amount,
  }) async {
    final id = const Uuid().v4();

    final signedTx = await tx.resign(account);

    final status = ORPStatus.txCreated(signedTx, slot: BigInt.zero);

    final payment = OffRampPayment.signTransaction(
      id: id,
      created: DateTime.now(),
      status: status,
      provider: provider,
      amount: amount,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OffRampPayment> retryORP(
    OffRampPayment payment, {
    required ECWallet account,
    required SignedTx tx,
  }) async {
    final signedTx = await tx.resign(account);

    final status = ORPStatus.txCreated(signedTx, slot: BigInt.zero);

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }
}
