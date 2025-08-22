import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/dln/v1/service.pb.dart' as dln_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/moneygram/v1/service.pb.dart' as moneygram_proto;
import 'package:fixnum/fixnum.dart' as $fixnum;

extension IntExt on int {
  $fixnum.Int64 get toInt64 => $fixnum.Int64(this);
}

extension Int64Ext on $fixnum.Int64 {
  BigInt get toBigInt => BigInt.from(toInt());
}

GasFeeEstimate mapProtoToGasFeeEstimate(dln_proto.GasFeeEstimate estimate) => GasFeeEstimate(
  suggestedMaxPriorityFeePerGas: estimate.suggestedMaxPriorityFeePerGas,
  suggestedMaxFeePerGas: estimate.suggestedMaxFeePerGas,
  minWaitTimeEstimate: estimate.minWaitTimeEstimate,
  maxWaitTimeEstimate: estimate.maxWaitTimeEstimate,
);

DlnOrderStatus mapDlnOrderStatus(dln_proto.DlnOrderStatus status) => switch (status) {
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_CREATED => DlnOrderStatus.created,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_FULFILLED => DlnOrderStatus.fulfilled,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_SENT_UNLOCK => DlnOrderStatus.sentUnlock,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_ORDER_CANCELLED => DlnOrderStatus.orderCancelled,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_SENT_ORDER_CANCEL => DlnOrderStatus.sentOrderCancel,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_CLAIMED_UNLOCK => DlnOrderStatus.claimedUnlock,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_CLAIMED_ORDER_CANCEL =>
    DlnOrderStatus.claimedOrderCancel,
  dln_proto.DlnOrderStatus.DLN_ORDER_STATUS_NONE || _ => DlnOrderStatus.none,
};

extension RampTypeDtoExt on RampTypeDto {
  moneygram_proto.RampType get toProto => switch (this) {
    RampTypeDto.onRamp => moneygram_proto.RampType.RAMP_TYPE_ON,
    RampTypeDto.offRamp => moneygram_proto.RampType.RAMP_TYPE_OFF,
  };
}
