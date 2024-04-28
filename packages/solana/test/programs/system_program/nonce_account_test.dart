// ignore_for_file: avoid-duplicate-collection-elements

import 'dart:typed_data';

import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('Parses nonce account data', () {
    const data = [
      1, 0, 0, 0, 1, 0, 0, 0, 30, 168, 20, 156, 90, 157, 98, 26, //
      237, 225, 39, 227, 238, 88, 82, 178, 228, 49, 82, 76, 47, 222, 168, 216,
      179, 162, 89, 49, 165, 46, 178, 107, 73, 231, 139, 78, 224, 117, 164, 142,
      28, 38, 178, 13, 124, 236, 53, 72, 78, 137, 113, 213, 31, 150, 92, 103,
      215, 110, 175, 106, 28, 65, 79, 153, 136, 19, 0, 0, 0, 0, 0, 0,
    ];

    final nonceAccount = NonceAccount.fromBorsh(Uint8List.fromList(data));
    expect(nonceAccount.version, 1);
    expect(nonceAccount.state, 1);
    expect(
      nonceAccount.authorizedPubkey.toBase58(),
      '34ftAgb5qa379JHBmbLBHeKyNo4j6iMYA2yRszA6U5Bp',
    );
    expect(
      nonceAccount.nonce.toBase58(),
      '5yVYNAxRAeGLamfNUictaVzw2qr8t2bVHzE3Dro1iN24',
    );
    expect(nonceAccount.lamportsPerSignature, BigInt.from(5000));
  });
}
