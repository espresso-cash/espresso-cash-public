import 'package:freezed_annotation/freezed_annotation.dart';

import '../../blockchain/models/blockchain.dart';
import '../../currency/models/amount.dart';

part 'dln_payment.freezed.dart';

@freezed
class DlnPayment with _$DlnPayment {
  const factory DlnPayment({
    required CryptoAmount inputAmount,
    required String receiverAddress,
    required Blockchain receiverBlockchain,
  }) = _DlnPayment;
}
