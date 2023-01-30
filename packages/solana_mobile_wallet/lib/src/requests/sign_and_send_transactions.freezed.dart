// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_and_send_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignAndSendTransactionsRequest {
  String? get identityName => throw _privateConstructorUsedError;
  Uri? get identityUri => throw _privateConstructorUsedError;
  Uri? get iconRelativeUri => throw _privateConstructorUsedError;
  String get cluster => throw _privateConstructorUsedError;
  Uint8List get authorizationScope => throw _privateConstructorUsedError;
  List<Uint8List> get transactions => throw _privateConstructorUsedError;
  int? get minContextSlot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignAndSendTransactionsRequestCopyWith<SignAndSendTransactionsRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory $SignAndSendTransactionsRequestCopyWith(
          SignAndSendTransactionsRequest value,
          $Res Function(SignAndSendTransactionsRequest) then) =
      _$SignAndSendTransactionsRequestCopyWithImpl<$Res,
          SignAndSendTransactionsRequest>;
  @useResult
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope,
      List<Uint8List> transactions,
      int? minContextSlot});
}

/// @nodoc
class _$SignAndSendTransactionsRequestCopyWithImpl<$Res,
        $Val extends SignAndSendTransactionsRequest>
    implements $SignAndSendTransactionsRequestCopyWith<$Res> {
  _$SignAndSendTransactionsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? transactions = null,
    Object? minContextSlot = freezed,
  }) {
    return _then(_value.copyWith(
      identityName: freezed == identityName
          ? _value.identityName
          : identityName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityUri: freezed == identityUri
          ? _value.identityUri
          : identityUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      iconRelativeUri: freezed == iconRelativeUri
          ? _value.iconRelativeUri
          : iconRelativeUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationScope: null == authorizationScope
          ? _value.authorizationScope
          : authorizationScope // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      minContextSlot: freezed == minContextSlot
          ? _value.minContextSlot
          : minContextSlot // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignAndSendTransactionsRequestCopyWith<$Res>
    implements $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory _$$_SignAndSendTransactionsRequestCopyWith(
          _$_SignAndSendTransactionsRequest value,
          $Res Function(_$_SignAndSendTransactionsRequest) then) =
      __$$_SignAndSendTransactionsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope,
      List<Uint8List> transactions,
      int? minContextSlot});
}

/// @nodoc
class __$$_SignAndSendTransactionsRequestCopyWithImpl<$Res>
    extends _$SignAndSendTransactionsRequestCopyWithImpl<$Res,
        _$_SignAndSendTransactionsRequest>
    implements _$$_SignAndSendTransactionsRequestCopyWith<$Res> {
  __$$_SignAndSendTransactionsRequestCopyWithImpl(
      _$_SignAndSendTransactionsRequest _value,
      $Res Function(_$_SignAndSendTransactionsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? transactions = null,
    Object? minContextSlot = freezed,
  }) {
    return _then(_$_SignAndSendTransactionsRequest(
      identityName: freezed == identityName
          ? _value.identityName
          : identityName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityUri: freezed == identityUri
          ? _value.identityUri
          : identityUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      iconRelativeUri: freezed == iconRelativeUri
          ? _value.iconRelativeUri
          : iconRelativeUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationScope: null == authorizationScope
          ? _value.authorizationScope
          : authorizationScope // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      minContextSlot: freezed == minContextSlot
          ? _value.minContextSlot
          : minContextSlot // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_SignAndSendTransactionsRequest
    implements _SignAndSendTransactionsRequest {
  const _$_SignAndSendTransactionsRequest(
      {required this.identityName,
      required this.identityUri,
      required this.iconRelativeUri,
      required this.cluster,
      required this.authorizationScope,
      required final List<Uint8List> transactions,
      required this.minContextSlot})
      : _transactions = transactions;

  @override
  final String? identityName;
  @override
  final Uri? identityUri;
  @override
  final Uri? iconRelativeUri;
  @override
  final String cluster;
  @override
  final Uint8List authorizationScope;
  final List<Uint8List> _transactions;
  @override
  List<Uint8List> get transactions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final int? minContextSlot;

  @override
  String toString() {
    return 'SignAndSendTransactionsRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, transactions: $transactions, minContextSlot: $minContextSlot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignAndSendTransactionsRequest &&
            (identical(other.identityName, identityName) ||
                other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) ||
                other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality()
                .equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.minContextSlot, minContextSlot) ||
                other.minContextSlot == minContextSlot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      const DeepCollectionEquality().hash(authorizationScope),
      const DeepCollectionEquality().hash(_transactions),
      minContextSlot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignAndSendTransactionsRequestCopyWith<_$_SignAndSendTransactionsRequest>
      get copyWith => __$$_SignAndSendTransactionsRequestCopyWithImpl<
          _$_SignAndSendTransactionsRequest>(this, _$identity);
}

abstract class _SignAndSendTransactionsRequest
    implements SignAndSendTransactionsRequest {
  const factory _SignAndSendTransactionsRequest(
      {required final String? identityName,
      required final Uri? identityUri,
      required final Uri? iconRelativeUri,
      required final String cluster,
      required final Uint8List authorizationScope,
      required final List<Uint8List> transactions,
      required final int? minContextSlot}) = _$_SignAndSendTransactionsRequest;

  @override
  String? get identityName;
  @override
  Uri? get identityUri;
  @override
  Uri? get iconRelativeUri;
  @override
  String get cluster;
  @override
  Uint8List get authorizationScope;
  @override
  List<Uint8List> get transactions;
  @override
  int? get minContextSlot;
  @override
  @JsonKey(ignore: true)
  _$$_SignAndSendTransactionsRequestCopyWith<_$_SignAndSendTransactionsRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignaturesResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignaturesResultCopyWith<$Res> {
  factory $SignaturesResultCopyWith(
          SignaturesResult value, $Res Function(SignaturesResult) then) =
      _$SignaturesResultCopyWithImpl<$Res, SignaturesResult>;
}

/// @nodoc
class _$SignaturesResultCopyWithImpl<$Res, $Val extends SignaturesResult>
    implements $SignaturesResultCopyWith<$Res> {
  _$SignaturesResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SignaturesResultCopyWith<$Res> {
  factory _$$_SignaturesResultCopyWith(
          _$_SignaturesResult value, $Res Function(_$_SignaturesResult) then) =
      __$$_SignaturesResultCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$$_SignaturesResultCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_SignaturesResult>
    implements _$$_SignaturesResultCopyWith<$Res> {
  __$$_SignaturesResultCopyWithImpl(
      _$_SignaturesResult _value, $Res Function(_$_SignaturesResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
  }) {
    return _then(_$_SignaturesResult(
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_SignaturesResult extends _SignaturesResult {
  const _$_SignaturesResult({required final List<Uint8List> signatures})
      : _signatures = signatures,
        super._();

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  String toString() {
    return 'SignaturesResult(signatures: $signatures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignaturesResult &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignaturesResultCopyWith<_$_SignaturesResult> get copyWith =>
      __$$_SignaturesResultCopyWithImpl<_$_SignaturesResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return $default(signatures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return $default?.call(signatures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(signatures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _SignaturesResult extends SignaturesResult {
  const factory _SignaturesResult({required final List<Uint8List> signatures}) =
      _$_SignaturesResult;
  const _SignaturesResult._() : super._();

  List<Uint8List> get signatures;
  @JsonKey(ignore: true)
  _$$_SignaturesResultCopyWith<_$_SignaturesResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RequestDeclinedCopyWith<$Res> {
  factory _$$_RequestDeclinedCopyWith(
          _$_RequestDeclined value, $Res Function(_$_RequestDeclined) then) =
      __$$_RequestDeclinedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RequestDeclinedCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_RequestDeclined>
    implements _$$_RequestDeclinedCopyWith<$Res> {
  __$$_RequestDeclinedCopyWithImpl(
      _$_RequestDeclined _value, $Res Function(_$_RequestDeclined) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_RequestDeclined extends _RequestDeclined {
  const _$_RequestDeclined() : super._();

  @override
  String toString() {
    return 'SignaturesResult.requestDeclined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_RequestDeclined);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return requestDeclined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return requestDeclined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if (requestDeclined != null) {
      return requestDeclined();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return requestDeclined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return requestDeclined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if (requestDeclined != null) {
      return requestDeclined(this);
    }
    return orElse();
  }
}

abstract class _RequestDeclined extends SignaturesResult {
  const factory _RequestDeclined() = _$_RequestDeclined;
  const _RequestDeclined._() : super._();
}

/// @nodoc
abstract class _$$_InvalidPayloadsCopyWith<$Res> {
  factory _$$_InvalidPayloadsCopyWith(
          _$_InvalidPayloads value, $Res Function(_$_InvalidPayloads) then) =
      __$$_InvalidPayloadsCopyWithImpl<$Res>;
  @useResult
  $Res call({List<bool> valid});
}

/// @nodoc
class __$$_InvalidPayloadsCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_InvalidPayloads>
    implements _$$_InvalidPayloadsCopyWith<$Res> {
  __$$_InvalidPayloadsCopyWithImpl(
      _$_InvalidPayloads _value, $Res Function(_$_InvalidPayloads) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valid = null,
  }) {
    return _then(_$_InvalidPayloads(
      valid: null == valid
          ? _value._valid
          : valid // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$_InvalidPayloads extends _InvalidPayloads {
  const _$_InvalidPayloads({required final List<bool> valid})
      : _valid = valid,
        super._();

  final List<bool> _valid;
  @override
  List<bool> get valid {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_valid);
  }

  @override
  String toString() {
    return 'SignaturesResult.invalidPayloads(valid: $valid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvalidPayloads &&
            const DeepCollectionEquality().equals(other._valid, _valid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_valid));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InvalidPayloadsCopyWith<_$_InvalidPayloads> get copyWith =>
      __$$_InvalidPayloadsCopyWithImpl<_$_InvalidPayloads>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return invalidPayloads(valid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return invalidPayloads?.call(valid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if (invalidPayloads != null) {
      return invalidPayloads(valid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return invalidPayloads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return invalidPayloads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if (invalidPayloads != null) {
      return invalidPayloads(this);
    }
    return orElse();
  }
}

abstract class _InvalidPayloads extends SignaturesResult {
  const factory _InvalidPayloads({required final List<bool> valid}) =
      _$_InvalidPayloads;
  const _InvalidPayloads._() : super._();

  List<bool> get valid;
  @JsonKey(ignore: true)
  _$$_InvalidPayloadsCopyWith<_$_InvalidPayloads> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TooManyPayloadsCopyWith<$Res> {
  factory _$$_TooManyPayloadsCopyWith(
          _$_TooManyPayloads value, $Res Function(_$_TooManyPayloads) then) =
      __$$_TooManyPayloadsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TooManyPayloadsCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_TooManyPayloads>
    implements _$$_TooManyPayloadsCopyWith<$Res> {
  __$$_TooManyPayloadsCopyWithImpl(
      _$_TooManyPayloads _value, $Res Function(_$_TooManyPayloads) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TooManyPayloads extends _TooManyPayloads {
  const _$_TooManyPayloads() : super._();

  @override
  String toString() {
    return 'SignaturesResult.tooManyPayloads()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_TooManyPayloads);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return tooManyPayloads();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return tooManyPayloads?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if (tooManyPayloads != null) {
      return tooManyPayloads();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return tooManyPayloads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return tooManyPayloads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if (tooManyPayloads != null) {
      return tooManyPayloads(this);
    }
    return orElse();
  }
}

abstract class _TooManyPayloads extends SignaturesResult {
  const factory _TooManyPayloads() = _$_TooManyPayloads;
  const _TooManyPayloads._() : super._();
}

/// @nodoc
abstract class _$$_AuthorizationNotValidCopyWith<$Res> {
  factory _$$_AuthorizationNotValidCopyWith(_$_AuthorizationNotValid value,
          $Res Function(_$_AuthorizationNotValid) then) =
      __$$_AuthorizationNotValidCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthorizationNotValidCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_AuthorizationNotValid>
    implements _$$_AuthorizationNotValidCopyWith<$Res> {
  __$$_AuthorizationNotValidCopyWithImpl(_$_AuthorizationNotValid _value,
      $Res Function(_$_AuthorizationNotValid) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthorizationNotValid extends _AuthorizationNotValid {
  const _$_AuthorizationNotValid() : super._();

  @override
  String toString() {
    return 'SignaturesResult.authorizationNotValid()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthorizationNotValid);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return authorizationNotValid();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return authorizationNotValid?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if (authorizationNotValid != null) {
      return authorizationNotValid();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return authorizationNotValid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return authorizationNotValid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if (authorizationNotValid != null) {
      return authorizationNotValid(this);
    }
    return orElse();
  }
}

abstract class _AuthorizationNotValid extends SignaturesResult {
  const factory _AuthorizationNotValid() = _$_AuthorizationNotValid;
  const _AuthorizationNotValid._() : super._();
}

/// @nodoc
abstract class _$$_NotSubmittedCopyWith<$Res> {
  factory _$$_NotSubmittedCopyWith(
          _$_NotSubmitted value, $Res Function(_$_NotSubmitted) then) =
      __$$_NotSubmittedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$$_NotSubmittedCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$_NotSubmitted>
    implements _$$_NotSubmittedCopyWith<$Res> {
  __$$_NotSubmittedCopyWithImpl(
      _$_NotSubmitted _value, $Res Function(_$_NotSubmitted) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
  }) {
    return _then(_$_NotSubmitted(
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_NotSubmitted extends _NotSubmitted {
  const _$_NotSubmitted({required final List<Uint8List> signatures})
      : _signatures = signatures,
        super._();

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  String toString() {
    return 'SignaturesResult.notSubmitted(signatures: $signatures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotSubmitted &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotSubmittedCopyWith<_$_NotSubmitted> get copyWith =>
      __$$_NotSubmittedCopyWithImpl<_$_NotSubmitted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
    required TResult Function(List<Uint8List> signatures) notSubmitted,
  }) {
    return notSubmitted(signatures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) {
    return notSubmitted?.call(signatures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) {
    if (notSubmitted != null) {
      return notSubmitted(signatures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) {
    return notSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) {
    return notSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) {
    if (notSubmitted != null) {
      return notSubmitted(this);
    }
    return orElse();
  }
}

abstract class _NotSubmitted extends SignaturesResult {
  const factory _NotSubmitted({required final List<Uint8List> signatures}) =
      _$_NotSubmitted;
  const _NotSubmitted._() : super._();

  List<Uint8List> get signatures;
  @JsonKey(ignore: true)
  _$$_NotSubmittedCopyWith<_$_NotSubmitted> get copyWith =>
      throw _privateConstructorUsedError;
}
