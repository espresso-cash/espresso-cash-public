import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/extensions.dart';
import '../../../../core/transactions/resign_tx.dart';
import 'incoming_split_key_payment.dart';
import 'iskp_repository.dart';

@injectable
class ISKPService {
  ISKPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final ISKPRepository _repository;

  Future<IncomingSplitKeyPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    final status = await _createTx(escrow: escrow, account: account);

    final id = const Uuid().v4();

    final payment = IncomingSplitKeyPayment(
      id: id,
      created: DateTime.now(),
      escrow: escrow,
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<ISKPStatus> _createTx({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final tx = await _client
          .receivePayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(LocalWallet(escrow)));

      return ISKPStatus.txCreated(tx);
    } on DioError catch (e) {
      if (e.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ISKPStatus.txEscrowFailure();
      }

      return const ISKPStatus.txFailure();
    } on Exception {
      return const ISKPStatus.txFailure();
    }
  }
}
