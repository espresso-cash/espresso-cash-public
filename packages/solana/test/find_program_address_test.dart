import 'package:solana/src/associated_token_account_program/associated_token_account_program.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/token_program/token_program.dart';
import 'package:solana/src/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Generate associated token account address', () async {
    for (final entry in _map.entries) {
      final address = await findProgramAddress(
        seeds: [
          Buffer.fromBase58(entry.key),
          Buffer.fromBase58(TokenProgram.programId),
          Buffer.fromBase58(_mint),
        ],
        programId: AssociatedTokenAccountProgram.programId,
      );
      expect(address, equals(entry.value));
    }
  });
}

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
