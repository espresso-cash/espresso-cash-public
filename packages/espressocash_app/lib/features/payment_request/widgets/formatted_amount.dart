import 'package:flutter/widgets.dart';

import '../../conversion_rates/widgets/extensions.dart';
import '../../tokens/token_list.dart';
import '../models/payment_request.dart';

extension PaymentRequestFormatAmountExt on PaymentRequest {
  Future<String> formattedAmount(Locale locale) async =>
      (await payRequest.cryptoAmount(TokenList()))?.format(locale) ?? '';
}
