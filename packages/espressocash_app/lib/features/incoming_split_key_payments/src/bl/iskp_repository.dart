// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../../core/api_version.dart';
import '../../../../core/escrow_private_key.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import 'incoming_split_key_payment.dart';

@injectable
class ISKPRepository {
  const ISKPRepository(this._db);

  final MyDatabase _db;

  Future<IncomingSplitKeyPayment?> load(String id) {
    final query = _db.select(_db.iSKPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<IncomingSplitKeyPayment?> watch(String id) {
    final query = _db.select(_db.iSKPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(IncomingSplitKeyPayment payment) async {
    await payment.status.maybeMap(
      txFailure: (status) async {
        await Sentry.captureMessage(
          'ISKP tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      orElse: () async {},
    );

    await _db.into(_db.iSKPRows).insertOnConflictUpdate(await payment.toDto());
  }

  Future<void> clear() => _db.delete(_db.iSKPRows).go();

  Stream<IList<IncomingSplitKeyPayment>> watchTxCreated() =>
      _watchWithStatuses([
        ISKPStatusDto.txCreated,
        ISKPStatusDto.txSendFailure,
      ]);

  Stream<IList<IncomingSplitKeyPayment>> watchTxSent() => _watchWithStatuses([
        ISKPStatusDto.txSent,
        ISKPStatusDto.txWaitFailure,
      ]);

  Stream<IList<IncomingSplitKeyPayment>> _watchWithStatuses(
    Iterable<ISKPStatusDto> statuses,
  ) {
    final query = _db.select(_db.iSKPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap((rows) => Future.wait(rows.map((row) => row.toModel())))
        .map((it) => it.lock);
  }
}

class ISKPRows extends Table with EntityMixin, TxStatusMixin {
  const ISKPRows();

  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ISKPStatusDto>()();
  IntColumn get apiVersion =>
      intEnum<IskpApiVersionDto>().withDefault(const Constant(0))();
}

enum ISKPStatusDto {
  @Deprecated('State not valid. Use txCreated directly.')
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  @Deprecated('Use txCreated instead.')
  txSendFailure,
  @Deprecated('Use txSent instead.')
  txWaitFailure,
  @Deprecated('Use txFailure instead.')
  txEscrowFailure,
}

enum IskpApiVersionDto {
  manual,
  smartContract,
}

extension on ISKPRow {
  Future<IncomingSplitKeyPayment> toModel() async => IncomingSplitKeyPayment(
        id: id,
        status: status.toModel(this),
        created: created,
        escrow: await privateKey.let(base58decode).let(EscrowPrivateKey.new),
        apiVersion: apiVersion.toModel(),
      );
}

extension on ISKPStatusDto {
  ISKPStatus toModel(ISKPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case ISKPStatusDto.privateKeyReady:
        return const ISKPStatus.txFailure(
          reason: TxFailureReason.unknown,
        );
      case ISKPStatusDto.txCreated:
      case ISKPStatusDto.txSendFailure:
        return ISKPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ISKPStatusDto.txSent:
      case ISKPStatusDto.txWaitFailure:
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
      case ISKPStatusDto.txEscrowFailure:
        return const ISKPStatus.txFailure(
          reason: TxFailureReason.escrowFailure,
        );
    }
  }
}

extension on IncomingSplitKeyPayment {
  Future<ISKPRow> toDto() async => ISKPRow(
        id: id,
        created: created,
        privateKey: await escrow.bytes.let(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        slot: status.toSlot()?.toString(),
        txFailureReason: status.toTxFailureReason(),
        apiVersion: apiVersion.toDto(),
      );
}

extension on ISKPStatus {
  ISKPStatusDto toDto() => this.map(
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

  TxFailureReason? toTxFailureReason() => mapOrNull(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
      );
}

extension on SplitKeyApiVersion {
  IskpApiVersionDto toDto() {
    switch (this) {
      case SplitKeyApiVersion.manual:
        return IskpApiVersionDto.manual;
      case SplitKeyApiVersion.smartContract:
        return IskpApiVersionDto.smartContract;
    }
  }
}

extension on IskpApiVersionDto {
  SplitKeyApiVersion toModel() {
    switch (this) {
      case IskpApiVersionDto.manual:
        return SplitKeyApiVersion.manual;
      case IskpApiVersionDto.smartContract:
        return SplitKeyApiVersion.smartContract;
    }
  }
}
