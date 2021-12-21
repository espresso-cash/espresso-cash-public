part of 'subscription_client.dart';

extension SubscriptionClientConvenienceMethods on SubscriptionClient {
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
  }) {
    return signatureSubscribe(signature, commitment: status).first;
  }
}
