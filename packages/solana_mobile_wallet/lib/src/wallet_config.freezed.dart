// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MobileWalletAdapterConfig {
  bool get supportsSignAndSendTransactions;
  int get maxTransactionsPerSigningRequest;
  int get maxMessagesPerSigningRequest;
  List<Object> get supportedTransactionVersions;
  Duration get noConnectionWarningTimeout;

  /// Create a copy of MobileWalletAdapterConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MobileWalletAdapterConfigCopyWith<MobileWalletAdapterConfig> get copyWith =>
      _$MobileWalletAdapterConfigCopyWithImpl<MobileWalletAdapterConfig>(
        this as MobileWalletAdapterConfig,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MobileWalletAdapterConfig &&
            (identical(other.supportsSignAndSendTransactions, supportsSignAndSendTransactions) ||
                other.supportsSignAndSendTransactions == supportsSignAndSendTransactions) &&
            (identical(other.maxTransactionsPerSigningRequest, maxTransactionsPerSigningRequest) ||
                other.maxTransactionsPerSigningRequest == maxTransactionsPerSigningRequest) &&
            (identical(other.maxMessagesPerSigningRequest, maxMessagesPerSigningRequest) ||
                other.maxMessagesPerSigningRequest == maxMessagesPerSigningRequest) &&
            const DeepCollectionEquality().equals(
              other.supportedTransactionVersions,
              supportedTransactionVersions,
            ) &&
            (identical(other.noConnectionWarningTimeout, noConnectionWarningTimeout) ||
                other.noConnectionWarningTimeout == noConnectionWarningTimeout));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    supportsSignAndSendTransactions,
    maxTransactionsPerSigningRequest,
    maxMessagesPerSigningRequest,
    const DeepCollectionEquality().hash(supportedTransactionVersions),
    noConnectionWarningTimeout,
  );

  @override
  String toString() {
    return 'MobileWalletAdapterConfig(supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest, supportedTransactionVersions: $supportedTransactionVersions, noConnectionWarningTimeout: $noConnectionWarningTimeout)';
  }
}

/// @nodoc
abstract mixin class $MobileWalletAdapterConfigCopyWith<$Res> {
  factory $MobileWalletAdapterConfigCopyWith(
    MobileWalletAdapterConfig value,
    $Res Function(MobileWalletAdapterConfig) _then,
  ) = _$MobileWalletAdapterConfigCopyWithImpl;
  @useResult
  $Res call({
    bool supportsSignAndSendTransactions,
    int maxTransactionsPerSigningRequest,
    int maxMessagesPerSigningRequest,
    List<Object> supportedTransactionVersions,
    Duration noConnectionWarningTimeout,
  });
}

/// @nodoc
class _$MobileWalletAdapterConfigCopyWithImpl<$Res>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  _$MobileWalletAdapterConfigCopyWithImpl(this._self, this._then);

  final MobileWalletAdapterConfig _self;
  final $Res Function(MobileWalletAdapterConfig) _then;

  /// Create a copy of MobileWalletAdapterConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
    Object? supportedTransactionVersions = null,
    Object? noConnectionWarningTimeout = null,
  }) {
    return _then(
      _self.copyWith(
        supportsSignAndSendTransactions:
            null == supportsSignAndSendTransactions
                ? _self.supportsSignAndSendTransactions
                : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                    as bool,
        maxTransactionsPerSigningRequest:
            null == maxTransactionsPerSigningRequest
                ? _self.maxTransactionsPerSigningRequest
                : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        maxMessagesPerSigningRequest:
            null == maxMessagesPerSigningRequest
                ? _self.maxMessagesPerSigningRequest
                : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        supportedTransactionVersions:
            null == supportedTransactionVersions
                ? _self.supportedTransactionVersions
                : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
                    as List<Object>,
        noConnectionWarningTimeout:
            null == noConnectionWarningTimeout
                ? _self.noConnectionWarningTimeout
                : noConnectionWarningTimeout // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc

class _MobileWalletAdapterConfig implements MobileWalletAdapterConfig {
  const _MobileWalletAdapterConfig({
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
    required final List<Object> supportedTransactionVersions,
    this.noConnectionWarningTimeout = const Duration(seconds: 3),
  }) : _supportedTransactionVersions = supportedTransactionVersions;

  @override
  final bool supportsSignAndSendTransactions;
  @override
  final int maxTransactionsPerSigningRequest;
  @override
  final int maxMessagesPerSigningRequest;
  final List<Object> _supportedTransactionVersions;
  @override
  List<Object> get supportedTransactionVersions {
    if (_supportedTransactionVersions is EqualUnmodifiableListView)
      return _supportedTransactionVersions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedTransactionVersions);
  }

  @override
  @JsonKey()
  final Duration noConnectionWarningTimeout;

  /// Create a copy of MobileWalletAdapterConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MobileWalletAdapterConfigCopyWith<_MobileWalletAdapterConfig> get copyWith =>
      __$MobileWalletAdapterConfigCopyWithImpl<_MobileWalletAdapterConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MobileWalletAdapterConfig &&
            (identical(other.supportsSignAndSendTransactions, supportsSignAndSendTransactions) ||
                other.supportsSignAndSendTransactions == supportsSignAndSendTransactions) &&
            (identical(other.maxTransactionsPerSigningRequest, maxTransactionsPerSigningRequest) ||
                other.maxTransactionsPerSigningRequest == maxTransactionsPerSigningRequest) &&
            (identical(other.maxMessagesPerSigningRequest, maxMessagesPerSigningRequest) ||
                other.maxMessagesPerSigningRequest == maxMessagesPerSigningRequest) &&
            const DeepCollectionEquality().equals(
              other._supportedTransactionVersions,
              _supportedTransactionVersions,
            ) &&
            (identical(other.noConnectionWarningTimeout, noConnectionWarningTimeout) ||
                other.noConnectionWarningTimeout == noConnectionWarningTimeout));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    supportsSignAndSendTransactions,
    maxTransactionsPerSigningRequest,
    maxMessagesPerSigningRequest,
    const DeepCollectionEquality().hash(_supportedTransactionVersions),
    noConnectionWarningTimeout,
  );

  @override
  String toString() {
    return 'MobileWalletAdapterConfig(supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest, supportedTransactionVersions: $supportedTransactionVersions, noConnectionWarningTimeout: $noConnectionWarningTimeout)';
  }
}

/// @nodoc
abstract mixin class _$MobileWalletAdapterConfigCopyWith<$Res>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  factory _$MobileWalletAdapterConfigCopyWith(
    _MobileWalletAdapterConfig value,
    $Res Function(_MobileWalletAdapterConfig) _then,
  ) = __$MobileWalletAdapterConfigCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool supportsSignAndSendTransactions,
    int maxTransactionsPerSigningRequest,
    int maxMessagesPerSigningRequest,
    List<Object> supportedTransactionVersions,
    Duration noConnectionWarningTimeout,
  });
}

/// @nodoc
class __$MobileWalletAdapterConfigCopyWithImpl<$Res>
    implements _$MobileWalletAdapterConfigCopyWith<$Res> {
  __$MobileWalletAdapterConfigCopyWithImpl(this._self, this._then);

  final _MobileWalletAdapterConfig _self;
  final $Res Function(_MobileWalletAdapterConfig) _then;

  /// Create a copy of MobileWalletAdapterConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
    Object? supportedTransactionVersions = null,
    Object? noConnectionWarningTimeout = null,
  }) {
    return _then(
      _MobileWalletAdapterConfig(
        supportsSignAndSendTransactions:
            null == supportsSignAndSendTransactions
                ? _self.supportsSignAndSendTransactions
                : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                    as bool,
        maxTransactionsPerSigningRequest:
            null == maxTransactionsPerSigningRequest
                ? _self.maxTransactionsPerSigningRequest
                : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        maxMessagesPerSigningRequest:
            null == maxMessagesPerSigningRequest
                ? _self.maxMessagesPerSigningRequest
                : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        supportedTransactionVersions:
            null == supportedTransactionVersions
                ? _self._supportedTransactionVersions
                : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
                    as List<Object>,
        noConnectionWarningTimeout:
            null == noConnectionWarningTimeout
                ? _self.noConnectionWarningTimeout
                : noConnectionWarningTimeout // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}
