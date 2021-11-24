part of 'client.dart';

extension Convenience on RpcClient {
  Future<String> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) async {
    final recentBlockhash = await getRecentBlockhash();
    final signedTx = await signTransaction(recentBlockhash, message, signers);

    return sendTransaction(signedTx.encode());
  }
}
