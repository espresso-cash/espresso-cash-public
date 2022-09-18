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
  AuthorizationResult? get authorizationResult =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClientStateCopyWith<ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
          ClientState value, $Res Function(ClientState) then) =
      _$ClientStateCopyWithImpl<$Res>;
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult});

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
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
    Object? authorizationResult = freezed,
  }) {
    return _then(_value.copyWith(
      capabilities: capabilities == freezed
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: authorizationResult == freezed
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
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

  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_value.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_value.authorizationResult!,
        (value) {
      return _then(_value.copyWith(authorizationResult: value));
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
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult});

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
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
    Object? authorizationResult = freezed,
  }) {
    return _then(_$_ClientState(
      capabilities: capabilities == freezed
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: authorizationResult == freezed
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
    ));
  }
}

/// @nodoc

class _$_ClientState extends _ClientState {
  const _$_ClientState({this.capabilities, this.authorizationResult})
      : super._();

  @override
  final GetCapabilitiesResult? capabilities;
  @override
  final AuthorizationResult? authorizationResult;

  @override
  String toString() {
    return 'ClientState(capabilities: $capabilities, authorizationResult: $authorizationResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientState &&
            const DeepCollectionEquality()
                .equals(other.capabilities, capabilities) &&
            const DeepCollectionEquality()
                .equals(other.authorizationResult, authorizationResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(capabilities),
      const DeepCollectionEquality().hash(authorizationResult));

  @JsonKey(ignore: true)
  @override
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      __$$_ClientStateCopyWithImpl<_$_ClientState>(this, _$identity);
}

abstract class _ClientState extends ClientState {
  const factory _ClientState(
      {final GetCapabilitiesResult? capabilities,
      final AuthorizationResult? authorizationResult}) = _$_ClientState;
  const _ClientState._() : super._();

  @override
  GetCapabilitiesResult? get capabilities;
  @override
  AuthorizationResult? get authorizationResult;
  @override
  @JsonKey(ignore: true)
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}
