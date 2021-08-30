import 'package:borsh_annotation/src/type.dart';

/// Annotate an `Iterable` class member as a borsh serializable array.
class Array {
  /// Convenience constructor for annotating an array that is [dynamic]. Meaning
  /// that it has a variable length.
  const Array.dynamic(this.itemType)
      : length = null,
        type = Borsh.dynamicArray;

  /// Convenience constructor for annotation an array of fixed length
  const Array.fixed(
    this.itemType, {
    required this.length,
  }) : type = Borsh.array;

  final Borsh type;
  final Borsh itemType;
  final int? length;
}

/// Annotate an int class member to be serialized as a borsh [u8] value.
const u8 = _Field(type: Borsh.u8);

/// Annotate an int class member to be serialized as a borsh [i8] value.
const i8 = _Field(type: Borsh.i8);

/// Annotate an int class member to be serialized as a borsh [u16] value.
const u16 = _Field(type: Borsh.u16);

/// Annotate an int class member to be serialized as a borsh [i16] value.
const i16 = _Field(type: Borsh.i16);

/// Annotate an int class member to be serialized as a borsh [u32] value.
const u32 = _Field(type: Borsh.u32);

/// Annotate an int class member to be serialized as a borsh [i32] value.
const i32 = _Field(type: Borsh.i32);

/// Annotate an int class member to be serialized as a borsh [u64] value.
const u64 = _Field(type: Borsh.u64);

/// Annotate an int class member to be serialized as a borsh [i64] value.
const i64 = _Field(type: Borsh.i64);

/// Annotate a string class member to be serialized as a borsh [string] value.
const string = _Field(type: Borsh.string);

class _Field {
  const _Field({
    required this.type,
  });

  final Borsh type;
}
