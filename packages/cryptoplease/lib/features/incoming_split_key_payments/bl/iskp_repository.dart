// ignore_for_file: avoid-non-null-assertion

import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/data/db/mixins.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/incoming_split_key_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

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

class ISKPRows extends Table with EntityMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ISKPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum ISKPStatusDto {
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
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

    switch (this) {
      case ISKPStatusDto.privateKeyReady:
        return const ISKPStatus.privateKeyReady();
      case ISKPStatusDto.txCreated:
        return ISKPStatus.txCreated(tx!);
      case ISKPStatusDto.txSent:
        return ISKPStatus.txSent(txId!);
      case ISKPStatusDto.success:
        return ISKPStatus.success(txId: txId!);
      case ISKPStatusDto.txFailure:
        return const ISKPStatus.txFailure();
      case ISKPStatusDto.txSendFailure:
        return ISKPStatus.txSendFailure(tx!);
      case ISKPStatusDto.txWaitFailure:
        return ISKPStatus.txWaitFailure(txId!);
      case ISKPStatusDto.txEscrowFailure:
        return const ISKPStatus.txEscrowFailure();
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
        txSendFailure: always(ISKPStatusDto.txSendFailure),
        txWaitFailure: always(ISKPStatusDto.txWaitFailure),
        txEscrowFailure: always(ISKPStatusDto.txEscrowFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.txId,
        success: (it) => it.txId,
        txWaitFailure: (it) => it.txId,
      );
}
