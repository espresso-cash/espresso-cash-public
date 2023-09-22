import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../core/escrow_private_key.dart';
import '../../../core/extensions.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';

@injectable
class ILPService {
  const ILPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final ILPRepository _repository;

  Future<IncomingLinkPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    final status = await _createTx(
      escrow: escrow,
      account: account,
    );

    final id = const Uuid().v4();

    final payment = IncomingLinkPayment(
      id: id,
      created: DateTime.now(),
      escrow: await escrow.let(EscrowPrivateKey.fromKeyPair),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<IncomingLinkPayment> retry(
    IncomingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      escrow: await payment.escrow.keyPair,
      account: account,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<ILPStatus> _createTx({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final response = await _client.receivePaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(LocalWallet(escrow)))
          .letAsync((it) => it.resign(account));

      return ILPStatus.txCreated(tx, slot: response.slot);
    } on DioError catch (e) {
      if (e.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ILPStatus.txFailure(
          reason: TxFailureReason.escrowFailure,
        );
      }

      return const ILPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    } on Exception {
      return const ILPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
