// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../../models/outgoing_direct_payment.dart';

@injectable
class ODPRepository {
  ODPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingDirectPayment?> load(String id) {
    final query = _db.select(_db.oDPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<OutgoingDirectPayment> watch(String id) {
    final query = _db.select(_db.oDPRows)..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toModel(_tokens));
  }

  Future<void> save(OutgoingDirectPayment payment) async {
    await payment.status.maybeMap(
      txFailure: (status) async {
        await Sentry.captureMessage(
          'ODP tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      orElse: () async {},
    );

    await _db.into(_db.oDPRows).insertOnConflictUpdate(payment.toDto());
  }

  Future<void> clear() => _db.delete(_db.oDPRows).go();

  Stream<IList<OutgoingDirectPayment>> watchTxCreated() => _watchWithStatuses([
        ODPStatusDto.txCreated,
        ODPStatusDto.txSendFailure,
      ]);

  Stream<IList<OutgoingDirectPayment>> watchTxSent() => _watchWithStatuses([
        ODPStatusDto.txSent,
        ODPStatusDto.txWaitFailure,
      ]);

  Stream<IList<OutgoingDirectPayment>> _watchWithStatuses(
    Iterable<ODPStatusDto> statuses,
  ) {
    final query = _db.select(_db.oDPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .map((rows) => rows.map((row) => row.toModel(_tokens)))
        .map((event) => event.toIList());
  }
}

class ODPRows extends Table with AmountMixin, EntityMixin {
  TextColumn get receiver => text()();
  TextColumn get reference => text().nullable()();
  IntColumn get status => intEnum<ODPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
}

enum ODPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure, // Legacy
  txWaitFailure, // Legacy
}

extension ODPRowExt on ODPRow {
  OutgoingDirectPayment toModel(TokenList tokens) => OutgoingDirectPayment(
        id: id,
        receiver: Ed25519HDPublicKey.fromBase58(receiver),
        reference: reference?.let(Ed25519HDPublicKey.fromBase58),
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        created: created,
        status: status.toModel(this),
      );
}

extension on ODPStatusDto {
  ODPStatus toModel(ODPRow row) {
    final tx = row.tx?.let(SignedTx.decode);

    switch (this) {
      case ODPStatusDto.txCreated:
        return ODPStatus.txCreated(tx!);
      case ODPStatusDto.txSent:
        return ODPStatus.txSent(tx ?? StubSignedTx(row.txId!));
      case ODPStatusDto.success:
        return ODPStatus.success(txId: row.txId!);
      case ODPStatusDto.txFailure:
        return ODPStatus.txFailure(reason: row.txFailureReason);
      case ODPStatusDto.txSendFailure:
        return ODPStatus.txCreated(tx!);
      case ODPStatusDto.txWaitFailure:
        return ODPStatus.txSent(tx ?? StubSignedTx(row.txId!));
    }
  }
}

extension on OutgoingDirectPayment {
  ODPRow toDto() => ODPRow(
        id: id,
        receiver: receiver.toBase58(),
        reference: reference?.toBase58(),
        amount: amount.value,
        token: amount.cryptoCurrency.token.address,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on ODPStatus {
  ODPStatusDto toDto() => this.map(
        txCreated: always(ODPStatusDto.txCreated),
        txSent: always(ODPStatusDto.txSent),
        success: always(ODPStatusDto.success),
        txFailure: always(ODPStatusDto.txFailure),
        txSendFailure: always(ODPStatusDto.txSendFailure),
        txWaitFailure: always(ODPStatusDto.txWaitFailure),
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

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );
}
