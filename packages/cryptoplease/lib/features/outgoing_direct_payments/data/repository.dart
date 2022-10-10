// ignore_for_file: avoid-non-null-assertion

import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/data/db/mixins.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class DbODPRepository implements ODPRepository {
  DbODPRepository(this.db, this.tokens);

  final MyDatabase db;
  final TokenList tokens;

  @override
  Future<OutgoingDirectPayment?> load(String id) {
    final query = db.select(db.oDPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(tokens));
  }

  @override
  Stream<OutgoingDirectPayment?> watch(String id) {
    final query = db.select(db.oDPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().map((row) => row?.toModel(tokens));
  }

  @override
  Future<void> save(OutgoingDirectPayment payment) =>
      db.into(db.oDPRows).insertOnConflictUpdate(payment.toDto());

  @override
  Future<void> clear() => db.delete(db.oDPRows).go();
}

class ODPRows extends Table with AmountMixin, EntityMixin {
  TextColumn get receiver => text()();
  IntColumn get status => intEnum<ODPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum ODPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
}

extension on ODPRow {
  OutgoingDirectPayment toModel(TokenList tokens) => OutgoingDirectPayment(
        id: id,
        receiver: Ed25519HDPublicKey.fromBase58(receiver),
        amount: CryptoAmount(
          value: amount,
          currency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        created: created,
        status: status.toModel(this),
      );
}

extension on ODPStatusDto {
  ODPStatus toModel(ODPRow row) {
    switch (this) {
      case ODPStatusDto.txCreated:
        return ODPStatus.txCreated(SignedTx.decode(row.tx!));
      case ODPStatusDto.txSent:
        return ODPStatus.txSent(row.txId!);
      case ODPStatusDto.success:
        return ODPStatus.success(txId: row.txId!);
      case ODPStatusDto.txFailure:
        return const ODPStatus.txFailure();
      case ODPStatusDto.txSendFailure:
        return ODPStatus.txSendFailure(SignedTx.decode(row.tx!));
      case ODPStatusDto.txWaitFailure:
        return ODPStatus.txWaitFailure(row.txId!);
    }
  }
}

extension on OutgoingDirectPayment {
  ODPRow toDto() => ODPRow(
        id: id,
        receiver: receiver.toBase58(),
        amount: amount.value,
        token: amount.currency.token.address,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
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
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.txId,
        txWaitFailure: (it) => it.txId,
        success: (it) => it.txId,
      );
}
