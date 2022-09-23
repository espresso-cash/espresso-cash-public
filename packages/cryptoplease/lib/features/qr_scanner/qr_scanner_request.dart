import 'package:cryptoplease/features/qr_scanner/qr_address_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

part 'qr_scanner_request.freezed.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay(SolanaPayRequest request) =
      QrScannerSolanaPayRequest;

  const factory QrScannerRequest.address(QrAddressData addressData) =
      QrScannerAddressRequest;

  static QrScannerRequest? parse(String code) {
    final address = QrAddressData.tryParse(code);
    if (address != null) {
      return QrScannerRequest.address(address);
    } else {
      final request = SolanaPayRequest.tryParse(code);
      if (request != null) {
        return QrScannerRequest.solanaPay(request);
      }
    }
  }
}
