import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../models/tx_results.dart';

@injectable
class TxConfirm {
  const TxConfirm({
    required SolanaClient client,
  }) : _client = client;

  final SolanaClient _client;

  Future<TxWaitResult?> call({
    required String signature,
    Commitment commitment = Commitment.confirmed,
  }) async {
    try {
      await _client.waitForSignatureStatus(
        signature,
        status: commitment,
        pingInterval: pingDefaultInterval,
        timeout: waitForSignatureDefaultTimeout,
      );

      return const TxWaitResult.success();
    } on SubscriptionClientException {
      return const TxWaitResult.failure(reason: TxFailureReason.txError);
    } on Exception {
      return null;
    }
  }
}
