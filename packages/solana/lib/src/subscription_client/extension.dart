part of 'subscription_client.dart';

extension SubscriptionClientConvenienceMethods on SubscriptionClient {
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
  }) async {
    final result =
        await signatureSubscribe(signature, commitment: status).first;
    if (result.err != null) {
      // FIXME(IA): use the error information
      throw Exception('an error occurred while waiting for a signature status');
    }
  }
}
