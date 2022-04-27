import 'dart:math';
import 'dart:typed_data';

import 'package:solana/src/common/byte_array.dart';
import 'package:test/test.dart';

void main() {
  // print(pow(2, 2).toInt() - 1 & 0xFF);
  // print(pow(2, 3).toInt() - 1 & 0xFF);
  // print(pow(2, 4).toInt() - 1 & 0xFF);
  // print(pow(2, 8).toInt() - 1 & 0xFF);
  // print(pow(2, 16).toInt() - 1 & 0xFF);
  test('description', () {
    final value = encodeBigInt(-BigInt.one, 4);
    print(
      '${encodeBigInt(-BigInt.one, 4)} – ${(ByteData(4)..setInt32(0, -1, Endian.little)).buffer.asUint8List()}',
    );
    print(
      '${encodeBigInt(-BigInt.two, 4)} – ${(ByteData(4)..setInt32(0, -2, Endian.little)).buffer.asUint8List()}',
    );

    print(
      '${encodeBigInt(BigInt.one, 4)} – ${(ByteData(4)..setInt32(0, 1, Endian.little)).buffer.asUint8List()}',
    );
    print(
      '${encodeBigInt(BigInt.two, 4)} – ${(ByteData(4)..setInt32(0, 2, Endian.little)).buffer.asUint8List()}',
    );

    print(decodeBigInt(encodeBigInt(-BigInt.one, 4), isSigned: true));
    print(decodeBigInt(encodeBigInt(-BigInt.two, 4), isSigned: true));
    print(decodeBigInt(encodeBigInt(BigInt.one, 4), isSigned: true));
    print(decodeBigInt(encodeBigInt(BigInt.two, 4), isSigned: true));
    print(decodeBigInt(encodeBigInt(BigInt.one, 4), isSigned: false));
    print(decodeBigInt(encodeBigInt(BigInt.two, 4), isSigned: false));

    print(encodeBigInt(BigInt.two.pow(64) - BigInt.one, 8));
    print(encodeBigInt(BigInt.two.pow(64) ~/ BigInt.two, 8));
    print(encodeBigInt(-BigInt.two.pow(64) ~/ BigInt.two, 8));

    print(encodeBigInt(BigInt.from(129), 1));
    print(encodeBigInt(BigInt.from(-127), 1));

    print(encodeBigInt(BigInt.from(129), 2));
    print(encodeBigInt(BigInt.from(-127), 2));
  });
}
