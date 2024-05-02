import 'package:freezed_annotation/freezed_annotation.dart';

import '../../currency/models/amount.dart';

part 'transaction_request.freezed.dart';

@freezed
class TransactionRequestPayment with _$TransactionRequestPayment {
  const factory TransactionRequestPayment({
    required String id,
    required DateTime created,
    required TRStatus status,
    required CryptoAmount amount,
    required String label,
    required String txId,
  }) = _OutgoingDirectPayment;
}

enum TRStatus {
  created,
  sent,
  success,
  failure,
}
