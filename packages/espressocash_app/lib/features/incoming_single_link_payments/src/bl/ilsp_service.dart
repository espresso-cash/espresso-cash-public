import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/escrow_private_key.dart';
import '../../../../core/extensions.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'islp_payment.dart';
import 'islp_repository.dart';

@injectable
class ISLPService {
  ISLPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final ISLPRepository _repository;

  Future<IncomingSingleLinkPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrowAccount,
  }) async {
    final status = await _createTx(escrow: escrowAccount, account: account);
    final escrow = await EscrowPrivateKey.fromKeyPair(escrowAccount);

    final id = const Uuid().v4();

    final payment = IncomingSingleLinkPayment(
      id: id,
      escrow: escrow,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<IncomingSingleLinkPayment> retry(
    IncomingSingleLinkPayment payment, {
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

  Future<ISLPStatus> _createTx({
    required Ed25519HDKeyPair escrow,
    required ECWallet account,
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
          .let((it) => it.resign(LocalWallet(escrow)));

      return ISLPStatus.txCreated(tx, slot: response.slot);
    } on DioError catch (e) {
      if (e.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ISLPStatus.txFailure(
          reason: TxFailureReason.escrowFailure,
        );
      }

      return const ISLPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    } on Exception {
      return const ISLPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
