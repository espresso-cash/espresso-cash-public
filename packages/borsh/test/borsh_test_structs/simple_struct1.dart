import 'dart:typed_data';

import 'package:borsh/borsh.dart';

part 'simple_struct1.g.dart';

@Struct()
class SimpleStruct1 extends BorshStruct {
  const SimpleStruct1({
    required this.strValue,
    required this.int32Value,
    required this.fixedIntegersArray,
    required this.dynamicStringArray,
  });

  factory SimpleStruct1.fromBorsh(List<int> bytes) =>
      _SimpleStruct1FromBorsh(bytes);

  @override
  List<int> toBorsh() => _SimpleStruct1ToBorsh(this);

  @string
  final String strValue;

  @i32
  final int int32Value;

  @Array.fixed(Borsh.u8, length: 3)
  final List<int> fixedIntegersArray;

  @Array.dynamic(Borsh.string)
  final List<String> dynamicStringArray;
}
