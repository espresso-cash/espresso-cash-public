import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../core/link_payments.dart';
import '../../../core/split_key_payments.dart';
import 'qr_address_data.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(QrAddressData addressData) =
      QrScannerAddressRequest;

  const factory QrScannerRequest.splitKeyPayment({
    required SplitKeyFirstLink firstPart,
    required SplitKeySecondLink secondPart,
  }) = QrScannerSplitKeyPayment;

  const factory QrScannerRequest.singleKeyPayment(LinkPayments payment) =
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

    final payment = Uri.tryParse(code)?.let(LinkPayments.tryParse);
    if (payment != null) {
      return QrScannerRequest.singleKeyPayment(payment);
    }
  }

  Ed25519HDPublicKey? get recipient => this.map(
        solanaPay: (r) => r.request.recipient,
        address: (r) => r.addressData.address,
        singleKeyPayment: always(null),
        splitKeyPayment: always(null),
      );

  Ed25519HDPublicKey? get reference => whenOrNull<Ed25519HDPublicKey?>(
        solanaPay: (r) => r.reference?.firstOrNull,
      );
}
