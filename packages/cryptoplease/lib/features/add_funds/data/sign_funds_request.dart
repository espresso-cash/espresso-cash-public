import 'package:cryptoplease/features/add_funds/data/sign_funds_client.dart';
import 'package:decimal/decimal.dart';

Future<String> signFundsRequest(
  String address,
  Decimal value,
  String tokenSymbol,
) async {
  final requestDto = SignFundsRequestDto(
    receiverAddress: address,
    tokenSymbol: tokenSymbol,
    value: value.toDouble(),
  );

  final response = await SignFundsClient().sign(requestDto);

  return response.signedUrl;
}
