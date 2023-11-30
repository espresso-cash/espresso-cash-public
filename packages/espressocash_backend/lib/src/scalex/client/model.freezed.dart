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
abstract class _$$_GenerateIFrameBodyDtoCopyWith<$Res>
    implements $GenerateIFrameBodyDtoCopyWith<$Res> {
  factory _$$_GenerateIFrameBodyDtoCopyWith(_$_GenerateIFrameBodyDto value,
          $Res Function(_$_GenerateIFrameBodyDto) then) =
      __$$_GenerateIFrameBodyDtoCopyWithImpl<$Res>;
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
class __$$_GenerateIFrameBodyDtoCopyWithImpl<$Res>
    extends _$GenerateIFrameBodyDtoCopyWithImpl<$Res, _$_GenerateIFrameBodyDto>
    implements _$$_GenerateIFrameBodyDtoCopyWith<$Res> {
  __$$_GenerateIFrameBodyDtoCopyWithImpl(_$_GenerateIFrameBodyDto _value,
      $Res Function(_$_GenerateIFrameBodyDto) _then)
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
    return _then(_$_GenerateIFrameBodyDto(
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
class _$_GenerateIFrameBodyDto implements _GenerateIFrameBodyDto {
  const _$_GenerateIFrameBodyDto(
      {required this.type,
      required this.address,
      required this.email,
      required this.token,
      required this.network});

  factory _$_GenerateIFrameBodyDto.fromJson(Map<String, dynamic> json) =>
      _$$_GenerateIFrameBodyDtoFromJson(json);

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
            other is _$_GenerateIFrameBodyDto &&
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
  _$$_GenerateIFrameBodyDtoCopyWith<_$_GenerateIFrameBodyDto> get copyWith =>
      __$$_GenerateIFrameBodyDtoCopyWithImpl<_$_GenerateIFrameBodyDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateIFrameBodyDtoToJson(
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
      required final String network}) = _$_GenerateIFrameBodyDto;

  factory _GenerateIFrameBodyDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateIFrameBodyDto.fromJson;

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
  _$$_GenerateIFrameBodyDtoCopyWith<_$_GenerateIFrameBodyDto> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$_ScalexResponseDtoCopyWith<T, $Res>
    implements $ScalexResponseDtoCopyWith<T, $Res> {
  factory _$$_ScalexResponseDtoCopyWith(_$_ScalexResponseDto<T> value,
          $Res Function(_$_ScalexResponseDto<T>) then) =
      __$$_ScalexResponseDtoCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_ScalexResponseDtoCopyWithImpl<T, $Res>
    extends _$ScalexResponseDtoCopyWithImpl<T, $Res, _$_ScalexResponseDto<T>>
    implements _$$_ScalexResponseDtoCopyWith<T, $Res> {
  __$$_ScalexResponseDtoCopyWithImpl(_$_ScalexResponseDto<T> _value,
      $Res Function(_$_ScalexResponseDto<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ScalexResponseDto<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class _$_ScalexResponseDto<T> implements _ScalexResponseDto<T> {
  const _$_ScalexResponseDto({required this.data});

  factory _$_ScalexResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$_ScalexResponseDtoFromJson(json, fromJsonT);

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
            other is _$_ScalexResponseDto<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScalexResponseDtoCopyWith<T, _$_ScalexResponseDto<T>> get copyWith =>
      __$$_ScalexResponseDtoCopyWithImpl<T, _$_ScalexResponseDto<T>>(
          this, _$identity);
}

abstract class _ScalexResponseDto<T> implements ScalexResponseDto<T> {
  const factory _ScalexResponseDto({required final T data}) =
      _$_ScalexResponseDto<T>;

  factory _ScalexResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$_ScalexResponseDto<T>.fromJson;

  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$_ScalexResponseDtoCopyWith<T, _$_ScalexResponseDto<T>> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$_GenerateIFrameResponseDtoCopyWith<$Res>
    implements $GenerateIFrameDtoCopyWith<$Res> {
  factory _$$_GenerateIFrameResponseDtoCopyWith(
          _$_GenerateIFrameResponseDto value,
          $Res Function(_$_GenerateIFrameResponseDto) then) =
      __$$_GenerateIFrameResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, String environment});
}

/// @nodoc
class __$$_GenerateIFrameResponseDtoCopyWithImpl<$Res>
    extends _$GenerateIFrameDtoCopyWithImpl<$Res, _$_GenerateIFrameResponseDto>
    implements _$$_GenerateIFrameResponseDtoCopyWith<$Res> {
  __$$_GenerateIFrameResponseDtoCopyWithImpl(
      _$_GenerateIFrameResponseDto _value,
      $Res Function(_$_GenerateIFrameResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? environment = null,
  }) {
    return _then(_$_GenerateIFrameResponseDto(
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
class _$_GenerateIFrameResponseDto implements _GenerateIFrameResponseDto {
  const _$_GenerateIFrameResponseDto(
      {required this.link, required this.environment});

  factory _$_GenerateIFrameResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_GenerateIFrameResponseDtoFromJson(json);

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
            other is _$_GenerateIFrameResponseDto &&
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
  _$$_GenerateIFrameResponseDtoCopyWith<_$_GenerateIFrameResponseDto>
      get copyWith => __$$_GenerateIFrameResponseDtoCopyWithImpl<
          _$_GenerateIFrameResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateIFrameResponseDtoToJson(
      this,
    );
  }
}

abstract class _GenerateIFrameResponseDto implements GenerateIFrameDto {
  const factory _GenerateIFrameResponseDto(
      {required final String link,
      required final String environment}) = _$_GenerateIFrameResponseDto;

  factory _GenerateIFrameResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateIFrameResponseDto.fromJson;

  @override
  String get link;
  @override
  String get environment;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateIFrameResponseDtoCopyWith<_$_GenerateIFrameResponseDto>
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
abstract class _$$_TransactionDtoCopyWith<$Res>
    implements $TransactionDtoCopyWith<$Res> {
  factory _$$_TransactionDtoCopyWith(
          _$_TransactionDto value, $Res Function(_$_TransactionDto) then) =
      __$$_TransactionDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status,
      String type});
}

/// @nodoc
class __$$_TransactionDtoCopyWithImpl<$Res>
    extends _$TransactionDtoCopyWithImpl<$Res, _$_TransactionDto>
    implements _$$_TransactionDtoCopyWith<$Res> {
  __$$_TransactionDtoCopyWithImpl(
      _$_TransactionDto _value, $Res Function(_$_TransactionDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_$_TransactionDto(
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
class _$_TransactionDto implements _TransactionDto {
  const _$_TransactionDto(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown) required this.status,
      required this.type});

  factory _$_TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionDtoFromJson(json);

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
            other is _$_TransactionDto &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionDtoCopyWith<_$_TransactionDto> get copyWith =>
      __$$_TransactionDtoCopyWithImpl<_$_TransactionDto>(this, _$identity);
}

abstract class _TransactionDto implements TransactionDto {
  const factory _TransactionDto(
      {@JsonKey(unknownEnumValue: OrderStatus.unknown)
          required final OrderStatus status,
      required final String type}) = _$_TransactionDto;

  factory _TransactionDto.fromJson(Map<String, dynamic> json) =
      _$_TransactionDto.fromJson;

  @override
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  OrderStatus get status;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionDtoCopyWith<_$_TransactionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
