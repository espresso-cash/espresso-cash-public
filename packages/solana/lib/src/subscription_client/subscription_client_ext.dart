import 'package:solana/src/rpc/rpc.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';

extension SubscriptionClientExt on SubscriptionClient {
  /// Waits for transation with [signature] to reach [status].
  /// Throws exception if transaction failed.
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
    Duration? timeout,
  }) async {
    final future = signatureSubscribe(
      signature,
      commitment: status,
    ).first;

    final result = await (timeout == null ? future : future.timeout(timeout));

    if (result.err != null) throw Exception(result.err);
  }
}
