import 'package:solana/encoder.dart';
import 'package:test/test.dart';

void main() {
  test('Account metas are correctly sorted', () {
    final accounts = _instructionList.getAccountsWithOptionalFeePayer(
        feePayer: '9KaA7vEBUdRCcBWxfuMjxYwKfvu8Us3Cg5gkhVFt2LNk');
    for (var i = 0; i < accounts.length; i++) {
      expect(accounts[i].pubKey, equals(_expectedResult[i]));
    }
  });
}

final _instructionList = [
  Instruction(
    programId: '6KR4qkJN91LGko2gdizheri8LMtCwsJrhtsQt6QPwCi5',
    accounts: [
      AccountMeta(
          pubKey: 'JBm16mKFNXotwiYjdGuVJcLBeuJdQkT84aNBNhnakToW',
          isWriteable: false,
          isSigner: false),
    ],
    data: [],
  ),
  Instruction(
    programId: 'DAz7SnxRL2HRZ2GPigdVRGkoF39bD4Qdv8td5wD3i35u',
    accounts: [
      AccountMeta(
          pubKey: '2qXtx3xmmmJyA64vrszWAqSXEvYaQNAo1yL4tCxBYPZv',
          isWriteable: false,
          isSigner: false),
    ],
    data: [],
  ),
];

final _expectedResult = [
  '9KaA7vEBUdRCcBWxfuMjxYwKfvu8Us3Cg5gkhVFt2LNk',
  'JBm16mKFNXotwiYjdGuVJcLBeuJdQkT84aNBNhnakToW',
  '2qXtx3xmmmJyA64vrszWAqSXEvYaQNAo1yL4tCxBYPZv',
  '6KR4qkJN91LGko2gdizheri8LMtCwsJrhtsQt6QPwCi5',
  'DAz7SnxRL2HRZ2GPigdVRGkoF39bD4Qdv8td5wD3i35u',
];
