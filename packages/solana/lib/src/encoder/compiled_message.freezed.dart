// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'compiled_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CompiledMessageTearOff {
  const _$CompiledMessageTearOff();

  _CompiledMessage call(ByteArray data) {
    return _CompiledMessage(
      data,
    );
  }
}

/// @nodoc
const $CompiledMessage = _$CompiledMessageTearOff();

/// @nodoc
mixin _$CompiledMessage {
  ByteArray get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompiledMessageCopyWith<CompiledMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledMessageCopyWith<$Res> {
  factory $CompiledMessageCopyWith(
          CompiledMessage value, $Res Function(CompiledMessage) then) =
      _$CompiledMessageCopyWithImpl<$Res>;
  $Res call({ByteArray data});
}

/// @nodoc
class _$CompiledMessageCopyWithImpl<$Res>
    implements $CompiledMessageCopyWith<$Res> {
  _$CompiledMessageCopyWithImpl(this._value, this._then);

  final CompiledMessage _value;
  // ignore: unused_field
  final $Res Function(CompiledMessage) _then;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ));
  }
}

/// @nodoc
abstract class _$CompiledMessageCopyWith<$Res>
    implements $CompiledMessageCopyWith<$Res> {
  factory _$CompiledMessageCopyWith(
          _CompiledMessage value, $Res Function(_CompiledMessage) then) =
      __$CompiledMessageCopyWithImpl<$Res>;
  @override
  $Res call({ByteArray data});
}

/// @nodoc
class __$CompiledMessageCopyWithImpl<$Res>
    extends _$CompiledMessageCopyWithImpl<$Res>
    implements _$CompiledMessageCopyWith<$Res> {
  __$CompiledMessageCopyWithImpl(
      _CompiledMessage _value, $Res Function(_CompiledMessage) _then)
      : super(_value, (v) => _then(v as _CompiledMessage));

  @override
  _CompiledMessage get _value => super._value as _CompiledMessage;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_CompiledMessage(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ));
  }
}

/// @nodoc

class _$_CompiledMessage extends _CompiledMessage {
  const _$_CompiledMessage(this.data) : super._();

  @override
  final ByteArray data;

  @override
  String toString() {
    return 'CompiledMessage(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledMessage &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$CompiledMessageCopyWith<_CompiledMessage> get copyWith =>
      __$CompiledMessageCopyWithImpl<_CompiledMessage>(this, _$identity);
}

abstract class _CompiledMessage extends CompiledMessage {
  const factory _CompiledMessage(ByteArray data) = _$_CompiledMessage;
  const _CompiledMessage._() : super._();

  @override
  ByteArray get data;
  @override
  @JsonKey(ignore: true)
  _$CompiledMessageCopyWith<_CompiledMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
