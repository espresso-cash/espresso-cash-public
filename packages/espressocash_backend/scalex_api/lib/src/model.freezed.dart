// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GenerateIFrameBodyDto _$GenerateIFrameBodyDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateIFrameBodyDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateIFrameBodyDto {
  String get type => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get network => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateIFrameBodyDtoCopyWith<GenerateIFrameBodyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateIFrameBodyDtoCopyWith<$Res> {
  factory $GenerateIFrameBodyDtoCopyWith(GenerateIFrameBodyDto value,
          $Res Function(GenerateIFrameBodyDto) then) =
      _$GenerateIFrameBodyDtoCopyWithImpl<$Res, GenerateIFrameBodyDto>;
  @useResult
  $Res call(
      {String type,
      String address,
      String email,
      String token,
      String network});
}

/// @nodoc
class _$GenerateIFrameBodyDtoCopyWithImpl<$Res,
        $Val extends GenerateIFrameBodyDto>
    implements $GenerateIFrameBodyDtoCopyWith<$Res> {
  _$GenerateIFrameBodyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? address = null,
    Object? email = null,
    Object? token = null,
    Object? network = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateIFrameBodyDtoImplCopyWith<$Res>
    implements $GenerateIFrameBodyDtoCopyWith<$Res> {
  factory _$$GenerateIFrameBodyDtoImplCopyWith(
          _$GenerateIFrameBodyDtoImpl value,
          $Res Function(_$GenerateIFrameBodyDtoImpl) then) =
      __$$GenerateIFrameBodyDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String address,
      String email,
      String token,
      String network});
}

/// @nodoc
class __$$GenerateIFrameBodyDtoImplCopyWithImpl<$Res>
    extends _$GenerateIFrameBodyDtoCopyWithImpl<$Res,
        _$GenerateIFrameBodyDtoImpl>
    implements _$$GenerateIFrameBodyDtoImplCopyWith<$Res> {
  __$$GenerateIFrameBodyDtoImplCopyWithImpl(_$GenerateIFrameBodyDtoImpl _value,
      $Res Function(_$GenerateIFrameBodyDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? address = null,
    Object? email = null,
    Object? token = null,
    Object? network = null,
  }) {
    return _then(_$GenerateIFrameBodyDtoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateIFrameBodyDtoImpl implements _GenerateIFrameBodyDto {
  const _$GenerateIFrameBodyDtoImpl(
      {required this.type,
      required this.address,
      required this.email,
      required this.token,
      required this.network});

  factory _$GenerateIFrameBodyDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateIFrameBodyDtoImplFromJson(json);

  @override
  final String type;
  @override
  final String address;
  @override
  final String email;
  @override
  final String token;
  @override
  final String network;

  @override
  String toString() {
    return 'GenerateIFrameBodyDto(type: $type, address: $address, email: $email, token: $token, network: $network)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateIFrameBodyDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.network, network) || other.network == network));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, address, email, token, network);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateIFrameBodyDtoImplCopyWith<_$GenerateIFrameBodyDtoImpl>
      get copyWith => __$$GenerateIFrameBodyDtoImplCopyWithImpl<
          _$GenerateIFrameBodyDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateIFrameBodyDtoImplToJson(
      this,
    );
  }
}

abstract class _GenerateIFrameBodyDto implements GenerateIFrameBodyDto {
  const factory _GenerateIFrameBodyDto(
      {required final String type,
      required final String address,
      required final String email,
      required final String token,
      required final String network}) = _$GenerateIFrameBodyDtoImpl;

  factory _GenerateIFrameBodyDto.fromJson(Map<String, dynamic> json) =
      _$GenerateIFrameBodyDtoImpl.fromJson;

  @override
  String get type;
  @override
  String get address;
  @override
  String get email;
  @override
  String get token;
  @override
  String get network;
  @override
  @JsonKey(ignore: true)
  _$$GenerateIFrameBodyDtoImplCopyWith<_$GenerateIFrameBodyDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ScalexResponseDto<T> _$ScalexResponseDtoFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ScalexResponseDto<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ScalexResponseDto<T> {
  T get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScalexResponseDtoCopyWith<T, ScalexResponseDto<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScalexResponseDtoCopyWith<T, $Res> {
  factory $ScalexResponseDtoCopyWith(ScalexResponseDto<T> value,
          $Res Function(ScalexResponseDto<T>) then) =
      _$ScalexResponseDtoCopyWithImpl<T, $Res, ScalexResponseDto<T>>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$ScalexResponseDtoCopyWithImpl<T, $Res,
        $Val extends ScalexResponseDto<T>>
    implements $ScalexResponseDtoCopyWith<T, $Res> {
  _$ScalexResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScalexResponseDtoImplCopyWith<T, $Res>
    implements $ScalexResponseDtoCopyWith<T, $Res> {
  factory _$$ScalexResponseDtoImplCopyWith(_$ScalexResponseDtoImpl<T> value,
          $Res Function(_$ScalexResponseDtoImpl<T>) then) =
      __$$ScalexResponseDtoImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ScalexResponseDtoImplCopyWithImpl<T, $Res>
    extends _$ScalexResponseDtoCopyWithImpl<T, $Res, _$ScalexResponseDtoImpl<T>>
    implements _$$ScalexResponseDtoImplCopyWith<T, $Res> {
  __$$ScalexResponseDtoImplCopyWithImpl(_$ScalexResponseDtoImpl<T> _value,
      $Res Function(_$ScalexResponseDtoImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ScalexResponseDtoImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class _$ScalexResponseDtoImpl<T> implements _ScalexResponseDto<T> {
  const _$ScalexResponseDtoImpl({required this.data});

  factory _$ScalexResponseDtoImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ScalexResponseDtoImplFromJson(json, fromJsonT);

  @override
  final T data;

  @override
  String toString() {
    return 'ScalexResponseDto<$T>(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScalexResponseDtoImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScalexResponseDtoImplCopyWith<T, _$ScalexResponseDtoImpl<T>>
      get copyWith =>
          __$$ScalexResponseDtoImplCopyWithImpl<T, _$ScalexResponseDtoImpl<T>>(
              this, _$identity);
}

abstract class _ScalexResponseDto<T> implements ScalexResponseDto<T> {
  const factory _ScalexResponseDto({required final T data}) =
      _$ScalexResponseDtoImpl<T>;

  factory _ScalexResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ScalexResponseDtoImpl<T>.fromJson;

  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$ScalexResponseDtoImplCopyWith<T, _$ScalexResponseDtoImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

GenerateIFrameDto _$GenerateIFrameDtoFromJson(Map<String, dynamic> json) {
  return _GenerateIFrameResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateIFrameDto {
  String get link => throw _privateConstructorUsedError;
  String get environment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateIFrameDtoCopyWith<GenerateIFrameDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateIFrameDtoCopyWith<$Res> {
  factory $GenerateIFrameDtoCopyWith(
          GenerateIFrameDto value, $Res Function(GenerateIFrameDto) then) =
      _$GenerateIFrameDtoCopyWithImpl<$Res, GenerateIFrameDto>;
  @useResult
  $Res call({String link, String environment});
}

/// @nodoc
class _$GenerateIFrameDtoCopyWithImpl<$Res, $Val extends GenerateIFrameDto>
    implements $GenerateIFrameDtoCopyWith<$Res> {
  _$GenerateIFrameDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? environment = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateIFrameResponseDtoImplCopyWith<$Res>
    implements $GenerateIFrameDtoCopyWith<$Res> {
  factory _$$GenerateIFrameResponseDtoImplCopyWith(
          _$GenerateIFrameResponseDtoImpl value,
          $Res Function(_$GenerateIFrameResponseDtoImpl) then) =
      __$$GenerateIFrameResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, String environment});
}

/// @nodoc
class __$$GenerateIFrameResponseDtoImplCopyWithImpl<$Res>
    extends _$GenerateIFrameDtoCopyWithImpl<$Res,
        _$GenerateIFrameResponseDtoImpl>
    implements _$$GenerateIFrameResponseDtoImplCopyWith<$Res> {
  __$$GenerateIFrameResponseDtoImplCopyWithImpl(
      _$GenerateIFrameResponseDtoImpl _value,
      $Res Function(_$GenerateIFrameResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? environment = null,
  }) {
    return _then(_$GenerateIFrameResponseDtoImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateIFrameResponseDtoImpl implements _GenerateIFrameResponseDto {
  const _$GenerateIFrameResponseDtoImpl(
      {required this.link, required this.environment});

  factory _$GenerateIFrameResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateIFrameResponseDtoImplFromJson(json);

  @override
  final String link;
  @override
  final String environment;

  @override
  String toString() {
    return 'GenerateIFrameDto(link: $link, environment: $environment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateIFrameResponseDtoImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.environment, environment) ||
                other.environment == environment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, link, environment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateIFrameResponseDtoImplCopyWith<_$GenerateIFrameResponseDtoImpl>
      get copyWith => __$$GenerateIFrameResponseDtoImplCopyWithImpl<
          _$GenerateIFrameResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateIFrameResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GenerateIFrameResponseDto implements GenerateIFrameDto {
  const factory _GenerateIFrameResponseDto(
      {required final String link,
      required final String environment}) = _$GenerateIFrameResponseDtoImpl;

  factory _GenerateIFrameResponseDto.fromJson(Map<String, dynamic> json) =
      _$GenerateIFrameResponseDtoImpl.fromJson;

  @override
  String get link;
  @override
  String get environment;
  @override
  @JsonKey(ignore: true)
  _$$GenerateIFrameResponseDtoImplCopyWith<_$GenerateIFrameResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) {
  return _TransactionDto.fromJson(json);
}

/// @nodoc
mixin _$TransactionDto {
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  OrderStatus get status => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionDtoCopyWith<TransactionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDtoCopyWith<$Res> {
  factory $TransactionDtoCopyWith(
          TransactionDto value, $Res Function(TransactionDto) then) =
      _$TransactionDtoCopyWithImpl<$Res, TransactionDto>;
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status,
      String type});
}

/// @nodoc
class _$TransactionDtoCopyWithImpl<$Res, $Val extends TransactionDto>
    implements $TransactionDtoCopyWith<$Res> {
  _$TransactionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionDtoImplCopyWith<$Res>
    implements $TransactionDtoCopyWith<$Res> {
  factory _$$TransactionDtoImplCopyWith(_$TransactionDtoImpl value,
          $Res Function(_$TransactionDtoImpl) then) =
      __$$TransactionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status,
      String type});
}

/// @nodoc
class __$$TransactionDtoImplCopyWithImpl<$Res>
    extends _$TransactionDtoCopyWithImpl<$Res, _$TransactionDtoImpl>
    implements _$$TransactionDtoImplCopyWith<$Res> {
  __$$TransactionDtoImplCopyWithImpl(
      _$TransactionDtoImpl _value, $Res Function(_$TransactionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_$TransactionDtoImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TransactionDtoImpl implements _TransactionDto {
  const _$TransactionDtoImpl(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown) required this.status,
      required this.type});

  factory _$TransactionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionDtoImplFromJson(json);

  @override
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  final OrderStatus status;
  @override
  final String type;

  @override
  String toString() {
    return 'TransactionDto(status: $status, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDtoImplCopyWith<_$TransactionDtoImpl> get copyWith =>
      __$$TransactionDtoImplCopyWithImpl<_$TransactionDtoImpl>(
          this, _$identity);
}

abstract class _TransactionDto implements TransactionDto {
  const factory _TransactionDto(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown)
      required final OrderStatus status,
      required final String type}) = _$TransactionDtoImpl;

  factory _TransactionDto.fromJson(Map<String, dynamic> json) =
      _$TransactionDtoImpl.fromJson;

  @override
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  OrderStatus get status;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$TransactionDtoImplCopyWith<_$TransactionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
