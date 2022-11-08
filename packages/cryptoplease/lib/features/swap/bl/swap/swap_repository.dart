// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../swap.dart';

@injectable
class SwapRepository {
  SwapRepository(this._db);

  final MyDatabase _db;

  Future<Swap?> load(String id) {
    final query = _db.select(_db.swapRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<Swap?> watch(String id) {
    final query = _db.select(_db.swapRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(Swap payment) async =>
      _db.into(_db.swapRows).insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.swapRows).go();
}

class SwapRows extends Table with EntityMixin {
  IntColumn get status => intEnum<SwapStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum SwapStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
}

extension on SwapRow {
  Swap toModel() => Swap(
        id: id,
        status: status.toModel(this),
        created: created,
      );
}

extension on SwapStatusDto {
  SwapStatus toModel(SwapRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case SwapStatusDto.txCreated:
        return SwapStatus.txCreated(tx!);
      case SwapStatusDto.txSent:
        return SwapStatus.txSent(txId!);
      case SwapStatusDto.success:
        return SwapStatus.success(txId: txId!);
      case SwapStatusDto.txFailure:
        return const SwapStatus.txFailure();
      case SwapStatusDto.txSendFailure:
        return SwapStatus.txSendFailure(tx!);
      case SwapStatusDto.txWaitFailure:
        return SwapStatus.txWaitFailure(txId!);
    }
  }
}

extension on Swap {
  Future<SwapRow> toDto() async => SwapRow(
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on SwapStatus {
  SwapStatusDto toDto() => this.map(
        txCreated: always(SwapStatusDto.txCreated),
        txSent: always(SwapStatusDto.txSent),
        success: always(SwapStatusDto.success),
        txFailure: always(SwapStatusDto.txFailure),
        txSendFailure: always(SwapStatusDto.txSendFailure),
        txWaitFailure: always(SwapStatusDto.txWaitFailure),
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
