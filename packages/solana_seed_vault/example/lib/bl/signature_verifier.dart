import 'package:dfunc/dfunc.dart';
import 'package:solana/solana.dart' as solana;
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/utils.dart';

class SignatureVerifier {
  const SignatureVerifier();
  Future<String> verify({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
    required List<SigningResponse> signingResponses,
  }) =>
      tryEitherAsync((_) async {
        if (signingRequests.length != signingResponses.length) {
          throw Exception(
            'Mismatch between number of requested and provided signatures',
          );
        }

        for (final pair
            in Map.fromIterables(signingRequests, signingResponses).entries) {
          final request = pair.key;
          final response = pair.value;

          final publicKeys = await getPublicKeysFromPaths(
            authToken,
            response.resolvedDerivationPaths,
          );

          if (publicKeys.length != response.signatures.length) {
            throw Exception('One or more public keys not found');
          }

          final hasSignatureVerified = await Future.wait(
            Map.fromIterables(response.signatures, publicKeys).entries.map(
                  (pair) => solana.verifySignature(
                    message: request.payload.toList(),
                    signature: pair.key.toList(),
                    publicKey: pair.value,
                  ),
                ),
          ).letAsync((it) => it.every(identity));

          if (!hasSignatureVerified) {
            throw Exception('One or more signatures not valid');
          }
        }

        return true;
      }).foldAsync(
        (e) => 'Error while verifying signatures: $e',
        (_) => 'Payloads signed successfully',
      );
}
