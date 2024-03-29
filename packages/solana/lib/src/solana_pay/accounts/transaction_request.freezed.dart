// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionRequestInfo _$TransactionRequestInfoFromJson(
    Map<String, dynamic> json) {
  return _TransactionRequestInfo.fromJson(json);
}

/// @nodoc
mixin _$TransactionRequestInfo {
  String get label => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionRequestInfoCopyWith<TransactionRequestInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionRequestInfoCopyWith<$Res> {
  factory $TransactionRequestInfoCopyWith(TransactionRequestInfo value,
          $Res Function(TransactionRequestInfo) then) =
      _$TransactionRequestInfoCopyWithImpl<$Res, TransactionRequestInfo>;
  @useResult
  $Res call({String label, String icon});
}

/// @nodoc
class _$TransactionRequestInfoCopyWithImpl<$Res,
        $Val extends TransactionRequestInfo>
    implements $TransactionRequestInfoCopyWith<$Res> {
  _$TransactionRequestInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionRequestInfoCopyWith<$Res>
    implements $TransactionRequestInfoCopyWith<$Res> {
  factory _$$_TransactionRequestInfoCopyWith(_$_TransactionRequestInfo value,
          $Res Function(_$_TransactionRequestInfo) then) =
      __$$_TransactionRequestInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String icon});
}

/// @nodoc
class __$$_TransactionRequestInfoCopyWithImpl<$Res>
    extends _$TransactionRequestInfoCopyWithImpl<$Res,
        _$_TransactionRequestInfo>
    implements _$$_TransactionRequestInfoCopyWith<$Res> {
  __$$_TransactionRequestInfoCopyWithImpl(_$_TransactionRequestInfo _value,
      $Res Function(_$_TransactionRequestInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? icon = null,
  }) {
    return _then(_$_TransactionRequestInfo(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionRequestInfo implements _TransactionRequestInfo {
  const _$_TransactionRequestInfo({required this.label, required this.icon});

  factory _$_TransactionRequestInfo.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionRequestInfoFromJson(json);

  @override
  final String label;
  @override
  final String icon;

  @override
  String toString() {
    return 'TransactionRequestInfo(label: $label, icon: $icon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionRequestInfo &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionRequestInfoCopyWith<_$_TransactionRequestInfo> get copyWith =>
      __$$_TransactionRequestInfoCopyWithImpl<_$_TransactionRequestInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionRequestInfoToJson(
      this,
    );
  }
}

abstract class _TransactionRequestInfo implements TransactionRequestInfo {
  const factory _TransactionRequestInfo(
      {required final String label,
      required final String icon}) = _$_TransactionRequestInfo;

  factory _TransactionRequestInfo.fromJson(Map<String, dynamic> json) =
      _$_TransactionRequestInfo.fromJson;

  @override
  String get label;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionRequestInfoCopyWith<_$_TransactionRequestInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionRequestResponse _$TransactionRequestResponseFromJson(
    Map<String, dynamic> json) {
  return _TransactionRequestResponse.fromJson(json);
}

/// @nodoc
mixin _$TransactionRequestResponse {
  String get transaction => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionRequestResponseCopyWith<TransactionRequestResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionRequestResponseCopyWith<$Res> {
  factory $TransactionRequestResponseCopyWith(TransactionRequestResponse value,
          $Res Function(TransactionRequestResponse) then) =
      _$TransactionRequestResponseCopyWithImpl<$Res,
          TransactionRequestResponse>;
  @useResult
  $Res call({String transaction, String? message});
}

/// @nodoc
class _$TransactionRequestResponseCopyWithImpl<$Res,
        $Val extends TransactionRequestResponse>
    implements $TransactionRequestResponseCopyWith<$Res> {
  _$TransactionRequestResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionRequestResponseCopyWith<$Res>
    implements $TransactionRequestResponseCopyWith<$Res> {
  factory _$$_TransactionRequestResponseCopyWith(
          _$_TransactionRequestResponse value,
          $Res Function(_$_TransactionRequestResponse) then) =
      __$$_TransactionRequestResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, String? message});
}

/// @nodoc
class __$$_TransactionRequestResponseCopyWithImpl<$Res>
    extends _$TransactionRequestResponseCopyWithImpl<$Res,
        _$_TransactionRequestResponse>
    implements _$$_TransactionRequestResponseCopyWith<$Res> {
  __$$_TransactionRequestResponseCopyWithImpl(
      _$_TransactionRequestResponse _value,
      $Res Function(_$_TransactionRequestResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? message = freezed,
  }) {
    return _then(_$_TransactionRequestResponse(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionRequestResponse implements _TransactionRequestResponse {
  const _$_TransactionRequestResponse(
      {required this.transaction, this.message});

  factory _$_TransactionRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionRequestResponseFromJson(json);

  @override
  final String transaction;
  @override
  final String? message;

  @override
  String toString() {
    return 'TransactionRequestResponse(transaction: $transaction, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionRequestResponse &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transaction, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionRequestResponseCopyWith<_$_TransactionRequestResponse>
      get copyWith => __$$_TransactionRequestResponseCopyWithImpl<
          _$_TransactionRequestResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionRequestResponseToJson(
      this,
    );
  }
}

abstract class _TransactionRequestResponse
    implements TransactionRequestResponse {
  const factory _TransactionRequestResponse(
      {required final String transaction,
      final String? message}) = _$_TransactionRequestResponse;

  factory _TransactionRequestResponse.fromJson(Map<String, dynamic> json) =
      _$_TransactionRequestResponse.fromJson;

  @override
  String get transaction;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionRequestResponseCopyWith<_$_TransactionRequestResponse>
      get copyWith => throw _privateConstructorUsedError;
}
