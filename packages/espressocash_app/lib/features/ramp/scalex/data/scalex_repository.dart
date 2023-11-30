import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScalexRepository {
  ScalexRepository({
    required CryptopleaseClient cryptopleaseClient,
  }) : _client = cryptopleaseClient;

  final CryptopleaseClient _client;

  Future<String> generateLink({
    required String type,
    required String address,
    required String email,
  }) =>
      _client
          .generateScalexLink(
            GenerateScalexLinkRequestDto(
              type: type,
              address: address,
              email: email,
            ),
          )
          .letAsync((p) => p.signedUrl);

  Future<OrderStatusScalexResponseDto> fetchStatus(String referenceId) =>
      _client.fetchScalexTransaction(
        OrderStatusScalexRequestDto(referenceId: referenceId),
      );
}
