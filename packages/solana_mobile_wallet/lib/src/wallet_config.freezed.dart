// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MobileWalletAdapterConfig _$MobileWalletAdapterConfigFromJson(
    Map<String, dynamic> json) {
  return _MobileWalletAdapterConfig.fromJson(json);
}

/// @nodoc
mixin _$MobileWalletAdapterConfig {
  bool get supportsSignAndSendTransactions =>
      throw _privateConstructorUsedError;
  int get maxTransactionsPerSigningRequest =>
      throw _privateConstructorUsedError;
  int get maxMessagesPerSigningRequest => throw _privateConstructorUsedError;
  List<Object> get supportedTransactionVersions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MobileWalletAdapterConfigCopyWith<MobileWalletAdapterConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobileWalletAdapterConfigCopyWith<$Res> {
  factory $MobileWalletAdapterConfigCopyWith(MobileWalletAdapterConfig value,
          $Res Function(MobileWalletAdapterConfig) then) =
      _$MobileWalletAdapterConfigCopyWithImpl<$Res>;
  $Res call(
      {bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest,
      List<Object> supportedTransactionVersions});
}

/// @nodoc
class _$MobileWalletAdapterConfigCopyWithImpl<$Res>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  _$MobileWalletAdapterConfigCopyWithImpl(this._value, this._then);

  final MobileWalletAdapterConfig _value;
  // ignore: unused_field
  final $Res Function(MobileWalletAdapterConfig) _then;

  @override
  $Res call({
    Object? supportsSignAndSendTransactions = freezed,
    Object? maxTransactionsPerSigningRequest = freezed,
    Object? maxMessagesPerSigningRequest = freezed,
    Object? supportedTransactionVersions = freezed,
  }) {
    return _then(_value.copyWith(
      supportsSignAndSendTransactions: supportsSignAndSendTransactions ==
              freezed
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: maxTransactionsPerSigningRequest ==
              freezed
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: maxMessagesPerSigningRequest == freezed
          ? _value.maxMessagesPerSigningRequest
          : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      supportedTransactionVersions: supportedTransactionVersions == freezed
          ? _value.supportedTransactionVersions
          : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
              as List<Object>,
    ));
  }
}

/// @nodoc
abstract class _$$_MobileWalletAdapterConfigCopyWith<$Res>
    implements $MobileWalletAdapterConfigCopyWith<$Res> {
  factory _$$_MobileWalletAdapterConfigCopyWith(
          _$_MobileWalletAdapterConfig value,
          $Res Function(_$_MobileWalletAdapterConfig) then) =
      __$$_MobileWalletAdapterConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest,
      List<Object> supportedTransactionVersions});
}

/// @nodoc
class __$$_MobileWalletAdapterConfigCopyWithImpl<$Res>
    extends _$MobileWalletAdapterConfigCopyWithImpl<$Res>
    implements _$$_MobileWalletAdapterConfigCopyWith<$Res> {
  __$$_MobileWalletAdapterConfigCopyWithImpl(
      _$_MobileWalletAdapterConfig _value,
      $Res Function(_$_MobileWalletAdapterConfig) _then)
      : super(_value, (v) => _then(v as _$_MobileWalletAdapterConfig));

  @override
  _$_MobileWalletAdapterConfig get _value =>
      super._value as _$_MobileWalletAdapterConfig;

  @override
  $Res call({
    Object? supportsSignAndSendTransactions = freezed,
    Object? maxTransactionsPerSigningRequest = freezed,
    Object? maxMessagesPerSigningRequest = freezed,
    Object? supportedTransactionVersions = freezed,
  }) {
    return _then(_$_MobileWalletAdapterConfig(
      supportsSignAndSendTransactions: supportsSignAndSendTransactions ==
              freezed
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: maxTransactionsPerSigningRequest ==
              freezed
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: maxMessagesPerSigningRequest == freezed
          ? _value.maxMessagesPerSigningRequest
          : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      supportedTransactionVersions: supportedTransactionVersions == freezed
          ? _value._supportedTransactionVersions
          : supportedTransactionVersions // ignore: cast_nullable_to_non_nullable
              as List<Object>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MobileWalletAdapterConfig implements _MobileWalletAdapterConfig {
  const _$_MobileWalletAdapterConfig(
      {required this.supportsSignAndSendTransactions,
      required this.maxTransactionsPerSigningRequest,
      required this.maxMessagesPerSigningRequest,
      required final List<Object> supportedTransactionVersions})
      : _supportedTransactionVersions = supportedTransactionVersions;

  factory _$_MobileWalletAdapterConfig.fromJson(Map<String, dynamic> json) =>
      _$$_MobileWalletAdapterConfigFromJson(json);

  @override
  final bool supportsSignAndSendTransactions;
  @override
  final int maxTransactionsPerSigningRequest;
  @override
  final int maxMessagesPerSigningRequest;
  final List<Object> _supportedTransactionVersions;
  @override
  List<Object> get supportedTransactionVersions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedTransactionVersions);
  }

  @override
  String toString() {
    return 'MobileWalletAdapterConfig(supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest, supportedTransactionVersions: $supportedTransactionVersions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MobileWalletAdapterConfig &&
            const DeepCollectionEquality().equals(
                other.supportsSignAndSendTransactions,
                supportsSignAndSendTransactions) &&
            const DeepCollectionEquality().equals(
                other.maxTransactionsPerSigningRequest,
                maxTransactionsPerSigningRequest) &&
            const DeepCollectionEquality().equals(
                other.maxMessagesPerSigningRequest,
                maxMessagesPerSigningRequest) &&
            const DeepCollectionEquality().equals(
                other._supportedTransactionVersions,
                _supportedTransactionVersions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supportsSignAndSendTransactions),
      const DeepCollectionEquality().hash(maxTransactionsPerSigningRequest),
      const DeepCollectionEquality().hash(maxMessagesPerSigningRequest),
      const DeepCollectionEquality().hash(_supportedTransactionVersions));

  @JsonKey(ignore: true)
  @override
  _$$_MobileWalletAdapterConfigCopyWith<_$_MobileWalletAdapterConfig>
      get copyWith => __$$_MobileWalletAdapterConfigCopyWithImpl<
          _$_MobileWalletAdapterConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MobileWalletAdapterConfigToJson(
      this,
    );
  }
}

abstract class _MobileWalletAdapterConfig implements MobileWalletAdapterConfig {
  const factory _MobileWalletAdapterConfig(
          {required final bool supportsSignAndSendTransactions,
          required final int maxTransactionsPerSigningRequest,
          required final int maxMessagesPerSigningRequest,
          required final List<Object> supportedTransactionVersions}) =
      _$_MobileWalletAdapterConfig;

  factory _MobileWalletAdapterConfig.fromJson(Map<String, dynamic> json) =
      _$_MobileWalletAdapterConfig.fromJson;

  @override
  bool get supportsSignAndSendTransactions;
  @override
  int get maxTransactionsPerSigningRequest;
  @override
  int get maxMessagesPerSigningRequest;
  @override
  List<Object> get supportedTransactionVersions;
  @override
  @JsonKey(ignore: true)
  _$$_MobileWalletAdapterConfigCopyWith<_$_MobileWalletAdapterConfig>
      get copyWith => throw _privateConstructorUsedError;
}
