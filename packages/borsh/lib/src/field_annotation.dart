import 'package:borsh/src/type.dart';

class Array {
  const Array.dynamic(this.itemType)
      : length = null,
        type = Borsh.dynamicArray;

  const Array.fixed(
    this.itemType, {
    required this.length,
  }) : type = Borsh.array;

  final Borsh type;
  final Borsh itemType;
  final int? length;
}

const u8 = _Field(type: Borsh.u8);
const i8 = _Field(type: Borsh.i8);

const u16 = _Field(type: Borsh.u16);
const i16 = _Field(type: Borsh.i16);

const u32 = _Field(type: Borsh.u32);
const i32 = _Field(type: Borsh.i32);

const u64 = _Field(type: Borsh.u64);
const i64 = _Field(type: Borsh.i64);

const string = _Field(type: Borsh.string);

class _Field {
  const _Field({
    required this.type,
  });

  final Borsh type;
}
