import 'dart:convert';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:solana/encoder.dart';

extension CreatePaymentExt on CreatePaymentResponseDto {
  Message decompileMessage() => transaction.message;
}

extension ReceivePaymentExt on ReceivePaymentResponseDto {
  Message decompileMessage() => transaction.message;
}

extension on String {
  Message get message {
    final decoded = base64Decode(this);
    final byteArray = ByteArray(decoded);
    final compiled = CompiledMessage.fromSignedTransaction(byteArray);

    return Message.decompile(compiled);
  }
}
