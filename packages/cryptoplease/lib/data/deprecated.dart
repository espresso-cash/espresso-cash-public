import 'package:drift/drift.dart';

import '../core/transactions/tx_sender.dart';
import 'db/mixins.dart';

class ITRows extends Table with EntityMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ITStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum ITStatusDto {
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

class OTRows extends Table with AmountMixin, EntityMixin {
  IntColumn get status => intEnum<OTStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get withdrawTxId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get cancelTx => text().nullable()();
  TextColumn get cancelTxId => text().nullable()();
}

enum OTStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linkReady,
  success, // Legacy
  txFailure,
  txSendFailure,
  txWaitFailure,
  txLinksFailure,
  withdrawn,
  canceled,
  cancelTxCreated,
  cancelTxFailure,
  cancelTxSent,
  cancelTxSendFailure,
  cancelTxWaitFailure,
}
