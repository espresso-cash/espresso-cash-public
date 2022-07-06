import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(String address) =
      QrScannerAddressRequest;

  static QrScannerRequest? parse(String code) {
    if (isValidAddress(code)) {
      return QrScannerRequest.address(code);
    } else {
      final request = SolanaPayRequest.tryParse(code);
      if (request != null) {
        return QrScannerRequest.solanaPay(request);
      }
    }
  }
}
