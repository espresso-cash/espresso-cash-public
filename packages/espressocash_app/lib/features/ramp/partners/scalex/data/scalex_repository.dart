import 'package:espressocash_api/espressocash_api.dart';

import 'package:injectable/injectable.dart';

import '../../../../currency/models/currency.dart';

@injectable
class ScalexRepository {
  const ScalexRepository({
    required EspressoCashClient ecClient,
  }) : _client = ecClient;

  final EspressoCashClient _client;

  Future<String> generateLink({
    required String type,
    required String address,
    required String email,
    required double amount,
  }) =>
      _client
          .generateScalexLink(
            GenerateScalexLinkRequestDto(
              type: type,
              address: address,
              email: email,
              amount: amount,
              currency: Currency.ngn.symbol,
            ),
          )
          .then((p) => p.signedUrl);

  Future<ScalexOrderStatus> fetchStatus(String referenceId) => _client
      .fetchScalexTransaction(
        OrderStatusScalexRequestDto(referenceId: referenceId),
      )
      .then((it) => it.status);

  Future<ScalexRateFeeResponseDto> fetchRateAndFee() =>
      _client.fetchScalexFeesAndRate();
}
