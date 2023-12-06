import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrmRepository {
  OrmRepository({
    required CryptopleaseClient cryptopleaseClient,
  }) : _client = cryptopleaseClient;

  final CryptopleaseClient _client;

  Future<String> generateAuthToken({
    required String message,
    required String signedMessage,
    required String walletAddress,
    required DateTime timestamp,
    required String quantity,
    required String appId,
  }) =>
      _client
          .generateOnRampMoneyToken(
            GenerateOnRampTokenRequestDto(
              message: message,
              signedMessage: signedMessage,
              walletAddress: walletAddress,
              timestamp: timestamp,
              quantity: quantity,
              appId: appId,
            ),
          )
          .then((p) => p.token);

  Future<ScalexOrderStatus> fetchStatus(String referenceId) => _client //TODO
      .fetchScalexTransaction(
        OrderStatusScalexRequestDto(referenceId: referenceId),
      )
      .then((it) => it.status);
}
