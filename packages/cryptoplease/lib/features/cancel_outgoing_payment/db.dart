import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:solana/encoder.dart';

import 'cancel_outgoing_payment.dart';

enum CancelStatusDto {
  txCreated,
  txSent,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
  success,
}

mixin CancelMixin on Table {
  IntColumn get cancelStatus => intEnum<CancelStatusDto>().nullable()();
}

extension CancelStatusDtoExt on CancelStatusDto {
  CancelStatus toCancelStatus(SignedTx? tx, String? withdrawTxId) {
    switch (this) {
      case CancelStatusDto.txCreated:
        return CancelStatus.txCreated(tx!);
      case CancelStatusDto.txSent:
        return CancelStatus.txSent(tx!);
      case CancelStatusDto.txFailure:
        return const CancelStatus.txFailure();
      case CancelStatusDto.txSendFailure:
        return CancelStatus.txSendFailure(tx!);
      case CancelStatusDto.txWaitFailure:
        return CancelStatus.txWaitFailure(tx!);
      case CancelStatusDto.txEscrowFailure:
        return const CancelStatus.txEscrowFailure();
      case CancelStatusDto.success:
        return CancelStatus.success(txId: withdrawTxId!);
    }
  }
}

extension CancelStatusExt on CancelStatus {
  CancelStatusDto toDto() => this.map(
        txCreated: always(CancelStatusDto.txCreated),
        txSent: always(CancelStatusDto.txSent),
        success: always(CancelStatusDto.success),
        txFailure: always(CancelStatusDto.txFailure),
        txSendFailure: always(CancelStatusDto.txSendFailure),
        txWaitFailure: always(CancelStatusDto.txWaitFailure),
        txEscrowFailure: always(CancelStatusDto.txEscrowFailure),
      );
}
