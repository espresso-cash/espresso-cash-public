import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../core/link_payments.dart';
import '../../../core/solana_helpers.dart';
import 'qr_address_data.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(QrAddressData addressData) =
      QrScannerAddressRequest;

  const factory QrScannerRequest.linkPayment(LinkPayments payment) =
      QrScannerLinkPayment;

  const QrScannerRequest._();

  static QrScannerRequest? tryParse(String code) {
    final address = QrAddressData.tryParse(code);
    if (address != null) {
      return QrScannerRequest.address(address);
    }

    final solanaPayRequest = SolanaPayRequest.tryParse(code);
    if (solanaPayRequest != null) {
      return QrScannerRequest.solanaPay(solanaPayRequest);
    }

    final espressocashRequest =
        Uri.tryParse(code)?.let(tryParseSolanaPayRequest);
    if (espressocashRequest != null) {
      return QrScannerRequest.solanaPay(espressocashRequest);
    }

    final payment = Uri.tryParse(code)?.let(LinkPayments.tryParse);
    if (payment != null) {
      return QrScannerRequest.linkPayment(payment);
    }
  }

  Ed25519HDPublicKey? get recipient => this.map(
        solanaPay: (r) => r.request.recipient,
        address: (r) => switch (r.addressData) {
          QrAddressDataSolana(:final address) => address,
          QrAddressDataEvm() => null,
        },
        linkPayment: always(null),
      );

  Ed25519HDPublicKey? get reference => whenOrNull<Ed25519HDPublicKey?>(
        solanaPay: (r) => r.reference?.firstOrNull,
      );
}
