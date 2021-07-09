import 'package:convert/convert.dart';
import 'package:solana/src/borsh_serializer/borsh_serializer.dart';
import 'package:solana/src/borsh_serializer/simple.dart';
import 'package:test/test.dart';

void main() {
  test('Borsh', () {
    final list = [BorshInteger.i8(1), BorshInteger.i8(2), BorshInteger.i8(3)];
    final bytes = serializeMap(<String, dynamic>{
      'x': BorshInteger.u8(255),
      'y': BorshInteger.u64(20),
      'z': '123',
      'q': list,
    });
    expect(hex.encode(bytes), equals(''));
  });
}
