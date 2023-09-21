import 'package:espressocash_app/core/link_payments.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/features/qr_scanner/models/qr_scanner_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valid links 1', () {
    const link1 = 'https://link.espressocash.com/?k=AAAAA';
    const link2 = 'espressocash://?k=BBBBB';

    final request1 = QrScannerRequest.tryParse(link1);

    expect(
      request1,
      QrScannerRequest.singleKeyPayment(
        LinkPayments(
          key: 'AAAAA',
          token: Token.usdc.publicKey,
        ),
      ),
    );

    final request2 = QrScannerRequest.tryParse(link2);

    expect(
      request2,
      QrScannerRequest.singleKeyPayment(
        LinkPayments(
          key: 'BBBBB',
          token: Token.usdc.publicKey,
        ),
      ),
    );
  });
}
