import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/util/find_program_address.dart';
import 'package:test/test.dart';

const _mint = '3i4L7AYcwYQgdipuWCJhf4HgAfUDU21mQtrgxuwHqQwZ';
const _map = <String, String>{
  'PacBWUXCuMxQfK7XVNMSoyRYQCH1ZfmwfJPD6Uzi6pi':
      '3MvNXdZK4GfNgTYCrbrj3q4yxJmRLzYqSrHf1LU87yK3',
  '7vVcBLQwT1rmjiTXhhvmHKfiaCda2giGMeKchc2jwmBN':
      'HJ9iwne7NoJbyENAjrCFuUu46fJgCGTUnHiqZUifiMb',
  '3z99cfKQ2kvKxs79gJon7GeRZ3gtJWfmNG1NkZqFJKQs':
      'DxEGGGc2YfohmGF8w1pudYDs72my4Qk1xFTy5WbAphSD',
  '6pr7pCxXu9cF8oP2ARRhrkDj6ikw6QyJNAZ62gyQmwjZ':
      'CLmiMYTeoqGQHmNu1jBYWtu3hcPr4u32aRWAPQCwCHjP',
};

void main() {
  test('Can generate associated token account address', () async {
    for (final entry in _map.entries) {
      final address = await findProgramAddress(
        seeds: [
          base58.decode(entry.key),
          base58.decode(TokenProgram.id),
          base58.decode(_mint),
        ],
        programId: AssociatedTokenAccountProgram.id,
      );
      expect(address, equals(entry.value));
    }
  });
}
