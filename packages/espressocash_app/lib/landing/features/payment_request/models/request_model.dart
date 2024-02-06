import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/amount.dart';
import '../../../../features/blockchain/models/blockchain.dart';

part 'request_model.freezed.dart';

@freezed
class IncomingPaymentRequest with _$IncomingPaymentRequest {
  const factory IncomingPaymentRequest({
    required CryptoAmount requestAmount,
    required String receiverAddress,
    required String? solanaReferenceAddress,
    required String senderAddress,
    required Blockchain senderBlockchain,
  }) = _IncomingPaymentRequest;
}
