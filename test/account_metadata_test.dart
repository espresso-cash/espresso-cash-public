import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/extensions.dart';
import 'package:test/test.dart';

void main() {
  test('Account metas are correctly sorted', () {
    _unsorted1.sort();
    for (int i = 0; i < _unsorted1.length; ++i) {
      expect(_unsorted1[i].pubKey, equals(_sorted1[i].pubKey));
    }
    expect(_unsorted1.getNumSigners(), equals(2));
    expect(_unsorted1.getNumReadonlySigners(), equals(1));
  });
}

final _unsorted1 = [
  AccountMeta.readonly(pubKey: '1', isSigner: false),
  AccountMeta.writeable(pubKey: '2', isSigner: false),
  AccountMeta.writeable(pubKey: '3', isSigner: true),
  AccountMeta.writeable(pubKey: '4', isSigner: false),
  AccountMeta.readonly(pubKey: '5', isSigner: true),
];

final _sorted1 = [
  AccountMeta.writeable(pubKey: '3', isSigner: true),
  AccountMeta.readonly(pubKey: '5', isSigner: true),
  AccountMeta.writeable(pubKey: '2', isSigner: false),
  AccountMeta.writeable(pubKey: '4', isSigner: false),
  AccountMeta.readonly(pubKey: '1', isSigner: false),
];
