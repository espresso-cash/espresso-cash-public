// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scalex.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GenerateScalexLinkResponseDto _$GenerateScalexLinkResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateScalexLinkResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateScalexLinkResponseDto {
  String get signedUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateScalexLinkResponseDtoCopyWith<GenerateScalexLinkResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateScalexLinkResponseDtoCopyWith<$Res> {
  factory $GenerateScalexLinkResponseDtoCopyWith(
          GenerateScalexLinkResponseDto value,
          $Res Function(GenerateScalexLinkResponseDto) then) =
      _$GenerateScalexLinkResponseDtoCopyWithImpl<$Res,
          GenerateScalexLinkResponseDto>;
  @useResult
  $Res call({String signedUrl});
}

/// @nodoc
class _$GenerateScalexLinkResponseDtoCopyWithImpl<$Res,
        $Val extends GenerateScalexLinkResponseDto>
    implements $GenerateScalexLinkResponseDtoCopyWith<$Res> {
  _$GenerateScalexLinkResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedUrl = null,
  }) {
    return _then(_value.copyWith(
      signedUrl: null == signedUrl
          ? _value.signedUrl
          : signedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateScalexLinkResponseDtoImplCopyWith<$Res>
    implements $GenerateScalexLinkResponseDtoCopyWith<$Res> {
  factory _$$GenerateScalexLinkResponseDtoImplCopyWith(
          _$GenerateScalexLinkResponseDtoImpl value,
          $Res Function(_$GenerateScalexLinkResponseDtoImpl) then) =
      __$$GenerateScalexLinkResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedUrl});
}

/// @nodoc
class __$$GenerateScalexLinkResponseDtoImplCopyWithImpl<$Res>
    extends _$GenerateScalexLinkResponseDtoCopyWithImpl<$Res,
        _$GenerateScalexLinkResponseDtoImpl>
    implements _$$GenerateScalexLinkResponseDtoImplCopyWith<$Res> {
  __$$GenerateScalexLinkResponseDtoImplCopyWithImpl(
      _$GenerateScalexLinkResponseDtoImpl _value,
      $Res Function(_$GenerateScalexLinkResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedUrl = null,
  }) {
    return _then(_$GenerateScalexLinkResponseDtoImpl(
      signedUrl: null == signedUrl
          ? _value.signedUrl
          : signedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateScalexLinkResponseDtoImpl
    implements _GenerateScalexLinkResponseDto {
  const _$GenerateScalexLinkResponseDtoImpl({required this.signedUrl});

  factory _$GenerateScalexLinkResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GenerateScalexLinkResponseDtoImplFromJson(json);

  @override
  final String signedUrl;

  @override
  String toString() {
    return 'GenerateScalexLinkResponseDto(signedUrl: $signedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateScalexLinkResponseDtoImpl &&
            (identical(other.signedUrl, signedUrl) ||
                other.signedUrl == signedUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateScalexLinkResponseDtoImplCopyWith<
          _$GenerateScalexLinkResponseDtoImpl>
      get copyWith => __$$GenerateScalexLinkResponseDtoImplCopyWithImpl<
          _$GenerateScalexLinkResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateScalexLinkResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GenerateScalexLinkResponseDto
    implements GenerateScalexLinkResponseDto {
  const factory _GenerateScalexLinkResponseDto(
      {required final String signedUrl}) = _$GenerateScalexLinkResponseDtoImpl;

  factory _GenerateScalexLinkResponseDto.fromJson(Map<String, dynamic> json) =
      _$GenerateScalexLinkResponseDtoImpl.fromJson;

  @override
  String get signedUrl;
  @override
  @JsonKey(ignore: true)
  _$$GenerateScalexLinkResponseDtoImplCopyWith<
          _$GenerateScalexLinkResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GenerateScalexLinkRequestDto _$GenerateScalexLinkRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _GenerateScalexLinkRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GenerateScalexLinkRequestDto {
  String get type => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenerateScalexLinkRequestDtoCopyWith<GenerateScalexLinkRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateScalexLinkRequestDtoCopyWith<$Res> {
  factory $GenerateScalexLinkRequestDtoCopyWith(
          GenerateScalexLinkRequestDto value,
          $Res Function(GenerateScalexLinkRequestDto) then) =
      _$GenerateScalexLinkRequestDtoCopyWithImpl<$Res,
          GenerateScalexLinkRequestDto>;
  @useResult
  $Res call({String type, String address, String email});
}

/// @nodoc
class _$GenerateScalexLinkRequestDtoCopyWithImpl<$Res,
        $Val extends GenerateScalexLinkRequestDto>
    implements $GenerateScalexLinkRequestDtoCopyWith<$Res> {
  _$GenerateScalexLinkRequestDtoCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerateScalexLinkRequestDtoImplCopyWith<$Res>
    implements $GenerateScalexLinkRequestDtoCopyWith<$Res> {
  factory _$$GenerateScalexLinkRequestDtoImplCopyWith(
          _$GenerateScalexLinkRequestDtoImpl value,
          $Res Function(_$GenerateScalexLinkRequestDtoImpl) then) =
      __$$GenerateScalexLinkRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String address, String email});
}

/// @nodoc
class __$$GenerateScalexLinkRequestDtoImplCopyWithImpl<$Res>
    extends _$GenerateScalexLinkRequestDtoCopyWithImpl<$Res,
        _$GenerateScalexLinkRequestDtoImpl>
    implements _$$GenerateScalexLinkRequestDtoImplCopyWith<$Res> {
  __$$GenerateScalexLinkRequestDtoImplCopyWithImpl(
      _$GenerateScalexLinkRequestDtoImpl _value,
      $Res Function(_$GenerateScalexLinkRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? address = null,
    Object? email = null,
  }) {
    return _then(_$GenerateScalexLinkRequestDtoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateScalexLinkRequestDtoImpl
    implements _GenerateScalexLinkRequestDto {
  const _$GenerateScalexLinkRequestDtoImpl(
      {required this.type, required this.address, required this.email});

  factory _$GenerateScalexLinkRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GenerateScalexLinkRequestDtoImplFromJson(json);

  @override
  final String type;
  @override
  final String address;
  @override
  final String email;

  @override
  String toString() {
    return 'GenerateScalexLinkRequestDto(type: $type, address: $address, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateScalexLinkRequestDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, address, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateScalexLinkRequestDtoImplCopyWith<
          _$GenerateScalexLinkRequestDtoImpl>
      get copyWith => __$$GenerateScalexLinkRequestDtoImplCopyWithImpl<
          _$GenerateScalexLinkRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateScalexLinkRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _GenerateScalexLinkRequestDto
    implements GenerateScalexLinkRequestDto {
  const factory _GenerateScalexLinkRequestDto(
      {required final String type,
      required final String address,
      required final String email}) = _$GenerateScalexLinkRequestDtoImpl;

  factory _GenerateScalexLinkRequestDto.fromJson(Map<String, dynamic> json) =
      _$GenerateScalexLinkRequestDtoImpl.fromJson;

  @override
  String get type;
  @override
  String get address;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$GenerateScalexLinkRequestDtoImplCopyWith<
          _$GenerateScalexLinkRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderStatusScalexRequestDto _$OrderStatusScalexRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusScalexRequestDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusScalexRequestDto {
  String get referenceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusScalexRequestDtoCopyWith<OrderStatusScalexRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusScalexRequestDtoCopyWith<$Res> {
  factory $OrderStatusScalexRequestDtoCopyWith(
          OrderStatusScalexRequestDto value,
          $Res Function(OrderStatusScalexRequestDto) then) =
      _$OrderStatusScalexRequestDtoCopyWithImpl<$Res,
          OrderStatusScalexRequestDto>;
  @useResult
  $Res call({String referenceId});
}

/// @nodoc
class _$OrderStatusScalexRequestDtoCopyWithImpl<$Res,
        $Val extends OrderStatusScalexRequestDto>
    implements $OrderStatusScalexRequestDtoCopyWith<$Res> {
  _$OrderStatusScalexRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceId = null,
  }) {
    return _then(_value.copyWith(
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusScalexRequestDtoImplCopyWith<$Res>
    implements $OrderStatusScalexRequestDtoCopyWith<$Res> {
  factory _$$OrderStatusScalexRequestDtoImplCopyWith(
          _$OrderStatusScalexRequestDtoImpl value,
          $Res Function(_$OrderStatusScalexRequestDtoImpl) then) =
      __$$OrderStatusScalexRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String referenceId});
}

/// @nodoc
class __$$OrderStatusScalexRequestDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusScalexRequestDtoCopyWithImpl<$Res,
        _$OrderStatusScalexRequestDtoImpl>
    implements _$$OrderStatusScalexRequestDtoImplCopyWith<$Res> {
  __$$OrderStatusScalexRequestDtoImplCopyWithImpl(
      _$OrderStatusScalexRequestDtoImpl _value,
      $Res Function(_$OrderStatusScalexRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceId = null,
  }) {
    return _then(_$OrderStatusScalexRequestDtoImpl(
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusScalexRequestDtoImpl
    implements _OrderStatusScalexRequestDto {
  const _$OrderStatusScalexRequestDtoImpl({required this.referenceId});

  factory _$OrderStatusScalexRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OrderStatusScalexRequestDtoImplFromJson(json);

  @override
  final String referenceId;

  @override
  String toString() {
    return 'OrderStatusScalexRequestDto(referenceId: $referenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusScalexRequestDtoImpl &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, referenceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusScalexRequestDtoImplCopyWith<_$OrderStatusScalexRequestDtoImpl>
      get copyWith => __$$OrderStatusScalexRequestDtoImplCopyWithImpl<
          _$OrderStatusScalexRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusScalexRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusScalexRequestDto
    implements OrderStatusScalexRequestDto {
  const factory _OrderStatusScalexRequestDto(
      {required final String referenceId}) = _$OrderStatusScalexRequestDtoImpl;

  factory _OrderStatusScalexRequestDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusScalexRequestDtoImpl.fromJson;

  @override
  String get referenceId;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusScalexRequestDtoImplCopyWith<_$OrderStatusScalexRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderStatusScalexResponseDto _$OrderStatusScalexResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusScalexResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusScalexResponseDto {
  @JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
  ScalexOrderStatus get status => throw _privateConstructorUsedError;
  OnRampScalexDetails? get onRampDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusScalexResponseDtoCopyWith<OrderStatusScalexResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusScalexResponseDtoCopyWith<$Res> {
  factory $OrderStatusScalexResponseDtoCopyWith(
          OrderStatusScalexResponseDto value,
          $Res Function(OrderStatusScalexResponseDto) then) =
      _$OrderStatusScalexResponseDtoCopyWithImpl<$Res,
          OrderStatusScalexResponseDto>;
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
      ScalexOrderStatus status,
      OnRampScalexDetails? onRampDetails});

  $OnRampScalexDetailsCopyWith<$Res>? get onRampDetails;
}

/// @nodoc
class _$OrderStatusScalexResponseDtoCopyWithImpl<$Res,
        $Val extends OrderStatusScalexResponseDto>
    implements $OrderStatusScalexResponseDtoCopyWith<$Res> {
  _$OrderStatusScalexResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? onRampDetails = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScalexOrderStatus,
      onRampDetails: freezed == onRampDetails
          ? _value.onRampDetails
          : onRampDetails // ignore: cast_nullable_to_non_nullable
              as OnRampScalexDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OnRampScalexDetailsCopyWith<$Res>? get onRampDetails {
    if (_value.onRampDetails == null) {
      return null;
    }

    return $OnRampScalexDetailsCopyWith<$Res>(_value.onRampDetails!, (value) {
      return _then(_value.copyWith(onRampDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderStatusScalexResponseDtoImplCopyWith<$Res>
    implements $OrderStatusScalexResponseDtoCopyWith<$Res> {
  factory _$$OrderStatusScalexResponseDtoImplCopyWith(
          _$OrderStatusScalexResponseDtoImpl value,
          $Res Function(_$OrderStatusScalexResponseDtoImpl) then) =
      __$$OrderStatusScalexResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
      ScalexOrderStatus status,
      OnRampScalexDetails? onRampDetails});

  @override
  $OnRampScalexDetailsCopyWith<$Res>? get onRampDetails;
}

/// @nodoc
class __$$OrderStatusScalexResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusScalexResponseDtoCopyWithImpl<$Res,
        _$OrderStatusScalexResponseDtoImpl>
    implements _$$OrderStatusScalexResponseDtoImplCopyWith<$Res> {
  __$$OrderStatusScalexResponseDtoImplCopyWithImpl(
      _$OrderStatusScalexResponseDtoImpl _value,
      $Res Function(_$OrderStatusScalexResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? onRampDetails = freezed,
  }) {
    return _then(_$OrderStatusScalexResponseDtoImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScalexOrderStatus,
      onRampDetails: freezed == onRampDetails
          ? _value.onRampDetails
          : onRampDetails // ignore: cast_nullable_to_non_nullable
              as OnRampScalexDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusScalexResponseDtoImpl
    implements _OrderStatusScalexResponseDto {
  const _$OrderStatusScalexResponseDtoImpl(
      {@JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
      required this.status,
      this.onRampDetails});

  factory _$OrderStatusScalexResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OrderStatusScalexResponseDtoImplFromJson(json);

  @override
  @JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
  final ScalexOrderStatus status;
  @override
  final OnRampScalexDetails? onRampDetails;

  @override
  String toString() {
    return 'OrderStatusScalexResponseDto(status: $status, onRampDetails: $onRampDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusScalexResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.onRampDetails, onRampDetails) ||
                other.onRampDetails == onRampDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, onRampDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusScalexResponseDtoImplCopyWith<
          _$OrderStatusScalexResponseDtoImpl>
      get copyWith => __$$OrderStatusScalexResponseDtoImplCopyWithImpl<
          _$OrderStatusScalexResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusScalexResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusScalexResponseDto
    implements OrderStatusScalexResponseDto {
  const factory _OrderStatusScalexResponseDto(
          {@JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
          required final ScalexOrderStatus status,
          final OnRampScalexDetails? onRampDetails}) =
      _$OrderStatusScalexResponseDtoImpl;

  factory _OrderStatusScalexResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusScalexResponseDtoImpl.fromJson;

  @override
  @JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
  ScalexOrderStatus get status;
  @override
  OnRampScalexDetails? get onRampDetails;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusScalexResponseDtoImplCopyWith<
          _$OrderStatusScalexResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnRampScalexDetails _$OnRampScalexDetailsFromJson(Map<String, dynamic> json) {
  return _OnRampScalexDetails.fromJson(json);
}

/// @nodoc
mixin _$OnRampScalexDetails {
  String get currency => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String get bankAccount => throw _privateConstructorUsedError;
  num get fromAmount => throw _privateConstructorUsedError;
  String get fiatCurrency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnRampScalexDetailsCopyWith<OnRampScalexDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnRampScalexDetailsCopyWith<$Res> {
  factory $OnRampScalexDetailsCopyWith(
          OnRampScalexDetails value, $Res Function(OnRampScalexDetails) then) =
      _$OnRampScalexDetailsCopyWithImpl<$Res, OnRampScalexDetails>;
  @useResult
  $Res call(
      {String currency,
      String bankName,
      String bankAccount,
      num fromAmount,
      String fiatCurrency});
}

/// @nodoc
class _$OnRampScalexDetailsCopyWithImpl<$Res, $Val extends OnRampScalexDetails>
    implements $OnRampScalexDetailsCopyWith<$Res> {
  _$OnRampScalexDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? bankName = null,
    Object? bankAccount = null,
    Object? fromAmount = null,
    Object? fiatCurrency = null,
  }) {
    return _then(_value.copyWith(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      bankAccount: null == bankAccount
          ? _value.bankAccount
          : bankAccount // ignore: cast_nullable_to_non_nullable
              as String,
      fromAmount: null == fromAmount
          ? _value.fromAmount
          : fromAmount // ignore: cast_nullable_to_non_nullable
              as num,
      fiatCurrency: null == fiatCurrency
          ? _value.fiatCurrency
          : fiatCurrency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnRampScalexDetailsImplCopyWith<$Res>
    implements $OnRampScalexDetailsCopyWith<$Res> {
  factory _$$OnRampScalexDetailsImplCopyWith(_$OnRampScalexDetailsImpl value,
          $Res Function(_$OnRampScalexDetailsImpl) then) =
      __$$OnRampScalexDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currency,
      String bankName,
      String bankAccount,
      num fromAmount,
      String fiatCurrency});
}

/// @nodoc
class __$$OnRampScalexDetailsImplCopyWithImpl<$Res>
    extends _$OnRampScalexDetailsCopyWithImpl<$Res, _$OnRampScalexDetailsImpl>
    implements _$$OnRampScalexDetailsImplCopyWith<$Res> {
  __$$OnRampScalexDetailsImplCopyWithImpl(_$OnRampScalexDetailsImpl _value,
      $Res Function(_$OnRampScalexDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? bankName = null,
    Object? bankAccount = null,
    Object? fromAmount = null,
    Object? fiatCurrency = null,
  }) {
    return _then(_$OnRampScalexDetailsImpl(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      bankAccount: null == bankAccount
          ? _value.bankAccount
          : bankAccount // ignore: cast_nullable_to_non_nullable
              as String,
      fromAmount: null == fromAmount
          ? _value.fromAmount
          : fromAmount // ignore: cast_nullable_to_non_nullable
              as num,
      fiatCurrency: null == fiatCurrency
          ? _value.fiatCurrency
          : fiatCurrency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnRampScalexDetailsImpl implements _OnRampScalexDetails {
  const _$OnRampScalexDetailsImpl(
      {required this.currency,
      required this.bankName,
      required this.bankAccount,
      required this.fromAmount,
      required this.fiatCurrency});

  factory _$OnRampScalexDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnRampScalexDetailsImplFromJson(json);

  @override
  final String currency;
  @override
  final String bankName;
  @override
  final String bankAccount;
  @override
  final num fromAmount;
  @override
  final String fiatCurrency;

  @override
  String toString() {
    return 'OnRampScalexDetails(currency: $currency, bankName: $bankName, bankAccount: $bankAccount, fromAmount: $fromAmount, fiatCurrency: $fiatCurrency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnRampScalexDetailsImpl &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.bankAccount, bankAccount) ||
                other.bankAccount == bankAccount) &&
            (identical(other.fromAmount, fromAmount) ||
                other.fromAmount == fromAmount) &&
            (identical(other.fiatCurrency, fiatCurrency) ||
                other.fiatCurrency == fiatCurrency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, currency, bankName, bankAccount, fromAmount, fiatCurrency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnRampScalexDetailsImplCopyWith<_$OnRampScalexDetailsImpl> get copyWith =>
      __$$OnRampScalexDetailsImplCopyWithImpl<_$OnRampScalexDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnRampScalexDetailsImplToJson(
      this,
    );
  }
}

abstract class _OnRampScalexDetails implements OnRampScalexDetails {
  const factory _OnRampScalexDetails(
      {required final String currency,
      required final String bankName,
      required final String bankAccount,
      required final num fromAmount,
      required final String fiatCurrency}) = _$OnRampScalexDetailsImpl;

  factory _OnRampScalexDetails.fromJson(Map<String, dynamic> json) =
      _$OnRampScalexDetailsImpl.fromJson;

  @override
  String get currency;
  @override
  String get bankName;
  @override
  String get bankAccount;
  @override
  num get fromAmount;
  @override
  String get fiatCurrency;
  @override
  @JsonKey(ignore: true)
  _$$OnRampScalexDetailsImplCopyWith<_$OnRampScalexDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
