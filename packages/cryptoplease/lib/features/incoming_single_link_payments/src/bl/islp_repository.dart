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
import 'islp_payment.dart';

@injectable
class ISLPRepository {
  ISLPRepository(this._db);

  final MyDatabase _db;

  Future<IncomingSingleLinkPayment?> load(String id) {
    final query = _db.select(_db.iSLPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<IncomingSingleLinkPayment?> watch(String id) {
    final query = _db.select(_db.iSLPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(IncomingSingleLinkPayment payment) async =>
      _db.into(_db.iSLPRows).insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.iSLPRows).go();
}

class ISLPRows extends Table with EntityMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ISLPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum ISLPStatusDto {
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

extension on ISLPRow {
  Future<IncomingSingleLinkPayment> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return IncomingSingleLinkPayment(
      id: id,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on ISLPStatusDto {
  ISLPStatus toModel(ISLPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case ISLPStatusDto.privateKeyReady:
        return const ISLPStatus.privateKeyReady();
      case ISLPStatusDto.txCreated:
        return ISLPStatus.txCreated(tx!);
      case ISLPStatusDto.txSent:
        return ISLPStatus.txSent(tx ?? StubSignedTx(txId!));
      case ISLPStatusDto.success:
        return ISLPStatus.success(txId: txId!);
      case ISLPStatusDto.txFailure:
        return const ISLPStatus.txFailure();
      case ISLPStatusDto.txSendFailure:
        return ISLPStatus.txSendFailure(tx!);
      case ISLPStatusDto.txWaitFailure:
        return ISLPStatus.txWaitFailure(tx ?? StubSignedTx(txId!));
      case ISLPStatusDto.txEscrowFailure:
        return const ISLPStatus.txEscrowFailure();
    }
  }
}

extension on IncomingSingleLinkPayment {
  Future<ISLPRow> toDto() async => ISLPRow(
        id: id,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on ISLPStatus {
  ISLPStatusDto toDto() => this.map(
        privateKeyReady: always(ISLPStatusDto.privateKeyReady),
        txCreated: always(ISLPStatusDto.txCreated),
        txSent: always(ISLPStatusDto.txSent),
        success: always(ISLPStatusDto.success),
        txFailure: always(ISLPStatusDto.txFailure),
        txSendFailure: always(ISLPStatusDto.txSendFailure),
        txWaitFailure: always(ISLPStatusDto.txWaitFailure),
        txEscrowFailure: always(ISLPStatusDto.txEscrowFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        txWaitFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
      );
}
