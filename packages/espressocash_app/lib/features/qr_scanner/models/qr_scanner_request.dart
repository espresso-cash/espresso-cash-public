import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../core/split_key_payments.dart';
import 'qr_address_data.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(QrAddressData addressData) =
      QrScannerAddressRequest;

  const factory QrScannerRequest.singleKeyPayment(SplitKeyFirstLink firstPart) =
      QrScannerSingleKeyPayment;

  const QrScannerRequest._();

  static QrScannerRequest? tryParse(String code) {
    final address = QrAddressData.tryParse(code);
    if (address != null) {
      return QrScannerRequest.address(address);
    }

    final request = SolanaPayRequest.tryParse(code);
    if (request != null) {
      return QrScannerRequest.solanaPay(request);
    }

    final uri = Uri.tryParse(code);
    if (uri != null) {
      final link = uri.queryParameters['link'];

      if (link == null) return null;

      final payment = Uri.tryParse(link)?.let(SplitKeyFirstLink.tryParse);
      if (payment != null) {
        return QrScannerRequest.singleKeyPayment(payment);
      }
    }
  }

  Ed25519HDPublicKey? get recipient => this.map(
        solanaPay: (r) => r.request.recipient,
        address: (r) => r.addressData.address,
        singleKeyPayment: always(null),
      );

  Ed25519HDPublicKey? get reference => whenOrNull<Ed25519HDPublicKey?>(
        solanaPay: (r) => r.reference?.firstOrNull,
      );
}
