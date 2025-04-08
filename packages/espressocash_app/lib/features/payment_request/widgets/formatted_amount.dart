import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../tokens/data/token_repository.dart';
import '../models/payment_request.dart';

extension PaymentRequestFormatAmountExt on PaymentRequest {
  Future<String> formattedAmount(Locale locale) async =>
      (await payRequest.cryptoAmount(sl<TokenRepository>().getToken))?.format(locale) ?? '';
}
