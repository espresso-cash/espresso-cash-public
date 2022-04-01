import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('Account metas are correctly sorted', () async {
    final account1 = await Ed25519HDKeyPair.random();
    final account2 = await Ed25519HDKeyPair.random();
    final account3 = await Ed25519HDKeyPair.random();
    final account4 = await Ed25519HDKeyPair.random();
    final account5 = await Ed25519HDKeyPair.random();

    final unsorted1 = [
      AccountMeta.readonly(pubKey: account1.publicKey, isSigner: false),
      AccountMeta.writeable(pubKey: account2.publicKey, isSigner: false),
      AccountMeta.writeable(pubKey: account3.publicKey, isSigner: true),
      AccountMeta.writeable(pubKey: account4.publicKey, isSigner: false),
      AccountMeta.readonly(pubKey: account5.publicKey, isSigner: true),
    ];

    final sorted1 = [
      AccountMeta.writeable(pubKey: account3.publicKey, isSigner: true),
      AccountMeta.readonly(pubKey: account5.publicKey, isSigner: true),
      AccountMeta.writeable(pubKey: account2.publicKey, isSigner: false),
      AccountMeta.writeable(pubKey: account4.publicKey, isSigner: false),
      AccountMeta.readonly(pubKey: account1.publicKey, isSigner: false),
    ];

    unsorted1.sort();
    expect(unsorted1, sorted1);
    expect(unsorted1.getNumSigners(), equals(2));
    expect(unsorted1.getNumReadonlySigners(), equals(1));
  });
}
