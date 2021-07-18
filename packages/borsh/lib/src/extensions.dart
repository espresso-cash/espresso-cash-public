import 'package:analyzer/dart/constant/value.dart';
import 'package:borsh/src/type.dart';

extension DartObjectExt on DartObject {
  T? getFieldAs<T>(String name) {
    final field = getField(name);
    if (field == null) {
      return null;
    }
    switch (T) {
      case int:
        final value = field.toIntValue();
        if (value == null) {
          return null;
        }
        return value as T;
      case Borsh:
        final index = field.getFieldAs<int>('index');
        if (index != null) {
          return Borsh.values[index] as T;
        } else {
          return null;
        }
    }
  }
}

extension TypeInfo on Borsh {
  bool get isPrimitive {
    switch (this) {
      case Borsh.u8:
      case Borsh.i8:
      case Borsh.u16:
      case Borsh.i16:
      case Borsh.u32:
      case Borsh.i32:
      case Borsh.u64:
      case Borsh.i64:
        return true;
      case Borsh.string:
      case Borsh.array:
      case Borsh.struct:
      case Borsh.dynamicArray:
      case Borsh.invalid:
        return false;
    }
  }

  int get size {
    switch (this) {
      case Borsh.u8:
      case Borsh.i8:
        return 1;
      case Borsh.u16:
      case Borsh.i16:
        return 2;
      case Borsh.u32:
      case Borsh.i32:
        return 4;
      case Borsh.u64:
      case Borsh.i64:
        return 8;
      case Borsh.string:
      case Borsh.array:
      case Borsh.struct:
      case Borsh.dynamicArray:
      case Borsh.invalid:
        throw ArgumentError('cannot get the size of a compound type');
    }
  }

  Type get native {
    switch (this) {
      case Borsh.u8:
      case Borsh.u16:
      case Borsh.u32:
      case Borsh.u64:
      case Borsh.i8:
      case Borsh.i16:
      case Borsh.i32:
      case Borsh.i64:
        return int;
      case Borsh.string:
        return String;
      case Borsh.array:
      case Borsh.struct:
      case Borsh.dynamicArray:
      case Borsh.invalid:
        throw ArgumentError('cannot get native type for $this');
    }
  }
}
