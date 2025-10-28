// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MobileWalletAdapterConfig {
  bool get supportsSignAndSendTransactions => throw _privateConstructorUsedError;
  int get maxTransactionsPerSigningRequest => throw _privateConstructorUsedError;
  int get maxMessagesPerSigningRequest => throw _privateConstructorUsedError;
  List<Object> get supportedTransactionVersions => throw _privateConstructorUsedError;
  Duration get noConnectionWarningTimeout => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MobileWalletAdapterConfigCopyWith<MobileWalletAdapterConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileWalletAdapterConfigCopyWith<$Res> {
  factory $MobileWalletAdapterConfigCopyWith(
    MobileWalletAdapterConfig value,
    $Res Function(MobileWalletAdapterConfig) then,
  ) = _$MobileWalletAdapterConfigCopyWithImpl<$Res, MobileWalletAdapterConfig>;
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
class _$MobileWalletAdapterConfigCopyWithImpl<$Res, $Val extends MobileWalletAdapterConfig>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  _$MobileWalletAdapterConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      _value.copyWith(
            supportsSignAndSendTransactions:
                null == supportsSignAndSendTransactions
                    ? _value.supportsSignAndSendTransactions
                    : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                        as bool,
            maxTransactionsPerSigningRequest:
                null == maxTransactionsPerSigningRequest
                    ? _value.maxTransactionsPerSigningRequest
                    : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                        as int,
            maxMessagesPerSigningRequest:
                null == maxMessagesPerSigningRequest
                    ? _value.maxMessagesPerSigningRequest
                    : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                        as int,
            supportedTransactionVersions:
                null == supportedTransactionVersions
                    ? _value.supportedTransactionVersions
                    : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
                        as List<Object>,
            noConnectionWarningTimeout:
                null == noConnectionWarningTimeout
                    ? _value.noConnectionWarningTimeout
                    : noConnectionWarningTimeout // ignore: cast_nullable_to_non_nullable
                        as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MobileWalletAdapterConfigImplCopyWith<$Res>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  factory _$$MobileWalletAdapterConfigImplCopyWith(
    _$MobileWalletAdapterConfigImpl value,
    $Res Function(_$MobileWalletAdapterConfigImpl) then,
  ) = __$$MobileWalletAdapterConfigImplCopyWithImpl<$Res>;
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
class __$$MobileWalletAdapterConfigImplCopyWithImpl<$Res>
    extends _$MobileWalletAdapterConfigCopyWithImpl<$Res, _$MobileWalletAdapterConfigImpl>
    implements _$$MobileWalletAdapterConfigImplCopyWith<$Res> {
  __$$MobileWalletAdapterConfigImplCopyWithImpl(
    _$MobileWalletAdapterConfigImpl _value,
    $Res Function(_$MobileWalletAdapterConfigImpl) _then,
  ) : super(_value, _then);

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
      _$MobileWalletAdapterConfigImpl(
        supportsSignAndSendTransactions:
            null == supportsSignAndSendTransactions
                ? _value.supportsSignAndSendTransactions
                : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                    as bool,
        maxTransactionsPerSigningRequest:
            null == maxTransactionsPerSigningRequest
                ? _value.maxTransactionsPerSigningRequest
                : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        maxMessagesPerSigningRequest:
            null == maxMessagesPerSigningRequest
                ? _value.maxMessagesPerSigningRequest
                : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        supportedTransactionVersions:
            null == supportedTransactionVersions
                ? _value._supportedTransactionVersions
                : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
                    as List<Object>,
        noConnectionWarningTimeout:
            null == noConnectionWarningTimeout
                ? _value.noConnectionWarningTimeout
                : noConnectionWarningTimeout // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc

class _$MobileWalletAdapterConfigImpl implements _MobileWalletAdapterConfig {
  const _$MobileWalletAdapterConfigImpl({
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

  @override
  String toString() {
    return 'MobileWalletAdapterConfig(supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest, supportedTransactionVersions: $supportedTransactionVersions, noConnectionWarningTimeout: $noConnectionWarningTimeout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobileWalletAdapterConfigImpl &&
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MobileWalletAdapterConfigImplCopyWith<_$MobileWalletAdapterConfigImpl> get copyWith =>
      __$$MobileWalletAdapterConfigImplCopyWithImpl<_$MobileWalletAdapterConfigImpl>(
        this,
        _$identity,
      );
}

abstract class _MobileWalletAdapterConfig implements MobileWalletAdapterConfig {
  const factory _MobileWalletAdapterConfig({
    required final bool supportsSignAndSendTransactions,
    required final int maxTransactionsPerSigningRequest,
    required final int maxMessagesPerSigningRequest,
    required final List<Object> supportedTransactionVersions,
    final Duration noConnectionWarningTimeout,
  }) = _$MobileWalletAdapterConfigImpl;

  @override
  bool get supportsSignAndSendTransactions;
  @override
  int get maxTransactionsPerSigningRequest;
  @override
  int get maxMessagesPerSigningRequest;
  @override
  List<Object> get supportedTransactionVersions;
  @override
  Duration get noConnectionWarningTimeout;
  @override
  @JsonKey(ignore: true)
  _$$MobileWalletAdapterConfigImplCopyWith<_$MobileWalletAdapterConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
