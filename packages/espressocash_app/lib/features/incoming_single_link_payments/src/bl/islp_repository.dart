// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../../core/escrow_private_key.dart';
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

class ISLPRows extends Table with EntityMixin, TxStatusMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ISLPStatusDto>()();
}

enum ISLPStatusDto {
  @Deprecated('State invalid. Use txCreated directly,')
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  @Deprecated('Use txCreated instead')
  txSendFailure,
  @Deprecated('Use txSent instead')
  txWaitFailure,
  @Deprecated('Use txFailure instead')
  txEscrowFailure,
}

extension on ISLPRow {
  Future<IncomingSingleLinkPayment> toModel() async =>
      IncomingSingleLinkPayment(
        id: id,
        status: status.toModel(this),
        created: created,
        escrow: privateKey.let(base58decode).let(EscrowPrivateKey.new),
      );
}

extension on ISLPStatusDto {
  ISLPStatus toModel(ISLPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case ISLPStatusDto.privateKeyReady:
        return const ISLPStatus.txFailure(
          reason: TxFailureReason.unknown,
        );
      case ISLPStatusDto.txCreated:
        return ISLPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ISLPStatusDto.txSent:
        return ISLPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          slot: slot ?? BigInt.zero,
        );
      case ISLPStatusDto.success:
        return ISLPStatus.success(txId: txId!);
      case ISLPStatusDto.txFailure:
        return ISLPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case ISLPStatusDto.txSendFailure:
        return ISLPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ISLPStatusDto.txWaitFailure:
        return ISLPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          slot: slot ?? BigInt.zero,
        );
      case ISLPStatusDto.txEscrowFailure:
        return const ISLPStatus.txFailure(
          reason: TxFailureReason.escrowFailure,
        );
    }
  }
}

extension on IncomingSingleLinkPayment {
  Future<ISLPRow> toDto() async => ISLPRow(
        id: id,
        created: created,
        privateKey: await escrow.bytes.let(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        slot: status.toSlot()?.toString(),
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on ISLPStatus {
  ISLPStatusDto toDto() => this.map(
        txCreated: always(ISLPStatusDto.txCreated),
        txSent: always(ISLPStatusDto.txSent),
        success: always(ISLPStatusDto.success),
        txFailure: always(ISLPStatusDto.txFailure),
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
