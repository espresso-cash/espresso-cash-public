import 'package:flutter/widgets.dart';

import '../../conversion_rates/widgets/extensions.dart';
import '../models/payment_request.dart';

extension PaymentRequestFormatAmountExt on PaymentRequest {
  Future<String> formattedAmount(Locale locale) async =>
      (await payRequest.cryptoAmount())?.format(locale) ?? '';
}
