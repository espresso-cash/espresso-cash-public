// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClientState {
  GetCapabilitiesResult? get capabilities => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClientStateCopyWith<ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
          ClientState value, $Res Function(ClientState) then) =
      _$ClientStateCopyWithImpl<$Res>;
  $Res call({GetCapabilitiesResult? capabilities});

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res> implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._value, this._then);

  final ClientState _value;
  // ignore: unused_field
  final $Res Function(ClientState) _then;

  @override
  $Res call({
    Object? capabilities = freezed,
  }) {
    return _then(_value.copyWith(
      capabilities: capabilities == freezed
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
    ));
  }

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_value.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_value.capabilities!, (value) {
      return _then(_value.copyWith(capabilities: value));
    });
  }
}

/// @nodoc
abstract class _$$_ClientStateCopyWith<$Res>
    implements $ClientStateCopyWith<$Res> {
  factory _$$_ClientStateCopyWith(
          _$_ClientState value, $Res Function(_$_ClientState) then) =
      __$$_ClientStateCopyWithImpl<$Res>;
  @override
  $Res call({GetCapabilitiesResult? capabilities});

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
}

/// @nodoc
class __$$_ClientStateCopyWithImpl<$Res> extends _$ClientStateCopyWithImpl<$Res>
    implements _$$_ClientStateCopyWith<$Res> {
  __$$_ClientStateCopyWithImpl(
      _$_ClientState _value, $Res Function(_$_ClientState) _then)
      : super(_value, (v) => _then(v as _$_ClientState));

  @override
  _$_ClientState get _value => super._value as _$_ClientState;

  @override
  $Res call({
    Object? capabilities = freezed,
  }) {
    return _then(_$_ClientState(
      capabilities: capabilities == freezed
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
    ));
  }
}

/// @nodoc

class _$_ClientState implements _ClientState {
  const _$_ClientState({this.capabilities});

  @override
  final GetCapabilitiesResult? capabilities;

  @override
  String toString() {
    return 'ClientState(capabilities: $capabilities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientState &&
            const DeepCollectionEquality()
                .equals(other.capabilities, capabilities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(capabilities));

  @JsonKey(ignore: true)
  @override
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      __$$_ClientStateCopyWithImpl<_$_ClientState>(this, _$identity);
}

abstract class _ClientState implements ClientState {
  const factory _ClientState({final GetCapabilitiesResult? capabilities}) =
      _$_ClientState;

  @override
  GetCapabilitiesResult? get capabilities;
  @override
  @JsonKey(ignore: true)
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}
