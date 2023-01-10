// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../data/db/db.dart';
import 'oskp_cancel.dart';

@injectable
class OSKPCancelRepository {
  OSKPCancelRepository(this._db);

  final MyDatabase _db;

  Future<OSKPCancel?> load(String oskpId) {
    final query = _db.select(_db.oSKPCancelRows)
      ..where((p) => p.oskpId.equals(oskpId));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<OSKPCancel?> watch(String oskpId) {
    final query = _db.select(_db.oSKPCancelRows)
      ..where((p) => p.oskpId.equals(oskpId));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(OSKPCancel payment) async => _db
      .into(_db.oSKPCancelRows)
      .insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.oSKPCancelRows).go();
}

class OSKPCancelRows extends Table {
  TextColumn get oskpId => text()();
  DateTimeColumn get created => dateTime()();

  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<OSKPCancelStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();

  @override
  Set<Column<dynamic>>? get primaryKey => {oskpId};
}

enum OSKPCancelStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

extension on OSKPCancelRow {
  Future<OSKPCancel> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return OSKPCancel(
      oskpId: oskpId,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on OSKPCancelStatusDto {
  OSKPCancelStatus toModel(OSKPCancelRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case OSKPCancelStatusDto.txCreated:
        return OSKPCancelStatus.txCreated(tx!);
      case OSKPCancelStatusDto.txSent:
        return OSKPCancelStatus.txSent(tx!);
      case OSKPCancelStatusDto.success:
        return OSKPCancelStatus.success(txId: txId!);
      case OSKPCancelStatusDto.txFailure:
        return const OSKPCancelStatus.txFailure();
      case OSKPCancelStatusDto.txSendFailure:
        return OSKPCancelStatus.txSendFailure(tx!);
      case OSKPCancelStatusDto.txWaitFailure:
        return OSKPCancelStatus.txWaitFailure(tx!);
      case OSKPCancelStatusDto.txEscrowFailure:
        return const OSKPCancelStatus.txEscrowFailure();
    }
  }
}

extension on OSKPCancel {
  Future<OSKPCancelRow> toDto() async => OSKPCancelRow(
        oskpId: oskpId,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on OSKPCancelStatus {
  OSKPCancelStatusDto toDto() => this.map(
        txCreated: always(OSKPCancelStatusDto.txCreated),
        txSent: always(OSKPCancelStatusDto.txSent),
        success: always(OSKPCancelStatusDto.success),
        txFailure: always(OSKPCancelStatusDto.txFailure),
        txSendFailure: always(OSKPCancelStatusDto.txSendFailure),
        txWaitFailure: always(OSKPCancelStatusDto.txWaitFailure),
        txEscrowFailure: always(OSKPCancelStatusDto.txEscrowFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.txId,
        txWaitFailure: (it) => it.tx.id,
      );
}
