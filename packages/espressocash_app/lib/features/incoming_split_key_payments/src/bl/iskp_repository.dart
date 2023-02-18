// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import 'incoming_split_key_payment.dart';

@injectable
class ISKPRepository {
  ISKPRepository(this._db);

  final MyDatabase _db;

  Future<IncomingSplitKeyPayment?> load(String id) {
    final query = _db.select(_db.iSKPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<IncomingSplitKeyPayment?> watch(String id) {
    final query = _db.select(_db.iSKPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(IncomingSplitKeyPayment payment) async =>
      _db.into(_db.iSKPRows).insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.iSKPRows).go();
}

class ISKPRows extends Table with EntityMixin, TxStatusMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ISKPStatusDto>()();
}

enum ISKPStatusDto {
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure, // Legacy
  txWaitFailure, // Legacy
  txEscrowFailure, // Legacy
}

extension on ISKPRow {
  Future<IncomingSplitKeyPayment> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return IncomingSplitKeyPayment(
      id: id,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on ISKPStatusDto {
  ISKPStatus toModel(ISKPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case ISKPStatusDto.privateKeyReady:
        return const ISKPStatus.privateKeyReady();
      case ISKPStatusDto.txCreated:
        return ISKPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ISKPStatusDto.txSent:
        return ISKPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          slot: slot ?? BigInt.zero,
        );
      case ISKPStatusDto.success:
        return ISKPStatus.success(txId: txId!);
      case ISKPStatusDto.txFailure:
        return ISKPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case ISKPStatusDto.txSendFailure:
        return ISKPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ISKPStatusDto.txWaitFailure:
        return ISKPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          slot: slot ?? BigInt.zero,
        );
      case ISKPStatusDto.txEscrowFailure:
        return const ISKPStatus.txFailure(
          // TODO(rhbrunetto): validate reason
          reason: TxFailureReason.insufficientFunds,
        );
    }
  }
}

extension on IncomingSplitKeyPayment {
  Future<ISKPRow> toDto() async => ISKPRow(
        id: id,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on ISKPStatus {
  ISKPStatusDto toDto() => this.map(
        privateKeyReady: always(ISKPStatusDto.privateKeyReady),
        txCreated: always(ISKPStatusDto.txCreated),
        txSent: always(ISKPStatusDto.txSent),
        success: always(ISKPStatusDto.success),
        txFailure: always(ISKPStatusDto.txFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
      );
}
