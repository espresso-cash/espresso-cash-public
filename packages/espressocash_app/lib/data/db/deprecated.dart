import 'package:drift/drift.dart';

import '../../core/transactions/tx_sender.dart';
import '../../features/outgoing_split_key_payments/db.dart';
import 'mixins.dart';

class ITRows extends Table with EntityMixin {
  const ITRows();

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
  const OTRows();

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

extension OTStatusDtoExt on OTStatusDto {
  OSKPStatusDto toOSKPStatus() {
    switch (this) {
      case OTStatusDto.txCreated:
        return OSKPStatusDto.txCreated;
      case OTStatusDto.txSent:
        return OSKPStatusDto.txSent;
      case OTStatusDto.txConfirmed:
      case OTStatusDto.linkReady:
        // Since we do not have both links coming from OTP but we have escrow,
        // we can use txConfirmed status so that bloc will generate links.
        return OSKPStatusDto.txConfirmed;
      case OTStatusDto.success:
        return OSKPStatusDto.success;
      case OTStatusDto.txFailure:
        return OSKPStatusDto.txFailure;
      case OTStatusDto.txSendFailure:
        return OSKPStatusDto.txSendFailure;
      case OTStatusDto.txWaitFailure:
        return OSKPStatusDto.txWaitFailure;
      case OTStatusDto.txLinksFailure:
        return OSKPStatusDto.txLinksFailure;
      case OTStatusDto.withdrawn:
        return OSKPStatusDto.withdrawn;
      case OTStatusDto.canceled:
        return OSKPStatusDto.canceled;
      case OTStatusDto.cancelTxCreated:
        return OSKPStatusDto.cancelTxCreated;
      case OTStatusDto.cancelTxFailure:
        return OSKPStatusDto.cancelTxFailure;
      case OTStatusDto.cancelTxSent:
        return OSKPStatusDto.cancelTxSent;
      case OTStatusDto.cancelTxSendFailure:
        return OSKPStatusDto.cancelTxSendFailure;
      case OTStatusDto.cancelTxWaitFailure:
        return OSKPStatusDto.cancelTxWaitFailure;
    }
  }
}
