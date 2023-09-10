import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import 'coinflow_client.dart';

@injectable
class CoinflowRepository {
  CoinflowRepository({
    required CoinflowClient coinflowClient,
  }) : _coinflowClient = coinflowClient;

  final CoinflowClient _coinflowClient;

  Future<WithdrawResponseDataDto?> getWithdrawalStatus({
    required String txId,
    required String walletId,
  }) async =>
      _coinflowClient.getWithdrawalHistory(walletId).letAsync(
            (response) => response.withdraws
                .firstWhereOrNull((element) => element.transaction == txId),
          );
}
