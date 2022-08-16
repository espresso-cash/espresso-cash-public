import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/add_funds/data/sign_funds_client.dart';

Future<String> signFundsRequest(
  String address,
  Amount amount,
) async {
  final requestDto = SignFundsRequestDto(
    receiverAddress: address,
    tokenSymbol: amount.currency.symbol,
    value: amount.value.toDouble(),
  );

  final response = await SignFundsClient().sign(requestDto);

  return response.signedUrl;
}
