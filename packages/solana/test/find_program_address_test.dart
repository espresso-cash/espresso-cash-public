import 'package:solana/solana.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:test/test.dart';

void main() {
  for (final entry in _map.entries) {
    test('Generates associated token account address for ${entry.key}',
        () async {
      final address = await Ed25519HDPublicKey.findProgramAddress(
        seeds: [
          ByteArray.fromBase58(entry.key),
          ByteArray.fromBase58(TokenProgram.programId),
          ByteArray.fromBase58(_mint),
        ],
        programId: Ed25519HDPublicKey.fromBase58(
          AssociatedTokenAccountProgram.programId,
        ),
      );
      expect(address, equals(entry.value));
    });
  }
}

const _mint = '3i4L7AYcwYQgdipuWCJhf4HgAfUDU21mQtrgxuwHqQwZ';
final _map = <String, Ed25519HDPublicKey>{
  'PacBWUXCuMxQfK7XVNMSoyRYQCH1ZfmwfJPD6Uzi6pi': Ed25519HDPublicKey.fromBase58(
    '3MvNXdZK4GfNgTYCrbrj3q4yxJmRLzYqSrHf1LU87yK3',
  ),
  '7vVcBLQwT1rmjiTXhhvmHKfiaCda2giGMeKchc2jwmBN': Ed25519HDPublicKey.fromBase58(
    'HJ9iwne7NoJbyENAjrCFuUu46fJgCGTUnHiqZUifiMb',
  ),
  '3z99cfKQ2kvKxs79gJon7GeRZ3gtJWfmNG1NkZqFJKQs': Ed25519HDPublicKey.fromBase58(
    'DxEGGGc2YfohmGF8w1pudYDs72my4Qk1xFTy5WbAphSD',
  ),
  '6pr7pCxXu9cF8oP2ARRhrkDj6ikw6QyJNAZ62gyQmwjZ': Ed25519HDPublicKey.fromBase58(
    'CLmiMYTeoqGQHmNu1jBYWtu3hcPr4u32aRWAPQCwCHjP',
  ),
};
