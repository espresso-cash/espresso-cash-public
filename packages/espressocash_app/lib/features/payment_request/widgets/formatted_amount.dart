import 'package:espressocash_common/flutter.dart';
import 'package:flutter/widgets.dart';

import '../../tokens/token_list.dart';
import '../models/payment_request.dart';

extension PaymentRequestFormatAmountExt on PaymentRequest {
  String formattedAmount(Locale locale) =>
      payRequest.cryptoAmount(TokenList())?.format(locale) ?? '';
}
