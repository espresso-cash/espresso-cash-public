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
  bool get isRequestingAirdrop => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClientStateCopyWith<ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(
          ClientState value, $Res Function(ClientState) then) =
      _$ClientStateCopyWithImpl<$Res, ClientState>;
  @useResult
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult,
      bool isRequestingAirdrop});

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res, $Val extends ClientState>
    implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
  }) {
    return _then(_value.copyWith(
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: freezed == authorizationResult
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
      isRequestingAirdrop: null == isRequestingAirdrop
          ? _value.isRequestingAirdrop
          : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_value.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_value.capabilities!, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_value.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_value.authorizationResult!,
        (value) {
      return _then(_value.copyWith(authorizationResult: value) as $Val);
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
  @useResult
  $Res call(
      {GetCapabilitiesResult? capabilities,
      AuthorizationResult? authorizationResult,
      bool isRequestingAirdrop});

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class __$$_ClientStateCopyWithImpl<$Res>
    extends _$ClientStateCopyWithImpl<$Res, _$_ClientState>
    implements _$$_ClientStateCopyWith<$Res> {
  __$$_ClientStateCopyWithImpl(
      _$_ClientState _value, $Res Function(_$_ClientState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
  }) {
    return _then(_$_ClientState(
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as GetCapabilitiesResult?,
      authorizationResult: freezed == authorizationResult
          ? _value.authorizationResult
          : authorizationResult // ignore: cast_nullable_to_non_nullable
              as AuthorizationResult?,
      isRequestingAirdrop: null == isRequestingAirdrop
          ? _value.isRequestingAirdrop
          : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ClientState extends _ClientState with DiagnosticableTreeMixin {
  const _$_ClientState(
      {this.capabilities,
      this.authorizationResult,
      this.isRequestingAirdrop = false})
      : super._();

  @override
  final GetCapabilitiesResult? capabilities;
  @override
  final AuthorizationResult? authorizationResult;
  @override
  @JsonKey()
  final bool isRequestingAirdrop;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientState(capabilities: $capabilities, authorizationResult: $authorizationResult, isRequestingAirdrop: $isRequestingAirdrop)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientState'))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('authorizationResult', authorizationResult))
      ..add(DiagnosticsProperty('isRequestingAirdrop', isRequestingAirdrop));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientState &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.authorizationResult, authorizationResult) ||
                other.authorizationResult == authorizationResult) &&
            (identical(other.isRequestingAirdrop, isRequestingAirdrop) ||
                other.isRequestingAirdrop == isRequestingAirdrop));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, capabilities, authorizationResult, isRequestingAirdrop);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      __$$_ClientStateCopyWithImpl<_$_ClientState>(this, _$identity);
}

abstract class _ClientState extends ClientState {
  const factory _ClientState(
      {final GetCapabilitiesResult? capabilities,
      final AuthorizationResult? authorizationResult,
      final bool isRequestingAirdrop}) = _$_ClientState;
  const _ClientState._() : super._();

  @override
  GetCapabilitiesResult? get capabilities;
  @override
  AuthorizationResult? get authorizationResult;
  @override
  bool get isRequestingAirdrop;
  @override
  @JsonKey(ignore: true)
  _$$_ClientStateCopyWith<_$_ClientState> get copyWith =>
      throw _privateConstructorUsedError;
}
