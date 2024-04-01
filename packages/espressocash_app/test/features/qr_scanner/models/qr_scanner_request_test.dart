import 'package:espressocash_app/features/link_payments/models/link_payment.dart';
import 'package:espressocash_app/features/qr_scanner/models/qr_scanner_request.dart';
import 'package:espressocash_app/features/tokens/token.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valid links 1', () {
    const link = 'https://pay.espressocash.com/?t=link&k=AAAAA';
    final request = QrScannerRequest.tryParse(link);

    final expected = LinkPayment(key: 'AAAAA', token: Token.usdc.publicKey);

    expect(request, QrScannerRequest.linkPayment(expected));
  });

  test('valid links 2', () {
    const link = 'espressocash://?k=BBBBB';
    final request = QrScannerRequest.tryParse(link);

    final expected = LinkPayment(key: 'BBBBB', token: Token.usdc.publicKey);

    expect(request, QrScannerRequest.linkPayment(expected));
  });
}
