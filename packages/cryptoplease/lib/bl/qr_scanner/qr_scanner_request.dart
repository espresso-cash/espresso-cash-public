import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_scanner_request.freezed.dart';
part 'qr_scanner_request.g.dart';

@freezed
class QrScannerRequest with _$QrScannerRequest {
  const factory QrScannerRequest.solanaPay({
    required String recipient,
    required Token token,
    Decimal? amount,
    String? reference,
  }) = QrScannerSolanaPayRequest;

  const factory QrScannerRequest.error(Exception? exception) =
      QrScannerErrorRequest;

  const factory QrScannerRequest.address(String address) =
      QrScannerAddressRequest;
}

@JsonSerializable()
class SolanaPayQuery {
  const SolanaPayQuery({
    required this.amount,
    required this.splToken,
    required this.reference,
    required this.memo,
  });

  factory SolanaPayQuery.fromJson(Map<String, dynamic> json) =>
      _$SolanaPayQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SolanaPayQueryToJson(this);

  final String? memo;
  final String? reference;

  @JsonKey(name: 'spl-token')
  final String? splToken;

  @JsonKey(fromJson: _parseDoubleOrNull)
  final double? amount;
}

double? _parseDoubleOrNull(dynamic item) {
  if (item is! String) {
    return null;
  }

  return double.tryParse(item);
}
