// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'compiled_key_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompiledKeyMeta {
  bool get isSigner => throw _privateConstructorUsedError;
  bool get isWritable => throw _privateConstructorUsedError;
  bool get isInvoked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompiledKeyMetaCopyWith<CompiledKeyMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledKeyMetaCopyWith<$Res> {
  factory $CompiledKeyMetaCopyWith(
          CompiledKeyMeta value, $Res Function(CompiledKeyMeta) then) =
      _$CompiledKeyMetaCopyWithImpl<$Res>;
  $Res call({bool isSigner, bool isWritable, bool isInvoked});
}

/// @nodoc
class _$CompiledKeyMetaCopyWithImpl<$Res>
    implements $CompiledKeyMetaCopyWith<$Res> {
  _$CompiledKeyMetaCopyWithImpl(this._value, this._then);

  final CompiledKeyMeta _value;
  // ignore: unused_field
  final $Res Function(CompiledKeyMeta) _then;

  @override
  $Res call({
    Object? isSigner = freezed,
    Object? isWritable = freezed,
    Object? isInvoked = freezed,
  }) {
    return _then(_value.copyWith(
      isSigner: isSigner == freezed
          ? _value.isSigner
          : isSigner // ignore: cast_nullable_to_non_nullable
              as bool,
      isWritable: isWritable == freezed
          ? _value.isWritable
          : isWritable // ignore: cast_nullable_to_non_nullable
              as bool,
      isInvoked: isInvoked == freezed
          ? _value.isInvoked
          : isInvoked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CompiledKeyMetaCopyWith<$Res>
    implements $CompiledKeyMetaCopyWith<$Res> {
  factory _$$_CompiledKeyMetaCopyWith(
          _$_CompiledKeyMeta value, $Res Function(_$_CompiledKeyMeta) then) =
      __$$_CompiledKeyMetaCopyWithImpl<$Res>;
  @override
  $Res call({bool isSigner, bool isWritable, bool isInvoked});
}

/// @nodoc
class __$$_CompiledKeyMetaCopyWithImpl<$Res>
    extends _$CompiledKeyMetaCopyWithImpl<$Res>
    implements _$$_CompiledKeyMetaCopyWith<$Res> {
  __$$_CompiledKeyMetaCopyWithImpl(
      _$_CompiledKeyMeta _value, $Res Function(_$_CompiledKeyMeta) _then)
      : super(_value, (v) => _then(v as _$_CompiledKeyMeta));

  @override
  _$_CompiledKeyMeta get _value => super._value as _$_CompiledKeyMeta;

  @override
  $Res call({
    Object? isSigner = freezed,
    Object? isWritable = freezed,
    Object? isInvoked = freezed,
  }) {
    return _then(_$_CompiledKeyMeta(
      isSigner: isSigner == freezed
          ? _value.isSigner
          : isSigner // ignore: cast_nullable_to_non_nullable
              as bool,
      isWritable: isWritable == freezed
          ? _value.isWritable
          : isWritable // ignore: cast_nullable_to_non_nullable
              as bool,
      isInvoked: isInvoked == freezed
          ? _value.isInvoked
          : isInvoked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CompiledKeyMeta implements _CompiledKeyMeta {
  const _$_CompiledKeyMeta(
      {required this.isSigner,
      required this.isWritable,
      required this.isInvoked});

  @override
  final bool isSigner;
  @override
  final bool isWritable;
  @override
  final bool isInvoked;

  @override
  String toString() {
    return 'CompiledKeyMeta(isSigner: $isSigner, isWritable: $isWritable, isInvoked: $isInvoked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompiledKeyMeta &&
            const DeepCollectionEquality().equals(other.isSigner, isSigner) &&
            const DeepCollectionEquality()
                .equals(other.isWritable, isWritable) &&
            const DeepCollectionEquality().equals(other.isInvoked, isInvoked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isSigner),
      const DeepCollectionEquality().hash(isWritable),
      const DeepCollectionEquality().hash(isInvoked));

  @JsonKey(ignore: true)
  @override
  _$$_CompiledKeyMetaCopyWith<_$_CompiledKeyMeta> get copyWith =>
      __$$_CompiledKeyMetaCopyWithImpl<_$_CompiledKeyMeta>(this, _$identity);
}

abstract class _CompiledKeyMeta implements CompiledKeyMeta {
  const factory _CompiledKeyMeta(
      {required final bool isSigner,
      required final bool isWritable,
      required final bool isInvoked}) = _$_CompiledKeyMeta;

  @override
  bool get isSigner;
  @override
  bool get isWritable;
  @override
  bool get isInvoked;
  @override
  @JsonKey(ignore: true)
  _$$_CompiledKeyMetaCopyWith<_$_CompiledKeyMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
