import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../config.dart';
import '../../../core/split_key_payments.dart';
import 'qr_address_data.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(QrAddressData addressData) =
      QrScannerAddressRequest;

  const factory QrScannerRequest.qrPayment({
    required SplitQrLink firstPart,
    required SplitKeySecondLink secondPart,
  }) = QrScannerPaymentRequest;

  const QrScannerRequest._();

  static QrScannerRequest? parse(String code) {
    final address = QrAddressData.tryParse(code);
    if (address != null) {
      return QrScannerRequest.address(address);
    }

    final request = SolanaPayRequest.tryParse(code);
    if (request != null) {
      return QrScannerRequest.solanaPay(request);
    }
  }

  static QrScannerRequest? tryParse(List<String> codes) {
    final code = codes.map(parse).first;

    if (code != null) {
      return code;
    }

    final firstLink = codes.firstWhereOrNull((e) => e.contains(cpDeepLinkHost));
    final secondLink = codes.firstWhereOrNull((e) => e.contains(link2Host));

    if (firstLink == null || secondLink == null) {
      return null;
    }

    final firstLongLink = Uri.parse(firstLink);
    final reversedLink = firstLongLink.queryParameters['link'];

    if (reversedLink == null) {
      return null;
    }

    final firstPart = SplitQrLink.tryParse(Uri.parse(reversedLink));
    final secondPart = SplitKeySecondLink.tryParse(Uri.parse(secondLink));

    if (firstPart != null && secondPart != null) {
      return QrScannerRequest.qrPayment(
        firstPart: firstPart,
        secondPart: secondPart,
      );
    }
  }

  Ed25519HDPublicKey? get recipient => this.map(
        solanaPay: (r) => r.request.recipient,
        address: (r) => r.addressData.address,
        qrPayment: always(null),
      );

  Ed25519HDPublicKey? get reference => whenOrNull<Ed25519HDPublicKey?>(
        solanaPay: (r) => r.reference?.firstOrNull,
      );
}
