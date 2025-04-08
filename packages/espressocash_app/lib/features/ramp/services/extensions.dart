import '../../../data/db/db.dart';

extension OffRampOrderRowExt on OffRampOrderRow {
  Map<String, dynamic> toSentry() {
    final json = toJson();

    const filter = ['transaction', 'slot'];

    json.removeWhere(
      (key, value) => value == null || value == '' || filter.contains(key) || value == 0.0,
    );

    return json;
  }

  bool get shouldReportToSentry => [
    OffRampOrderStatus.failure,
    OffRampOrderStatus.depositError,
    OffRampOrderStatus.depositTxConfirmError,
    OffRampOrderStatus.insufficientFunds,
    OffRampOrderStatus.rejected,
    OffRampOrderStatus.processingRefund,
    OffRampOrderStatus.waitingForRefundBridge,
  ].contains(status);
}

extension OnRampOrderRowExt on OnRampOrderRow {
  Map<String, dynamic> toSentry() =>
      toJson()..removeWhere((key, value) => value == null || value == '' || value == 0.0);

  bool get shouldReportToSentry => [
    OnRampOrderStatus.failure,
    OnRampOrderStatus.rejected,
    OnRampOrderStatus.depositExpired,
    OnRampOrderStatus.waitingForBridge,
  ].contains(status);
}
