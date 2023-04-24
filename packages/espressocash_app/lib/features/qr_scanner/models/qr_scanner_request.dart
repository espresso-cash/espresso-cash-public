import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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

  const factory QrScannerRequest.splitKeyPayment({
    required SplitKeyFirstLink firstPart,
    required SplitKeySecondLink secondPart,
  }) = QrScannerSplitKeyPayment;

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
  }

  static QrScannerRequest? tryParseMultiple(IList<String> codes) {
    if (codes.isEmpty) return null;

    final code = codes.map(tryParse).firstWhereOrNull((it) => it != null);
    if (code != null) return code;

    final firstLink =
        codes.firstWhereOrNull((e) => e.contains(espressoCashDeepLinkHost));
    final secondLink = codes.firstWhereOrNull(
      (e) => e.contains(espressoCashLinkDomain) && e.contains('k2'),
    );

    if (firstLink == null || secondLink == null) {
      return null;
    }

    final firstLongLink = Uri.tryParse(firstLink);
    final reversedLink = firstLongLink?.queryParameters['link'];

    if (reversedLink == null) return null;

    final firstPart =
        Uri.tryParse(reversedLink)?.let(SplitKeyFirstLink.tryParse);
    final secondPart =
        Uri.tryParse(secondLink)?.let(SplitKeySecondLink.tryParse);

    if (firstPart == null || secondPart == null) return null;

    return QrScannerRequest.splitKeyPayment(
      firstPart: firstPart,
      secondPart: secondPart,
    );
  }

  Ed25519HDPublicKey? get recipient => this.map(
        solanaPay: (r) => r.request.recipient,
        address: (r) => r.addressData.address,
        splitKeyPayment: always(null),
      );

  Ed25519HDPublicKey? get reference => whenOrNull<Ed25519HDPublicKey?>(
        solanaPay: (r) => r.reference?.firstOrNull,
      );
}
