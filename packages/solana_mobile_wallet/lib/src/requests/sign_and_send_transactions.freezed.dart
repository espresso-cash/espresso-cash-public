// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_and_send_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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
  $SignAndSendTransactionsRequestCopyWith<SignAndSendTransactionsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory $SignAndSendTransactionsRequestCopyWith(
    SignAndSendTransactionsRequest value,
    $Res Function(SignAndSendTransactionsRequest) then,
  ) = _$SignAndSendTransactionsRequestCopyWithImpl<$Res, SignAndSendTransactionsRequest>;
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> transactions,
    int? minContextSlot,
  });
}

/// @nodoc
class _$SignAndSendTransactionsRequestCopyWithImpl<
  $Res,
  $Val extends SignAndSendTransactionsRequest
>
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
    return _then(
      _value.copyWith(
            identityName:
                freezed == identityName
                    ? _value.identityName
                    : identityName // ignore: cast_nullable_to_non_nullable
                        as String?,
            identityUri:
                freezed == identityUri
                    ? _value.identityUri
                    : identityUri // ignore: cast_nullable_to_non_nullable
                        as Uri?,
            iconRelativeUri:
                freezed == iconRelativeUri
                    ? _value.iconRelativeUri
                    : iconRelativeUri // ignore: cast_nullable_to_non_nullable
                        as Uri?,
            cluster:
                null == cluster
                    ? _value.cluster
                    : cluster // ignore: cast_nullable_to_non_nullable
                        as String,
            authorizationScope:
                null == authorizationScope
                    ? _value.authorizationScope
                    : authorizationScope // ignore: cast_nullable_to_non_nullable
                        as Uint8List,
            transactions:
                null == transactions
                    ? _value.transactions
                    : transactions // ignore: cast_nullable_to_non_nullable
                        as List<Uint8List>,
            minContextSlot:
                freezed == minContextSlot
                    ? _value.minContextSlot
                    : minContextSlot // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignAndSendTransactionsRequestImplCopyWith<$Res>
    implements $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory _$$SignAndSendTransactionsRequestImplCopyWith(
    _$SignAndSendTransactionsRequestImpl value,
    $Res Function(_$SignAndSendTransactionsRequestImpl) then,
  ) = __$$SignAndSendTransactionsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> transactions,
    int? minContextSlot,
  });
}

/// @nodoc
class __$$SignAndSendTransactionsRequestImplCopyWithImpl<$Res>
    extends _$SignAndSendTransactionsRequestCopyWithImpl<$Res, _$SignAndSendTransactionsRequestImpl>
    implements _$$SignAndSendTransactionsRequestImplCopyWith<$Res> {
  __$$SignAndSendTransactionsRequestImplCopyWithImpl(
    _$SignAndSendTransactionsRequestImpl _value,
    $Res Function(_$SignAndSendTransactionsRequestImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$SignAndSendTransactionsRequestImpl(
        identityName:
            freezed == identityName
                ? _value.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _value.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconRelativeUri:
            freezed == iconRelativeUri
                ? _value.iconRelativeUri
                : iconRelativeUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        cluster:
            null == cluster
                ? _value.cluster
                : cluster // ignore: cast_nullable_to_non_nullable
                    as String,
        authorizationScope:
            null == authorizationScope
                ? _value.authorizationScope
                : authorizationScope // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        transactions:
            null == transactions
                ? _value._transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        minContextSlot:
            freezed == minContextSlot
                ? _value.minContextSlot
                : minContextSlot // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$SignAndSendTransactionsRequestImpl implements _SignAndSendTransactionsRequest {
  const _$SignAndSendTransactionsRequestImpl({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
    required final List<Uint8List> transactions,
    required this.minContextSlot,
  }) : _transactions = transactions;

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
    if (_transactions is EqualUnmodifiableListView) return _transactions;
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignAndSendTransactionsRequestImpl &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._transactions, _transactions) &&
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
    minContextSlot,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignAndSendTransactionsRequestImplCopyWith<_$SignAndSendTransactionsRequestImpl>
  get copyWith =>
      __$$SignAndSendTransactionsRequestImplCopyWithImpl<_$SignAndSendTransactionsRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _SignAndSendTransactionsRequest implements SignAndSendTransactionsRequest {
  const factory _SignAndSendTransactionsRequest({
    required final String? identityName,
    required final Uri? identityUri,
    required final Uri? iconRelativeUri,
    required final String cluster,
    required final Uint8List authorizationScope,
    required final List<Uint8List> transactions,
    required final int? minContextSlot,
  }) = _$SignAndSendTransactionsRequestImpl;

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
  _$$SignAndSendTransactionsRequestImplCopyWith<_$SignAndSendTransactionsRequestImpl>
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
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Uint8List> signatures)? $default, {
    TResult? Function()? requestDeclined,
    TResult? Function(List<bool> valid)? invalidPayloads,
    TResult? Function()? tooManyPayloads,
    TResult? Function()? authorizationNotValid,
    TResult? Function(List<Uint8List> signatures)? notSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Uint8List> signatures)? $default, {
    TResult Function()? requestDeclined,
    TResult Function(List<bool> valid)? invalidPayloads,
    TResult Function()? tooManyPayloads,
    TResult Function()? authorizationNotValid,
    TResult Function(List<Uint8List> signatures)? notSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignaturesResult value) $default, {
    required TResult Function(_RequestDeclined value) requestDeclined,
    required TResult Function(_InvalidPayloads value) invalidPayloads,
    required TResult Function(_TooManyPayloads value) tooManyPayloads,
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
    required TResult Function(_NotSubmitted value) notSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignaturesResult value)? $default, {
    TResult? Function(_RequestDeclined value)? requestDeclined,
    TResult? Function(_InvalidPayloads value)? invalidPayloads,
    TResult? Function(_TooManyPayloads value)? tooManyPayloads,
    TResult? Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult? Function(_NotSubmitted value)? notSubmitted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignaturesResult value)? $default, {
    TResult Function(_RequestDeclined value)? requestDeclined,
    TResult Function(_InvalidPayloads value)? invalidPayloads,
    TResult Function(_TooManyPayloads value)? tooManyPayloads,
    TResult Function(_AuthorizationNotValid value)? authorizationNotValid,
    TResult Function(_NotSubmitted value)? notSubmitted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignaturesResultCopyWith<$Res> {
  factory $SignaturesResultCopyWith(SignaturesResult value, $Res Function(SignaturesResult) then) =
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
abstract class _$$SignaturesResultImplCopyWith<$Res> {
  factory _$$SignaturesResultImplCopyWith(
    _$SignaturesResultImpl value,
    $Res Function(_$SignaturesResultImpl) then,
  ) = __$$SignaturesResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$$SignaturesResultImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$SignaturesResultImpl>
    implements _$$SignaturesResultImplCopyWith<$Res> {
  __$$SignaturesResultImplCopyWithImpl(
    _$SignaturesResultImpl _value,
    $Res Function(_$SignaturesResultImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null}) {
    return _then(
      _$SignaturesResultImpl(
        signatures:
            null == signatures
                ? _value._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class _$SignaturesResultImpl extends _SignaturesResult {
  const _$SignaturesResultImpl({required final List<Uint8List> signatures})
    : _signatures = signatures,
      super._();

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  String toString() {
    return 'SignaturesResult(signatures: $signatures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignaturesResultImpl &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignaturesResultImplCopyWith<_$SignaturesResultImpl> get copyWith =>
      __$$SignaturesResultImplCopyWithImpl<_$SignaturesResultImpl>(this, _$identity);

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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
      _$SignaturesResultImpl;
  const _SignaturesResult._() : super._();

  List<Uint8List> get signatures;
  @JsonKey(ignore: true)
  _$$SignaturesResultImplCopyWith<_$SignaturesResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestDeclinedImplCopyWith<$Res> {
  factory _$$RequestDeclinedImplCopyWith(
    _$RequestDeclinedImpl value,
    $Res Function(_$RequestDeclinedImpl) then,
  ) = __$$RequestDeclinedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestDeclinedImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$RequestDeclinedImpl>
    implements _$$RequestDeclinedImplCopyWith<$Res> {
  __$$RequestDeclinedImplCopyWithImpl(
    _$RequestDeclinedImpl _value,
    $Res Function(_$RequestDeclinedImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$RequestDeclinedImpl extends _RequestDeclined {
  const _$RequestDeclinedImpl() : super._();

  @override
  String toString() {
    return 'SignaturesResult.requestDeclined()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RequestDeclinedImpl);
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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
  const factory _RequestDeclined() = _$RequestDeclinedImpl;
  const _RequestDeclined._() : super._();
}

/// @nodoc
abstract class _$$InvalidPayloadsImplCopyWith<$Res> {
  factory _$$InvalidPayloadsImplCopyWith(
    _$InvalidPayloadsImpl value,
    $Res Function(_$InvalidPayloadsImpl) then,
  ) = __$$InvalidPayloadsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<bool> valid});
}

/// @nodoc
class __$$InvalidPayloadsImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$InvalidPayloadsImpl>
    implements _$$InvalidPayloadsImplCopyWith<$Res> {
  __$$InvalidPayloadsImplCopyWithImpl(
    _$InvalidPayloadsImpl _value,
    $Res Function(_$InvalidPayloadsImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? valid = null}) {
    return _then(
      _$InvalidPayloadsImpl(
        valid:
            null == valid
                ? _value._valid
                : valid // ignore: cast_nullable_to_non_nullable
                    as List<bool>,
      ),
    );
  }
}

/// @nodoc

class _$InvalidPayloadsImpl extends _InvalidPayloads {
  const _$InvalidPayloadsImpl({required final List<bool> valid}) : _valid = valid, super._();

  final List<bool> _valid;
  @override
  List<bool> get valid {
    if (_valid is EqualUnmodifiableListView) return _valid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_valid);
  }

  @override
  String toString() {
    return 'SignaturesResult.invalidPayloads(valid: $valid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidPayloadsImpl &&
            const DeepCollectionEquality().equals(other._valid, _valid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_valid));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidPayloadsImplCopyWith<_$InvalidPayloadsImpl> get copyWith =>
      __$$InvalidPayloadsImplCopyWithImpl<_$InvalidPayloadsImpl>(this, _$identity);

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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
  const factory _InvalidPayloads({required final List<bool> valid}) = _$InvalidPayloadsImpl;
  const _InvalidPayloads._() : super._();

  List<bool> get valid;
  @JsonKey(ignore: true)
  _$$InvalidPayloadsImplCopyWith<_$InvalidPayloadsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TooManyPayloadsImplCopyWith<$Res> {
  factory _$$TooManyPayloadsImplCopyWith(
    _$TooManyPayloadsImpl value,
    $Res Function(_$TooManyPayloadsImpl) then,
  ) = __$$TooManyPayloadsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TooManyPayloadsImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$TooManyPayloadsImpl>
    implements _$$TooManyPayloadsImplCopyWith<$Res> {
  __$$TooManyPayloadsImplCopyWithImpl(
    _$TooManyPayloadsImpl _value,
    $Res Function(_$TooManyPayloadsImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$TooManyPayloadsImpl extends _TooManyPayloads {
  const _$TooManyPayloadsImpl() : super._();

  @override
  String toString() {
    return 'SignaturesResult.tooManyPayloads()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TooManyPayloadsImpl);
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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
  const factory _TooManyPayloads() = _$TooManyPayloadsImpl;
  const _TooManyPayloads._() : super._();
}

/// @nodoc
abstract class _$$AuthorizationNotValidImplCopyWith<$Res> {
  factory _$$AuthorizationNotValidImplCopyWith(
    _$AuthorizationNotValidImpl value,
    $Res Function(_$AuthorizationNotValidImpl) then,
  ) = __$$AuthorizationNotValidImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthorizationNotValidImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$AuthorizationNotValidImpl>
    implements _$$AuthorizationNotValidImplCopyWith<$Res> {
  __$$AuthorizationNotValidImplCopyWithImpl(
    _$AuthorizationNotValidImpl _value,
    $Res Function(_$AuthorizationNotValidImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$AuthorizationNotValidImpl extends _AuthorizationNotValid {
  const _$AuthorizationNotValidImpl() : super._();

  @override
  String toString() {
    return 'SignaturesResult.authorizationNotValid()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthorizationNotValidImpl);
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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
  const factory _AuthorizationNotValid() = _$AuthorizationNotValidImpl;
  const _AuthorizationNotValid._() : super._();
}

/// @nodoc
abstract class _$$NotSubmittedImplCopyWith<$Res> {
  factory _$$NotSubmittedImplCopyWith(
    _$NotSubmittedImpl value,
    $Res Function(_$NotSubmittedImpl) then,
  ) = __$$NotSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$$NotSubmittedImplCopyWithImpl<$Res>
    extends _$SignaturesResultCopyWithImpl<$Res, _$NotSubmittedImpl>
    implements _$$NotSubmittedImplCopyWith<$Res> {
  __$$NotSubmittedImplCopyWithImpl(
    _$NotSubmittedImpl _value,
    $Res Function(_$NotSubmittedImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null}) {
    return _then(
      _$NotSubmittedImpl(
        signatures:
            null == signatures
                ? _value._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class _$NotSubmittedImpl extends _NotSubmitted {
  const _$NotSubmittedImpl({required final List<Uint8List> signatures})
    : _signatures = signatures,
      super._();

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  String toString() {
    return 'SignaturesResult.notSubmitted(signatures: $signatures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotSubmittedImpl &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotSubmittedImplCopyWith<_$NotSubmittedImpl> get copyWith =>
      __$$NotSubmittedImplCopyWithImpl<_$NotSubmittedImpl>(this, _$identity);

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
    required TResult Function(_AuthorizationNotValid value) authorizationNotValid,
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
  const factory _NotSubmitted({required final List<Uint8List> signatures}) = _$NotSubmittedImpl;
  const _NotSubmitted._() : super._();

  List<Uint8List> get signatures;
  @JsonKey(ignore: true)
  _$$NotSubmittedImplCopyWith<_$NotSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
