// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stellar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InitiateStellarDepositRequestDto _$InitiateStellarDepositRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _InitiateStellarDepositRequestDto.fromJson(json);
}

/// @nodoc
mixin _$InitiateStellarDepositRequestDto {
  String get signedTx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InitiateStellarDepositRequestDtoCopyWith<InitiateStellarDepositRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitiateStellarDepositRequestDtoCopyWith<$Res> {
  factory $InitiateStellarDepositRequestDtoCopyWith(
          InitiateStellarDepositRequestDto value,
          $Res Function(InitiateStellarDepositRequestDto) then) =
      _$InitiateStellarDepositRequestDtoCopyWithImpl<$Res,
          InitiateStellarDepositRequestDto>;
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class _$InitiateStellarDepositRequestDtoCopyWithImpl<$Res,
        $Val extends InitiateStellarDepositRequestDto>
    implements $InitiateStellarDepositRequestDtoCopyWith<$Res> {
  _$InitiateStellarDepositRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_value.copyWith(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitiateStellarDepositRequestDtoImplCopyWith<$Res>
    implements $InitiateStellarDepositRequestDtoCopyWith<$Res> {
  factory _$$InitiateStellarDepositRequestDtoImplCopyWith(
          _$InitiateStellarDepositRequestDtoImpl value,
          $Res Function(_$InitiateStellarDepositRequestDtoImpl) then) =
      __$$InitiateStellarDepositRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class __$$InitiateStellarDepositRequestDtoImplCopyWithImpl<$Res>
    extends _$InitiateStellarDepositRequestDtoCopyWithImpl<$Res,
        _$InitiateStellarDepositRequestDtoImpl>
    implements _$$InitiateStellarDepositRequestDtoImplCopyWith<$Res> {
  __$$InitiateStellarDepositRequestDtoImplCopyWithImpl(
      _$InitiateStellarDepositRequestDtoImpl _value,
      $Res Function(_$InitiateStellarDepositRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_$InitiateStellarDepositRequestDtoImpl(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InitiateStellarDepositRequestDtoImpl
    implements _InitiateStellarDepositRequestDto {
  const _$InitiateStellarDepositRequestDtoImpl({required this.signedTx});

  factory _$InitiateStellarDepositRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InitiateStellarDepositRequestDtoImplFromJson(json);

  @override
  final String signedTx;

  @override
  String toString() {
    return 'InitiateStellarDepositRequestDto(signedTx: $signedTx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateStellarDepositRequestDtoImpl &&
            (identical(other.signedTx, signedTx) ||
                other.signedTx == signedTx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedTx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateStellarDepositRequestDtoImplCopyWith<
          _$InitiateStellarDepositRequestDtoImpl>
      get copyWith => __$$InitiateStellarDepositRequestDtoImplCopyWithImpl<
          _$InitiateStellarDepositRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InitiateStellarDepositRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _InitiateStellarDepositRequestDto
    implements InitiateStellarDepositRequestDto {
  const factory _InitiateStellarDepositRequestDto(
          {required final String signedTx}) =
      _$InitiateStellarDepositRequestDtoImpl;

  factory _InitiateStellarDepositRequestDto.fromJson(
          Map<String, dynamic> json) =
      _$InitiateStellarDepositRequestDtoImpl.fromJson;

  @override
  String get signedTx;
  @override
  @JsonKey(ignore: true)
  _$$InitiateStellarDepositRequestDtoImplCopyWith<
          _$InitiateStellarDepositRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InitiateStellarDepositResponseDto _$InitiateStellarDepositResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _InitiateStellarDepositResponseDto.fromJson(json);
}

/// @nodoc
mixin _$InitiateStellarDepositResponseDto {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InitiateStellarDepositResponseDtoCopyWith<InitiateStellarDepositResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitiateStellarDepositResponseDtoCopyWith<$Res> {
  factory $InitiateStellarDepositResponseDtoCopyWith(
          InitiateStellarDepositResponseDto value,
          $Res Function(InitiateStellarDepositResponseDto) then) =
      _$InitiateStellarDepositResponseDtoCopyWithImpl<$Res,
          InitiateStellarDepositResponseDto>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$InitiateStellarDepositResponseDtoCopyWithImpl<$Res,
        $Val extends InitiateStellarDepositResponseDto>
    implements $InitiateStellarDepositResponseDtoCopyWith<$Res> {
  _$InitiateStellarDepositResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitiateStellarDepositResponseDtoImplCopyWith<$Res>
    implements $InitiateStellarDepositResponseDtoCopyWith<$Res> {
  factory _$$InitiateStellarDepositResponseDtoImplCopyWith(
          _$InitiateStellarDepositResponseDtoImpl value,
          $Res Function(_$InitiateStellarDepositResponseDtoImpl) then) =
      __$$InitiateStellarDepositResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$InitiateStellarDepositResponseDtoImplCopyWithImpl<$Res>
    extends _$InitiateStellarDepositResponseDtoCopyWithImpl<$Res,
        _$InitiateStellarDepositResponseDtoImpl>
    implements _$$InitiateStellarDepositResponseDtoImplCopyWith<$Res> {
  __$$InitiateStellarDepositResponseDtoImplCopyWithImpl(
      _$InitiateStellarDepositResponseDtoImpl _value,
      $Res Function(_$InitiateStellarDepositResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$InitiateStellarDepositResponseDtoImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InitiateStellarDepositResponseDtoImpl
    implements _InitiateStellarDepositResponseDto {
  const _$InitiateStellarDepositResponseDtoImpl({required this.url});

  factory _$InitiateStellarDepositResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InitiateStellarDepositResponseDtoImplFromJson(json);

  @override
  final String url;

  @override
  String toString() {
    return 'InitiateStellarDepositResponseDto(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateStellarDepositResponseDtoImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateStellarDepositResponseDtoImplCopyWith<
          _$InitiateStellarDepositResponseDtoImpl>
      get copyWith => __$$InitiateStellarDepositResponseDtoImplCopyWithImpl<
          _$InitiateStellarDepositResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InitiateStellarDepositResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _InitiateStellarDepositResponseDto
    implements InitiateStellarDepositResponseDto {
  const factory _InitiateStellarDepositResponseDto(
      {required final String url}) = _$InitiateStellarDepositResponseDtoImpl;

  factory _InitiateStellarDepositResponseDto.fromJson(
          Map<String, dynamic> json) =
      _$InitiateStellarDepositResponseDtoImpl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$InitiateStellarDepositResponseDtoImplCopyWith<
          _$InitiateStellarDepositResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
