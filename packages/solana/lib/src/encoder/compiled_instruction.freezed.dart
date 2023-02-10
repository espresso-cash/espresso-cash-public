// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compiled_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompiledInstruction {
  int get programIdIndex => throw _privateConstructorUsedError;
  List<int> get accountKeyIndexes => throw _privateConstructorUsedError;
  ByteArray get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompiledInstructionCopyWith<CompiledInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledInstructionCopyWith<$Res> {
  factory $CompiledInstructionCopyWith(
          CompiledInstruction value, $Res Function(CompiledInstruction) then) =
      _$CompiledInstructionCopyWithImpl<$Res, CompiledInstruction>;
  @useResult
  $Res call({int programIdIndex, List<int> accountKeyIndexes, ByteArray data});
}

/// @nodoc
class _$CompiledInstructionCopyWithImpl<$Res, $Val extends CompiledInstruction>
    implements $CompiledInstructionCopyWith<$Res> {
  _$CompiledInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programIdIndex = null,
    Object? accountKeyIndexes = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      programIdIndex: null == programIdIndex
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accountKeyIndexes: null == accountKeyIndexes
          ? _value.accountKeyIndexes
          : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompiledInstructionCopyWith<$Res>
    implements $CompiledInstructionCopyWith<$Res> {
  factory _$$_CompiledInstructionCopyWith(_$_CompiledInstruction value,
          $Res Function(_$_CompiledInstruction) then) =
      __$$_CompiledInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int programIdIndex, List<int> accountKeyIndexes, ByteArray data});
}

/// @nodoc
class __$$_CompiledInstructionCopyWithImpl<$Res>
    extends _$CompiledInstructionCopyWithImpl<$Res, _$_CompiledInstruction>
    implements _$$_CompiledInstructionCopyWith<$Res> {
  __$$_CompiledInstructionCopyWithImpl(_$_CompiledInstruction _value,
      $Res Function(_$_CompiledInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programIdIndex = null,
    Object? accountKeyIndexes = null,
    Object? data = null,
  }) {
    return _then(_$_CompiledInstruction(
      programIdIndex: null == programIdIndex
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accountKeyIndexes: null == accountKeyIndexes
          ? _value._accountKeyIndexes
          : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ));
  }
}

/// @nodoc

class _$_CompiledInstruction extends _CompiledInstruction {
  const _$_CompiledInstruction(
      {required this.programIdIndex,
      required final List<int> accountKeyIndexes,
      required this.data})
      : _accountKeyIndexes = accountKeyIndexes,
        super._();

  @override
  final int programIdIndex;
  final List<int> _accountKeyIndexes;
  @override
  List<int> get accountKeyIndexes {
    if (_accountKeyIndexes is EqualUnmodifiableListView)
      return _accountKeyIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accountKeyIndexes);
  }

  @override
  final ByteArray data;

  @override
  String toString() {
    return 'CompiledInstruction(programIdIndex: $programIdIndex, accountKeyIndexes: $accountKeyIndexes, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompiledInstruction &&
            (identical(other.programIdIndex, programIdIndex) ||
                other.programIdIndex == programIdIndex) &&
            const DeepCollectionEquality()
                .equals(other._accountKeyIndexes, _accountKeyIndexes) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      programIdIndex,
      const DeepCollectionEquality().hash(_accountKeyIndexes),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompiledInstructionCopyWith<_$_CompiledInstruction> get copyWith =>
      __$$_CompiledInstructionCopyWithImpl<_$_CompiledInstruction>(
          this, _$identity);
}

abstract class _CompiledInstruction extends CompiledInstruction {
  const factory _CompiledInstruction(
      {required final int programIdIndex,
      required final List<int> accountKeyIndexes,
      required final ByteArray data}) = _$_CompiledInstruction;
  const _CompiledInstruction._() : super._();

  @override
  int get programIdIndex;
  @override
  List<int> get accountKeyIndexes;
  @override
  ByteArray get data;
  @override
  @JsonKey(ignore: true)
  _$$_CompiledInstructionCopyWith<_$_CompiledInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
