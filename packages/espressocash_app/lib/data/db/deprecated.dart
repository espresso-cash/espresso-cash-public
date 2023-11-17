import 'package:drift/drift.dart';

import '../../features/transactions/models/tx_sender.dart';
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

class OSKPRows extends Table with AmountMixin, EntityMixin {
  const OSKPRows();

  IntColumn get status => intEnum<OSKPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get withdrawTxId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link1 => text().nullable()();
  TextColumn get link2 => text().nullable()();
  TextColumn get link3 => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get cancelTx => text().nullable()();
  TextColumn get cancelTxId => text().nullable()();
  DateTimeColumn get generatedLinksAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get slot => text().nullable()();
  IntColumn get apiVersion =>
      intEnum<OskpApiVersionDto>().withDefault(const Constant(0))();
}

enum OSKPStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linksReady,
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

enum OskpApiVersionDto {
  manual,
  smartContract,
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
