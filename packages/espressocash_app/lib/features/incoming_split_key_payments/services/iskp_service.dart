import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../core/api_version.dart';
import '../../../core/escrow_private_key.dart';
import '../../../core/extensions.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/iskp_repository.dart';
import '../models/incoming_split_key_payment.dart';

@injectable
class ISKPService {
  const ISKPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final ISKPRepository _repository;

  Future<IncomingSplitKeyPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
    required SplitKeyApiVersion apiVersion,
  }) async {
    final status = await _createTx(
      escrow: escrow,
      account: account,
      apiVersion: apiVersion,
    );

    final id = const Uuid().v4();

    final payment = IncomingSplitKeyPayment(
      id: id,
      created: DateTime.now(),
      escrow: await escrow.let(EscrowPrivateKey.fromKeyPair),
      status: status,
      apiVersion: apiVersion,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<IncomingSplitKeyPayment> retry(
    IncomingSplitKeyPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      escrow: await payment.escrow.keyPair,
      account: account,
      apiVersion: payment.apiVersion,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<ISKPStatus> _createTx({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
    required SplitKeyApiVersion apiVersion,
  }) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final response = apiVersion == SplitKeyApiVersion.manual
          ? await _client.receivePayment(dto)
          : await _client.receivePaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(LocalWallet(escrow)))
          .letAsync((it) => it.resign(account));

      return ISKPStatus.txCreated(tx, slot: response.slot);
    } on DioError catch (error) {
      if (error.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ISKPStatus.txFailure(
          reason: TxFailureReason.escrowFailure,
        );
      }

      return const ISKPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    } on Exception {
      return const ISKPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
