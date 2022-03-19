import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

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

  const factory QrScannerRequest.address(String address) =
      QrScannerAddressRequest;

  static Either<QrScannerError, QrScannerRequest> parse(
    String code, {
    required TokenList tokens,
  }) {
    if (isValidAddress(code)) {
      return Either.right(QrScannerRequest.address(code));
    } else {
      final uri = Uri.tryParse(code);
      if (uri == null) {
        return const Either.left(QrScannerError.invalidQrCode);
      }
      if (uri.scheme != 'solana') {
        return const Either.left(QrScannerError.unsupportedURIScheme);
      }

      try {
        final query = SolanaPayQuery.fromJson(uri.queryParameters);
        final splToken = query.splToken;
        final token =
            splToken == null ? Token.sol : tokens.findTokenByMint(splToken);
        if (token == null) {
          return const Either.left(QrScannerError.tokenNotFound);
        }

        final amount = query.amount;

        if (amount != null && amount.scale > token.decimals) {
          return const Either.left(
            QrScannerError.solanaPayQueryFailedToParse,
          );
        }

        final payment = QrScannerRequest.solanaPay(
          recipient: uri.path,
          reference: query.reference,
          token: token,
          amount: amount,
        );

        return Either.right(payment);
        // If anythign goes wrong, we'll just return the error.
        // It can be e.g. due to a malformed JSON.
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {
        return const Either.left(QrScannerError.solanaPayQueryFailedToParse);
      }
    }
  }
}

enum QrScannerError {
  invalidQrCode,
  tokenNotFound,
  solanaPayQueryFailedToParse,
  unsupportedURIScheme,
}

@JsonSerializable(createToJson: false)
class SolanaPayQuery {
  const SolanaPayQuery({
    required this.amount,
    required this.splToken,
    required this.reference,
    required this.memo,
  });

  factory SolanaPayQuery.fromJson(Map<String, dynamic> json) =>
      _$SolanaPayQueryFromJson(json);

  final String? memo;
  final String? reference;

  @JsonKey(name: 'spl-token')
  final String? splToken;

  @JsonKey(fromJson: _parseDecimalOrNull)
  final Decimal? amount;
}

Decimal? _parseDecimalOrNull(dynamic item) {
  if (item == null) return null;

  return Decimal.parse(item as String);
}
