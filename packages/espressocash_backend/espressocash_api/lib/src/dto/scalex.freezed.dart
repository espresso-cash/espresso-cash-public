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
abstract class _$$_GenerateScalexLinkResponseDtoCopyWith<$Res>
    implements $GenerateScalexLinkResponseDtoCopyWith<$Res> {
  factory _$$_GenerateScalexLinkResponseDtoCopyWith(
          _$_GenerateScalexLinkResponseDto value,
          $Res Function(_$_GenerateScalexLinkResponseDto) then) =
      __$$_GenerateScalexLinkResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedUrl});
}

/// @nodoc
class __$$_GenerateScalexLinkResponseDtoCopyWithImpl<$Res>
    extends _$GenerateScalexLinkResponseDtoCopyWithImpl<$Res,
        _$_GenerateScalexLinkResponseDto>
    implements _$$_GenerateScalexLinkResponseDtoCopyWith<$Res> {
  __$$_GenerateScalexLinkResponseDtoCopyWithImpl(
      _$_GenerateScalexLinkResponseDto _value,
      $Res Function(_$_GenerateScalexLinkResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedUrl = null,
  }) {
    return _then(_$_GenerateScalexLinkResponseDto(
      signedUrl: null == signedUrl
          ? _value.signedUrl
          : signedUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GenerateScalexLinkResponseDto
    implements _GenerateScalexLinkResponseDto {
  const _$_GenerateScalexLinkResponseDto({required this.signedUrl});

  factory _$_GenerateScalexLinkResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$$_GenerateScalexLinkResponseDtoFromJson(json);

  @override
  final String signedUrl;

  @override
  String toString() {
    return 'GenerateScalexLinkResponseDto(signedUrl: $signedUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateScalexLinkResponseDto &&
            (identical(other.signedUrl, signedUrl) ||
                other.signedUrl == signedUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenerateScalexLinkResponseDtoCopyWith<_$_GenerateScalexLinkResponseDto>
      get copyWith => __$$_GenerateScalexLinkResponseDtoCopyWithImpl<
          _$_GenerateScalexLinkResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateScalexLinkResponseDtoToJson(
      this,
    );
  }
}

abstract class _GenerateScalexLinkResponseDto
    implements GenerateScalexLinkResponseDto {
  const factory _GenerateScalexLinkResponseDto(
      {required final String signedUrl}) = _$_GenerateScalexLinkResponseDto;

  factory _GenerateScalexLinkResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateScalexLinkResponseDto.fromJson;

  @override
  String get signedUrl;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateScalexLinkResponseDtoCopyWith<_$_GenerateScalexLinkResponseDto>
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
abstract class _$$_GenerateScalexLinkRequestDtoCopyWith<$Res>
    implements $GenerateScalexLinkRequestDtoCopyWith<$Res> {
  factory _$$_GenerateScalexLinkRequestDtoCopyWith(
          _$_GenerateScalexLinkRequestDto value,
          $Res Function(_$_GenerateScalexLinkRequestDto) then) =
      __$$_GenerateScalexLinkRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String address, String email});
}

/// @nodoc
class __$$_GenerateScalexLinkRequestDtoCopyWithImpl<$Res>
    extends _$GenerateScalexLinkRequestDtoCopyWithImpl<$Res,
        _$_GenerateScalexLinkRequestDto>
    implements _$$_GenerateScalexLinkRequestDtoCopyWith<$Res> {
  __$$_GenerateScalexLinkRequestDtoCopyWithImpl(
      _$_GenerateScalexLinkRequestDto _value,
      $Res Function(_$_GenerateScalexLinkRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? address = null,
    Object? email = null,
  }) {
    return _then(_$_GenerateScalexLinkRequestDto(
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
class _$_GenerateScalexLinkRequestDto implements _GenerateScalexLinkRequestDto {
  const _$_GenerateScalexLinkRequestDto(
      {required this.type, required this.address, required this.email});

  factory _$_GenerateScalexLinkRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_GenerateScalexLinkRequestDtoFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerateScalexLinkRequestDto &&
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
  _$$_GenerateScalexLinkRequestDtoCopyWith<_$_GenerateScalexLinkRequestDto>
      get copyWith => __$$_GenerateScalexLinkRequestDtoCopyWithImpl<
          _$_GenerateScalexLinkRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenerateScalexLinkRequestDtoToJson(
      this,
    );
  }
}

abstract class _GenerateScalexLinkRequestDto
    implements GenerateScalexLinkRequestDto {
  const factory _GenerateScalexLinkRequestDto(
      {required final String type,
      required final String address,
      required final String email}) = _$_GenerateScalexLinkRequestDto;

  factory _GenerateScalexLinkRequestDto.fromJson(Map<String, dynamic> json) =
      _$_GenerateScalexLinkRequestDto.fromJson;

  @override
  String get type;
  @override
  String get address;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_GenerateScalexLinkRequestDtoCopyWith<_$_GenerateScalexLinkRequestDto>
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
abstract class _$$_OrderStatusScalexRequestDtoCopyWith<$Res>
    implements $OrderStatusScalexRequestDtoCopyWith<$Res> {
  factory _$$_OrderStatusScalexRequestDtoCopyWith(
          _$_OrderStatusScalexRequestDto value,
          $Res Function(_$_OrderStatusScalexRequestDto) then) =
      __$$_OrderStatusScalexRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String referenceId});
}

/// @nodoc
class __$$_OrderStatusScalexRequestDtoCopyWithImpl<$Res>
    extends _$OrderStatusScalexRequestDtoCopyWithImpl<$Res,
        _$_OrderStatusScalexRequestDto>
    implements _$$_OrderStatusScalexRequestDtoCopyWith<$Res> {
  __$$_OrderStatusScalexRequestDtoCopyWithImpl(
      _$_OrderStatusScalexRequestDto _value,
      $Res Function(_$_OrderStatusScalexRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceId = null,
  }) {
    return _then(_$_OrderStatusScalexRequestDto(
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderStatusScalexRequestDto implements _OrderStatusScalexRequestDto {
  const _$_OrderStatusScalexRequestDto({required this.referenceId});

  factory _$_OrderStatusScalexRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderStatusScalexRequestDtoFromJson(json);

  @override
  final String referenceId;

  @override
  String toString() {
    return 'OrderStatusScalexRequestDto(referenceId: $referenceId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusScalexRequestDto &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, referenceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderStatusScalexRequestDtoCopyWith<_$_OrderStatusScalexRequestDto>
      get copyWith => __$$_OrderStatusScalexRequestDtoCopyWithImpl<
          _$_OrderStatusScalexRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderStatusScalexRequestDtoToJson(
      this,
    );
  }
}

abstract class _OrderStatusScalexRequestDto
    implements OrderStatusScalexRequestDto {
  const factory _OrderStatusScalexRequestDto(
      {required final String referenceId}) = _$_OrderStatusScalexRequestDto;

  factory _OrderStatusScalexRequestDto.fromJson(Map<String, dynamic> json) =
      _$_OrderStatusScalexRequestDto.fromJson;

  @override
  String get referenceId;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusScalexRequestDtoCopyWith<_$_OrderStatusScalexRequestDto>
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
abstract class _$$_OrderStatusScalexResponseDtoCopyWith<$Res>
    implements $OrderStatusScalexResponseDtoCopyWith<$Res> {
  factory _$$_OrderStatusScalexResponseDtoCopyWith(
          _$_OrderStatusScalexResponseDto value,
          $Res Function(_$_OrderStatusScalexResponseDto) then) =
      __$$_OrderStatusScalexResponseDtoCopyWithImpl<$Res>;
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
class __$$_OrderStatusScalexResponseDtoCopyWithImpl<$Res>
    extends _$OrderStatusScalexResponseDtoCopyWithImpl<$Res,
        _$_OrderStatusScalexResponseDto>
    implements _$$_OrderStatusScalexResponseDtoCopyWith<$Res> {
  __$$_OrderStatusScalexResponseDtoCopyWithImpl(
      _$_OrderStatusScalexResponseDto _value,
      $Res Function(_$_OrderStatusScalexResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? onRampDetails = freezed,
  }) {
    return _then(_$_OrderStatusScalexResponseDto(
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
class _$_OrderStatusScalexResponseDto implements _OrderStatusScalexResponseDto {
  const _$_OrderStatusScalexResponseDto(
      {@JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
      required this.status,
      this.onRampDetails});

  factory _$_OrderStatusScalexResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderStatusScalexResponseDtoFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusScalexResponseDto &&
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
  _$$_OrderStatusScalexResponseDtoCopyWith<_$_OrderStatusScalexResponseDto>
      get copyWith => __$$_OrderStatusScalexResponseDtoCopyWithImpl<
          _$_OrderStatusScalexResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderStatusScalexResponseDtoToJson(
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
      _$_OrderStatusScalexResponseDto;

  factory _OrderStatusScalexResponseDto.fromJson(Map<String, dynamic> json) =
      _$_OrderStatusScalexResponseDto.fromJson;

  @override
  @JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
  ScalexOrderStatus get status;
  @override
  OnRampScalexDetails? get onRampDetails;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusScalexResponseDtoCopyWith<_$_OrderStatusScalexResponseDto>
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
      {String currency, String bankName, String bankAccount, num fromAmount});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnRampScalexDetailsCopyWith<$Res>
    implements $OnRampScalexDetailsCopyWith<$Res> {
  factory _$$_OnRampScalexDetailsCopyWith(_$_OnRampScalexDetails value,
          $Res Function(_$_OnRampScalexDetails) then) =
      __$$_OnRampScalexDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currency, String bankName, String bankAccount, num fromAmount});
}

/// @nodoc
class __$$_OnRampScalexDetailsCopyWithImpl<$Res>
    extends _$OnRampScalexDetailsCopyWithImpl<$Res, _$_OnRampScalexDetails>
    implements _$$_OnRampScalexDetailsCopyWith<$Res> {
  __$$_OnRampScalexDetailsCopyWithImpl(_$_OnRampScalexDetails _value,
      $Res Function(_$_OnRampScalexDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? bankName = null,
    Object? bankAccount = null,
    Object? fromAmount = null,
  }) {
    return _then(_$_OnRampScalexDetails(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OnRampScalexDetails implements _OnRampScalexDetails {
  const _$_OnRampScalexDetails(
      {required this.currency,
      required this.bankName,
      required this.bankAccount,
      required this.fromAmount});

  factory _$_OnRampScalexDetails.fromJson(Map<String, dynamic> json) =>
      _$$_OnRampScalexDetailsFromJson(json);

  @override
  final String currency;
  @override
  final String bankName;
  @override
  final String bankAccount;
  @override
  final num fromAmount;

  @override
  String toString() {
    return 'OnRampScalexDetails(currency: $currency, bankName: $bankName, bankAccount: $bankAccount, fromAmount: $fromAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnRampScalexDetails &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.bankAccount, bankAccount) ||
                other.bankAccount == bankAccount) &&
            (identical(other.fromAmount, fromAmount) ||
                other.fromAmount == fromAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currency, bankName, bankAccount, fromAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnRampScalexDetailsCopyWith<_$_OnRampScalexDetails> get copyWith =>
      __$$_OnRampScalexDetailsCopyWithImpl<_$_OnRampScalexDetails>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OnRampScalexDetailsToJson(
      this,
    );
  }
}

abstract class _OnRampScalexDetails implements OnRampScalexDetails {
  const factory _OnRampScalexDetails(
      {required final String currency,
      required final String bankName,
      required final String bankAccount,
      required final num fromAmount}) = _$_OnRampScalexDetails;

  factory _OnRampScalexDetails.fromJson(Map<String, dynamic> json) =
      _$_OnRampScalexDetails.fromJson;

  @override
  String get currency;
  @override
  String get bankName;
  @override
  String get bankAccount;
  @override
  num get fromAmount;
  @override
  @JsonKey(ignore: true)
  _$$_OnRampScalexDetailsCopyWith<_$_OnRampScalexDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
