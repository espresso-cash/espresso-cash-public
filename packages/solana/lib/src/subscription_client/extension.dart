part of 'subscription_client.dart';

extension SubscriptionClientExt on SubscriptionClient {
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
  }) async =>
      await signatureSubscribe(signature, commitment: status).first;
}
