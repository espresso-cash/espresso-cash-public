import 'package:flutter/widgets.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token_list.dart';
import '../bl/payment_request.dart';

extension PaymentRequestFormatAmountExt on PaymentRequest {
  String formattedAmount(Locale? locale) =>
      payRequest.cryptoAmount(TokenList())?.format(locale) ?? '';
}
