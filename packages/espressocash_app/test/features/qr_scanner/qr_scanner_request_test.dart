import 'package:espressocash_app/core/api_version.dart';
import 'package:espressocash_app/core/split_key_payments.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/features/qr_scanner/models/qr_scanner_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valid links 1', () {
    const link1 = 'https://espressocash.page.link/?'
        'link=https://link.espressocash.com?k1%3DAAAAA%26source%3Dqr'
        '&apn=com.pleasecrypto.flutter'
        '&isi=1559625715'
        '&ibi=com.pleasecrypto.flutter';
    const link2 = 'https://link.espressocash.com?k2=BBBBB';

    //TODO fix and test links

    final request = QrScannerRequest.tryParse(link1);

    expect(
      request,
      QrScannerRequest.singleKeyPayment(
        SplitKeyFirstLink(
          apiVersion: SplitKeyApiVersion.smartContract,
          key: 'AAAAA',
          source: SplitKeySource.qr,
          token: Token.usdc.publicKey,
        ),
      ),
    );
  });
}
