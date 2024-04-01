import 'package:espressocash_common/dart.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../features/blockchain/models/blockchain.dart';

part 'request_model.freezed.dart';

@freezed
class IncomingPaymentRequest with _$IncomingPaymentRequest {
  const factory IncomingPaymentRequest({
    required CryptoAmount requestAmount,
    required String receiverAddress,
    required String? solanaReferenceAddress,
    required String? receiverName,
  }) = _IncomingPaymentRequest;
}

@freezed
class UserWalletInfo with _$UserWalletInfo {
  const factory UserWalletInfo({
    required String address,
    required Blockchain blockchain,
  }) = _UserWalletInfo;
}
