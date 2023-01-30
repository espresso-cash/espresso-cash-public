// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignPayloadsRequest {
  String? get identityName => throw _privateConstructorUsedError;
  Uri? get identityUri => throw _privateConstructorUsedError;
  Uri? get iconRelativeUri => throw _privateConstructorUsedError;
  String get cluster => throw _privateConstructorUsedError;
  Uint8List get authorizationScope => throw _privateConstructorUsedError;
  List<Uint8List> get payloads => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        transactions,
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        messages,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignTransactionsRequest value) transactions,
    required TResult Function(SignMessagesRequest value) messages,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignTransactionsRequest value)? transactions,
    TResult? Function(SignMessagesRequest value)? messages,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignTransactionsRequest value)? transactions,
    TResult Function(SignMessagesRequest value)? messages,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignPayloadsRequestCopyWith<SignPayloadsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignPayloadsRequestCopyWith<$Res> {
  factory $SignPayloadsRequestCopyWith(
          SignPayloadsRequest value, $Res Function(SignPayloadsRequest) then) =
      _$SignPayloadsRequestCopyWithImpl<$Res, SignPayloadsRequest>;
  @useResult
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope,
      List<Uint8List> payloads});
}

/// @nodoc
class _$SignPayloadsRequestCopyWithImpl<$Res, $Val extends SignPayloadsRequest>
    implements $SignPayloadsRequestCopyWith<$Res> {
  _$SignPayloadsRequestCopyWithImpl(this._value, this._then);

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
    Object? payloads = null,
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
      payloads: null == payloads
          ? _value.payloads
          : payloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignTransactionsRequestCopyWith<$Res>
    implements $SignPayloadsRequestCopyWith<$Res> {
  factory _$$SignTransactionsRequestCopyWith(_$SignTransactionsRequest value,
          $Res Function(_$SignTransactionsRequest) then) =
      __$$SignTransactionsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope,
      List<Uint8List> payloads});
}

/// @nodoc
class __$$SignTransactionsRequestCopyWithImpl<$Res>
    extends _$SignPayloadsRequestCopyWithImpl<$Res, _$SignTransactionsRequest>
    implements _$$SignTransactionsRequestCopyWith<$Res> {
  __$$SignTransactionsRequestCopyWithImpl(_$SignTransactionsRequest _value,
      $Res Function(_$SignTransactionsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? payloads = null,
  }) {
    return _then(_$SignTransactionsRequest(
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
      payloads: null == payloads
          ? _value._payloads
          : payloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$SignTransactionsRequest implements SignTransactionsRequest {
  const _$SignTransactionsRequest(
      {required this.identityName,
      required this.identityUri,
      required this.iconRelativeUri,
      required this.cluster,
      required this.authorizationScope,
      required final List<Uint8List> payloads})
      : _payloads = payloads;

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
  final List<Uint8List> _payloads;
  @override
  List<Uint8List> get payloads {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payloads);
  }

  @override
  String toString() {
    return 'SignPayloadsRequest.transactions(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, payloads: $payloads)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignTransactionsRequest &&
            (identical(other.identityName, identityName) ||
                other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) ||
                other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality()
                .equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._payloads, _payloads));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      const DeepCollectionEquality().hash(authorizationScope),
      const DeepCollectionEquality().hash(_payloads));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignTransactionsRequestCopyWith<_$SignTransactionsRequest> get copyWith =>
      __$$SignTransactionsRequestCopyWithImpl<_$SignTransactionsRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        transactions,
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        messages,
  }) {
    return transactions(identityName, identityUri, iconRelativeUri, cluster,
        authorizationScope, payloads);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
  }) {
    return transactions?.call(identityName, identityUri, iconRelativeUri,
        cluster, authorizationScope, payloads);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
    required TResult orElse(),
  }) {
    if (transactions != null) {
      return transactions(identityName, identityUri, iconRelativeUri, cluster,
          authorizationScope, payloads);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignTransactionsRequest value) transactions,
    required TResult Function(SignMessagesRequest value) messages,
  }) {
    return transactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignTransactionsRequest value)? transactions,
    TResult? Function(SignMessagesRequest value)? messages,
  }) {
    return transactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignTransactionsRequest value)? transactions,
    TResult Function(SignMessagesRequest value)? messages,
    required TResult orElse(),
  }) {
    if (transactions != null) {
      return transactions(this);
    }
    return orElse();
  }
}

abstract class SignTransactionsRequest implements SignPayloadsRequest {
  const factory SignTransactionsRequest(
      {required final String? identityName,
      required final Uri? identityUri,
      required final Uri? iconRelativeUri,
      required final String cluster,
      required final Uint8List authorizationScope,
      required final List<Uint8List> payloads}) = _$SignTransactionsRequest;

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
  List<Uint8List> get payloads;
  @override
  @JsonKey(ignore: true)
  _$$SignTransactionsRequestCopyWith<_$SignTransactionsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignMessagesRequestCopyWith<$Res>
    implements $SignPayloadsRequestCopyWith<$Res> {
  factory _$$SignMessagesRequestCopyWith(_$SignMessagesRequest value,
          $Res Function(_$SignMessagesRequest) then) =
      __$$SignMessagesRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope,
      List<Uint8List> payloads});
}

/// @nodoc
class __$$SignMessagesRequestCopyWithImpl<$Res>
    extends _$SignPayloadsRequestCopyWithImpl<$Res, _$SignMessagesRequest>
    implements _$$SignMessagesRequestCopyWith<$Res> {
  __$$SignMessagesRequestCopyWithImpl(
      _$SignMessagesRequest _value, $Res Function(_$SignMessagesRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? payloads = null,
  }) {
    return _then(_$SignMessagesRequest(
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
      payloads: null == payloads
          ? _value._payloads
          : payloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$SignMessagesRequest implements SignMessagesRequest {
  const _$SignMessagesRequest(
      {required this.identityName,
      required this.identityUri,
      required this.iconRelativeUri,
      required this.cluster,
      required this.authorizationScope,
      required final List<Uint8List> payloads})
      : _payloads = payloads;

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
  final List<Uint8List> _payloads;
  @override
  List<Uint8List> get payloads {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payloads);
  }

  @override
  String toString() {
    return 'SignPayloadsRequest.messages(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, payloads: $payloads)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignMessagesRequest &&
            (identical(other.identityName, identityName) ||
                other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) ||
                other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality()
                .equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._payloads, _payloads));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      identityName,
      identityUri,
      iconRelativeUri,
      cluster,
      const DeepCollectionEquality().hash(authorizationScope),
      const DeepCollectionEquality().hash(_payloads));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignMessagesRequestCopyWith<_$SignMessagesRequest> get copyWith =>
      __$$SignMessagesRequestCopyWithImpl<_$SignMessagesRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        transactions,
    required TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)
        messages,
  }) {
    return messages(identityName, identityUri, iconRelativeUri, cluster,
        authorizationScope, payloads);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult? Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
  }) {
    return messages?.call(identityName, identityUri, iconRelativeUri, cluster,
        authorizationScope, payloads);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        transactions,
    TResult Function(
            String? identityName,
            Uri? identityUri,
            Uri? iconRelativeUri,
            String cluster,
            Uint8List authorizationScope,
            List<Uint8List> payloads)?
        messages,
    required TResult orElse(),
  }) {
    if (messages != null) {
      return messages(identityName, identityUri, iconRelativeUri, cluster,
          authorizationScope, payloads);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignTransactionsRequest value) transactions,
    required TResult Function(SignMessagesRequest value) messages,
  }) {
    return messages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignTransactionsRequest value)? transactions,
    TResult? Function(SignMessagesRequest value)? messages,
  }) {
    return messages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignTransactionsRequest value)? transactions,
    TResult Function(SignMessagesRequest value)? messages,
    required TResult orElse(),
  }) {
    if (messages != null) {
      return messages(this);
    }
    return orElse();
  }
}

abstract class SignMessagesRequest implements SignPayloadsRequest {
  const factory SignMessagesRequest(
      {required final String? identityName,
      required final Uri? identityUri,
      required final Uri? iconRelativeUri,
      required final String cluster,
      required final Uint8List authorizationScope,
      required final List<Uint8List> payloads}) = _$SignMessagesRequest;

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
  List<Uint8List> get payloads;
  @override
  @JsonKey(ignore: true)
  _$$SignMessagesRequestCopyWith<_$SignMessagesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignedPayloadResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedPayloadResultCopyWith<$Res> {
  factory $SignedPayloadResultCopyWith(
          SignedPayloadResult value, $Res Function(SignedPayloadResult) then) =
      _$SignedPayloadResultCopyWithImpl<$Res, SignedPayloadResult>;
}

/// @nodoc
class _$SignedPayloadResultCopyWithImpl<$Res, $Val extends SignedPayloadResult>
    implements $SignedPayloadResultCopyWith<$Res> {
  _$SignedPayloadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SignedPayloadResultCopyWith<$Res> {
  factory _$$_SignedPayloadResultCopyWith(_$_SignedPayloadResult value,
          $Res Function(_$_SignedPayloadResult) then) =
      __$$_SignedPayloadResultCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class __$$_SignedPayloadResultCopyWithImpl<$Res>
    extends _$SignedPayloadResultCopyWithImpl<$Res, _$_SignedPayloadResult>
    implements _$$_SignedPayloadResultCopyWith<$Res> {
  __$$_SignedPayloadResultCopyWithImpl(_$_SignedPayloadResult _value,
      $Res Function(_$_SignedPayloadResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedPayloads = null,
  }) {
    return _then(_$_SignedPayloadResult(
      signedPayloads: null == signedPayloads
          ? _value._signedPayloads
          : signedPayloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_SignedPayloadResult extends _SignedPayloadResult {
  const _$_SignedPayloadResult({required final List<Uint8List> signedPayloads})
      : _signedPayloads = signedPayloads,
        super._();

  final List<Uint8List> _signedPayloads;
  @override
  List<Uint8List> get signedPayloads {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedPayloads);
  }

  @override
  String toString() {
    return 'SignedPayloadResult(signedPayloads: $signedPayloads)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignedPayloadResult &&
            const DeepCollectionEquality()
                .equals(other._signedPayloads, _signedPayloads));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signedPayloads));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignedPayloadResultCopyWith<_$_SignedPayloadResult> get copyWith =>
      __$$_SignedPayloadResultCopyWithImpl<_$_SignedPayloadResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) {
    return $default(signedPayloads);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) {
    return $default?.call(signedPayloads);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(signedPayloads);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _SignedPayloadResult extends SignedPayloadResult {
  const factory _SignedPayloadResult(
      {required final List<Uint8List> signedPayloads}) = _$_SignedPayloadResult;
  const _SignedPayloadResult._() : super._();

  List<Uint8List> get signedPayloads;
  @JsonKey(ignore: true)
  _$$_SignedPayloadResultCopyWith<_$_SignedPayloadResult> get copyWith =>
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
    extends _$SignedPayloadResultCopyWithImpl<$Res, _$_RequestDeclined>
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
    return 'SignedPayloadResult.requestDeclined()';
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
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) {
    return requestDeclined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) {
    return requestDeclined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
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
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) {
    return requestDeclined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) {
    return requestDeclined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) {
    if (requestDeclined != null) {
      return requestDeclined(this);
    }
    return orElse();
  }
}

abstract class _RequestDeclined extends SignedPayloadResult {
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
    extends _$SignedPayloadResultCopyWithImpl<$Res, _$_InvalidPayloads>
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
    return 'SignedPayloadResult.invalidPayloads(valid: $valid)';
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
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) {
    return invalidPayloads(valid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) {
    return invalidPayloads?.call(valid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
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
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) {
    return invalidPayloads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) {
    return invalidPayloads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) {
    if (invalidPayloads != null) {
      return invalidPayloads(this);
    }
    return orElse();
  }
}

abstract class _InvalidPayloads extends SignedPayloadResult {
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
    extends _$SignedPayloadResultCopyWithImpl<$Res, _$_TooManyPayloads>
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
    return 'SignedPayloadResult.tooManyPayloads()';
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
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) {
    return tooManyPayloads();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) {
    return tooManyPayloads?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
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
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) {
    return tooManyPayloads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) {
    return tooManyPayloads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) {
    if (tooManyPayloads != null) {
      return tooManyPayloads(this);
    }
    return orElse();
  }
}

abstract class _TooManyPayloads extends SignedPayloadResult {
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
    extends _$SignedPayloadResultCopyWithImpl<$Res, _$_AuthorizationNotValid>
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
    return 'SignedPayloadResult.authorizationNotValid()';
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
    TResult Function(List<Uint8List> signedPayloads) $default, {
    required TResult Function() requestDeclined,
    required TResult Function(List<bool> valid) invalidPayloads,
    required TResult Function() tooManyPayloads,
    required TResult Function() authorizationNotValid,
  }) {
    return authorizationNotValid();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signedPayloads)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
  }) {
    return authorizationNotValid?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signedPayloads)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
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
    TResult Function(_SignedPayloadResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value)
        authorizationNotValid,
  }) {
    return authorizationNotValid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignedPayloadResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
  }) {
    return authorizationNotValid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignedPayloadResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    required TResult orElse(),
  }) {
    if (authorizationNotValid != null) {
      return authorizationNotValid(this);
    }
    return orElse();
  }
}

abstract class _AuthorizationNotValid extends SignedPayloadResult {
  const factory _AuthorizationNotValid() = _$_AuthorizationNotValid;
  const _AuthorizationNotValid._() : super._();
}
