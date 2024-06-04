// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../transactions/models/tx_results.dart';
import '../models/incoming_link_payment.dart';

@Singleton(scope: authScope)
class ILPRepository implements Disposable {
  const ILPRepository(this._db);

  final MyDatabase _db;

  Future<IncomingLinkPayment?> load(String id) {
    final query = _db.select(_db.iLPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<IncomingLinkPayment?> watch(String id) {
    final query = _db.select(_db.iLPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(IncomingLinkPayment payment) async {
    await _db.into(_db.iLPRows).insertOnConflictUpdate(await payment.toDto());
  }

  @override
  Future<void> onDispose() => _db.delete(_db.iLPRows).go();

  Stream<IList<IncomingLinkPayment>> watchTxCreated() => _watchWithStatuses([
        ILPStatusDto.txCreated,
      ]);

  Stream<IList<IncomingLinkPayment>> watchTxSent() => _watchWithStatuses([
        ILPStatusDto.txSent,
      ]);

  Stream<IList<IncomingLinkPayment>> _watchWithStatuses(
    Iterable<ILPStatusDto> statuses,
  ) {
    final query = _db.select(_db.iLPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap((rows) => Future.wait(rows.map((row) => row.toModel())))
        .map((it) => it.lock);
  }
}

class ILPRows extends Table with EntityMixin, TxStatusMixin {
  const ILPRows();

  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ILPStatusDto>()();

  IntColumn get feeAmount => integer().nullable()();
}

enum ILPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
}

extension on ILPRow {
  Future<IncomingLinkPayment> toModel() async => IncomingLinkPayment(
        id: id,
        status: status.toModel(this),
        created: created,
        escrow: await privateKey.let(base58decode).let(EscrowPrivateKey.new),
      );
}

extension on ILPStatusDto {
  ILPStatus toModel(ILPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case ILPStatusDto.txCreated:
        return ILPStatus.txCreated(
          tx!,
        );
      case ILPStatusDto.txSent:
        return ILPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          signature: row.txId!,
        );
      case ILPStatusDto.success:
        final feeAmount = row.feeAmount;

        return ILPStatus.success(
          tx: tx ?? StubSignedTx(txId!),
          fee: feeAmount != null
              ? CryptoAmount(value: feeAmount, cryptoCurrency: Currency.usdc)
              : null,
        );
      case ILPStatusDto.txFailure:
        return ILPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
    }
  }
}

extension on IncomingLinkPayment {
  Future<ILPRow> toDto() async => ILPRow(
        id: id,
        created: created,
        privateKey: await escrow.bytes.let(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        txFailureReason: status.toTxFailureReason(),
        feeAmount: switch (status) {
          ILPStatusSuccess(:final fee) => fee?.value,
          _ => null,
        },
      );
}

extension on ILPStatus {
  ILPStatusDto toDto() => this.map(
        txCreated: always(ILPStatusDto.txCreated),
        txSent: always(ILPStatusDto.txSent),
        success: always(ILPStatusDto.success),
        txFailure: always(ILPStatusDto.txFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.signature,
        success: (it) => it.tx.id,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull(
        txFailure: (it) => it.reason,
      );
}
