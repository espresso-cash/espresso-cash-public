// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientState implements DiagnosticableTreeMixin {
  GetCapabilitiesResult? get capabilities;
  AuthorizationResult? get authorizationResult;
  bool get isRequestingAirdrop;
  bool get isMainnet;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientStateCopyWith<ClientState> get copyWith =>
      _$ClientStateCopyWithImpl<ClientState>(this as ClientState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ClientState'))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('authorizationResult', authorizationResult))
      ..add(DiagnosticsProperty('isRequestingAirdrop', isRequestingAirdrop))
      ..add(DiagnosticsProperty('isMainnet', isMainnet));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientState &&
            (identical(other.capabilities, capabilities) || other.capabilities == capabilities) &&
            (identical(other.authorizationResult, authorizationResult) ||
                other.authorizationResult == authorizationResult) &&
            (identical(other.isRequestingAirdrop, isRequestingAirdrop) ||
                other.isRequestingAirdrop == isRequestingAirdrop) &&
            (identical(other.isMainnet, isMainnet) || other.isMainnet == isMainnet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, capabilities, authorizationResult, isRequestingAirdrop, isMainnet);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientState(capabilities: $capabilities, authorizationResult: $authorizationResult, isRequestingAirdrop: $isRequestingAirdrop, isMainnet: $isMainnet)';
  }
}

/// @nodoc
abstract mixin class $ClientStateCopyWith<$Res> {
  factory $ClientStateCopyWith(ClientState value, $Res Function(ClientState) _then) =
      _$ClientStateCopyWithImpl;
  @useResult
  $Res call({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    bool isRequestingAirdrop,
    bool isMainnet,
  });

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class _$ClientStateCopyWithImpl<$Res> implements $ClientStateCopyWith<$Res> {
  _$ClientStateCopyWithImpl(this._self, this._then);

  final ClientState _self;
  final $Res Function(ClientState) _then;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
    Object? isMainnet = null,
  }) {
    return _then(
      _self.copyWith(
        capabilities:
            freezed == capabilities
                ? _self.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                    as GetCapabilitiesResult?,
        authorizationResult:
            freezed == authorizationResult
                ? _self.authorizationResult
                : authorizationResult // ignore: cast_nullable_to_non_nullable
                    as AuthorizationResult?,
        isRequestingAirdrop:
            null == isRequestingAirdrop
                ? _self.isRequestingAirdrop
                : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
                    as bool,
        isMainnet:
            null == isMainnet
                ? _self.isMainnet
                : isMainnet // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_self.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_self.capabilities!, (value) {
      return _then(_self.copyWith(capabilities: value));
    });
  }

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_self.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_self.authorizationResult!, (value) {
      return _then(_self.copyWith(authorizationResult: value));
    });
  }
}

/// @nodoc

class _ClientState extends ClientState with DiagnosticableTreeMixin {
  const _ClientState({
    this.capabilities,
    this.authorizationResult,
    this.isRequestingAirdrop = false,
    this.isMainnet = false,
  }) : super._();

  @override
  final GetCapabilitiesResult? capabilities;
  @override
  final AuthorizationResult? authorizationResult;
  @override
  @JsonKey()
  final bool isRequestingAirdrop;
  @override
  @JsonKey()
  final bool isMainnet;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientStateCopyWith<_ClientState> get copyWith =>
      __$ClientStateCopyWithImpl<_ClientState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ClientState'))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('authorizationResult', authorizationResult))
      ..add(DiagnosticsProperty('isRequestingAirdrop', isRequestingAirdrop))
      ..add(DiagnosticsProperty('isMainnet', isMainnet));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientState &&
            (identical(other.capabilities, capabilities) || other.capabilities == capabilities) &&
            (identical(other.authorizationResult, authorizationResult) ||
                other.authorizationResult == authorizationResult) &&
            (identical(other.isRequestingAirdrop, isRequestingAirdrop) ||
                other.isRequestingAirdrop == isRequestingAirdrop) &&
            (identical(other.isMainnet, isMainnet) || other.isMainnet == isMainnet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, capabilities, authorizationResult, isRequestingAirdrop, isMainnet);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientState(capabilities: $capabilities, authorizationResult: $authorizationResult, isRequestingAirdrop: $isRequestingAirdrop, isMainnet: $isMainnet)';
  }
}

/// @nodoc
abstract mixin class _$ClientStateCopyWith<$Res> implements $ClientStateCopyWith<$Res> {
  factory _$ClientStateCopyWith(_ClientState value, $Res Function(_ClientState) _then) =
      __$ClientStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    bool isRequestingAirdrop,
    bool isMainnet,
  });

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class __$ClientStateCopyWithImpl<$Res> implements _$ClientStateCopyWith<$Res> {
  __$ClientStateCopyWithImpl(this._self, this._then);

  final _ClientState _self;
  final $Res Function(_ClientState) _then;

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isRequestingAirdrop = null,
    Object? isMainnet = null,
  }) {
    return _then(
      _ClientState(
        capabilities:
            freezed == capabilities
                ? _self.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                    as GetCapabilitiesResult?,
        authorizationResult:
            freezed == authorizationResult
                ? _self.authorizationResult
                : authorizationResult // ignore: cast_nullable_to_non_nullable
                    as AuthorizationResult?,
        isRequestingAirdrop:
            null == isRequestingAirdrop
                ? _self.isRequestingAirdrop
                : isRequestingAirdrop // ignore: cast_nullable_to_non_nullable
                    as bool,
        isMainnet:
            null == isMainnet
                ? _self.isMainnet
                : isMainnet // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_self.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_self.capabilities!, (value) {
      return _then(_self.copyWith(capabilities: value));
    });
  }

  /// Create a copy of ClientState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_self.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_self.authorizationResult!, (value) {
      return _then(_self.copyWith(authorizationResult: value));
    });
  }
}
