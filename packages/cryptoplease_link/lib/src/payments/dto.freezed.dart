// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatePaymentRequestDto _$CreatePaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _CreatePaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentRequestDtoCopyWith<CreatePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentRequestDtoCopyWith<$Res> {
  factory $CreatePaymentRequestDtoCopyWith(CreatePaymentRequestDto value,
          $Res Function(CreatePaymentRequestDto) then) =
      _$CreatePaymentRequestDtoCopyWithImpl<$Res>;
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class _$CreatePaymentRequestDtoCopyWithImpl<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  _$CreatePaymentRequestDtoCopyWithImpl(this._value, this._then);

  final CreatePaymentRequestDto _value;
  // ignore: unused_field
  final $Res Function(CreatePaymentRequestDto) _then;

  @override
  $Res call({
    Object? senderAccount = freezed,
    Object? escrowAccount = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      senderAccount: senderAccount == freezed
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: escrowAccount == freezed
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CreatePaymentRequestDtoCopyWith<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  factory _$CreatePaymentRequestDtoCopyWith(_CreatePaymentRequestDto value,
          $Res Function(_CreatePaymentRequestDto) then) =
      __$CreatePaymentRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String senderAccount, String escrowAccount, int amount});
}

/// @nodoc
class __$CreatePaymentRequestDtoCopyWithImpl<$Res>
    extends _$CreatePaymentRequestDtoCopyWithImpl<$Res>
    implements _$CreatePaymentRequestDtoCopyWith<$Res> {
  __$CreatePaymentRequestDtoCopyWithImpl(_CreatePaymentRequestDto _value,
      $Res Function(_CreatePaymentRequestDto) _then)
      : super(_value, (v) => _then(v as _CreatePaymentRequestDto));

  @override
  _CreatePaymentRequestDto get _value =>
      super._value as _CreatePaymentRequestDto;

  @override
  $Res call({
    Object? senderAccount = freezed,
    Object? escrowAccount = freezed,
    Object? amount = freezed,
  }) {
    return _then(_CreatePaymentRequestDto(
      senderAccount: senderAccount == freezed
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: escrowAccount == freezed
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatePaymentRequestDto implements _CreatePaymentRequestDto {
  const _$_CreatePaymentRequestDto(
      {required this.senderAccount,
      required this.escrowAccount,
      required this.amount});

  factory _$_CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_CreatePaymentRequestDtoFromJson(json);

  @override
  final String senderAccount;
  @override
  final String escrowAccount;
  @override
  final int amount;

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePaymentRequestDto &&
            const DeepCollectionEquality()
                .equals(other.senderAccount, senderAccount) &&
            const DeepCollectionEquality()
                .equals(other.escrowAccount, escrowAccount) &&
            const DeepCollectionEquality().equals(other.amount, amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(senderAccount),
      const DeepCollectionEquality().hash(escrowAccount),
      const DeepCollectionEquality().hash(amount));

  @JsonKey(ignore: true)
  @override
  _$CreatePaymentRequestDtoCopyWith<_CreatePaymentRequestDto> get copyWith =>
      __$CreatePaymentRequestDtoCopyWithImpl<_CreatePaymentRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatePaymentRequestDtoToJson(this);
  }
}

abstract class _CreatePaymentRequestDto implements CreatePaymentRequestDto {
  const factory _CreatePaymentRequestDto(
      {required final String senderAccount,
      required final String escrowAccount,
      required final int amount}) = _$_CreatePaymentRequestDto;

  factory _CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$_CreatePaymentRequestDto.fromJson;

  @override
  String get senderAccount => throw _privateConstructorUsedError;
  @override
  String get escrowAccount => throw _privateConstructorUsedError;
  @override
  int get amount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreatePaymentRequestDtoCopyWith<_CreatePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatePaymentResponseDto _$CreatePaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _CreatePaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentResponseDtoCopyWith<CreatePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentResponseDtoCopyWith<$Res> {
  factory $CreatePaymentResponseDtoCopyWith(CreatePaymentResponseDto value,
          $Res Function(CreatePaymentResponseDto) then) =
      _$CreatePaymentResponseDtoCopyWithImpl<$Res>;
  $Res call({String transaction});
}

/// @nodoc
class _$CreatePaymentResponseDtoCopyWithImpl<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  _$CreatePaymentResponseDtoCopyWithImpl(this._value, this._then);

  final CreatePaymentResponseDto _value;
  // ignore: unused_field
  final $Res Function(CreatePaymentResponseDto) _then;

  @override
  $Res call({
    Object? transaction = freezed,
  }) {
    return _then(_value.copyWith(
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CreatePaymentResponseDtoCopyWith<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  factory _$CreatePaymentResponseDtoCopyWith(_CreatePaymentResponseDto value,
          $Res Function(_CreatePaymentResponseDto) then) =
      __$CreatePaymentResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({String transaction});
}

/// @nodoc
class __$CreatePaymentResponseDtoCopyWithImpl<$Res>
    extends _$CreatePaymentResponseDtoCopyWithImpl<$Res>
    implements _$CreatePaymentResponseDtoCopyWith<$Res> {
  __$CreatePaymentResponseDtoCopyWithImpl(_CreatePaymentResponseDto _value,
      $Res Function(_CreatePaymentResponseDto) _then)
      : super(_value, (v) => _then(v as _CreatePaymentResponseDto));

  @override
  _CreatePaymentResponseDto get _value =>
      super._value as _CreatePaymentResponseDto;

  @override
  $Res call({
    Object? transaction = freezed,
  }) {
    return _then(_CreatePaymentResponseDto(
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatePaymentResponseDto implements _CreatePaymentResponseDto {
  const _$_CreatePaymentResponseDto({required this.transaction});

  factory _$_CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_CreatePaymentResponseDtoFromJson(json);

  @override
  final String transaction;

  @override
  String toString() {
    return 'CreatePaymentResponseDto(transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePaymentResponseDto &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(transaction));

  @JsonKey(ignore: true)
  @override
  _$CreatePaymentResponseDtoCopyWith<_CreatePaymentResponseDto> get copyWith =>
      __$CreatePaymentResponseDtoCopyWithImpl<_CreatePaymentResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatePaymentResponseDtoToJson(this);
  }
}

abstract class _CreatePaymentResponseDto implements CreatePaymentResponseDto {
  const factory _CreatePaymentResponseDto({required final String transaction}) =
      _$_CreatePaymentResponseDto;

  factory _CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$_CreatePaymentResponseDto.fromJson;

  @override
  String get transaction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreatePaymentResponseDtoCopyWith<_CreatePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ReceivePaymentRequestDto _$ReceivePaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _ReceivePaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ReceivePaymentRequestDto {
  String get receiverAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceivePaymentRequestDtoCopyWith<ReceivePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory $ReceivePaymentRequestDtoCopyWith(ReceivePaymentRequestDto value,
          $Res Function(ReceivePaymentRequestDto) then) =
      _$ReceivePaymentRequestDtoCopyWithImpl<$Res>;
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class _$ReceivePaymentRequestDtoCopyWithImpl<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  _$ReceivePaymentRequestDtoCopyWithImpl(this._value, this._then);

  final ReceivePaymentRequestDto _value;
  // ignore: unused_field
  final $Res Function(ReceivePaymentRequestDto) _then;

  @override
  $Res call({
    Object? receiverAccount = freezed,
    Object? escrowAccount = freezed,
  }) {
    return _then(_value.copyWith(
      receiverAccount: receiverAccount == freezed
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: escrowAccount == freezed
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ReceivePaymentRequestDtoCopyWith<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory _$ReceivePaymentRequestDtoCopyWith(_ReceivePaymentRequestDto value,
          $Res Function(_ReceivePaymentRequestDto) then) =
      __$ReceivePaymentRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String receiverAccount, String escrowAccount});
}

/// @nodoc
class __$ReceivePaymentRequestDtoCopyWithImpl<$Res>
    extends _$ReceivePaymentRequestDtoCopyWithImpl<$Res>
    implements _$ReceivePaymentRequestDtoCopyWith<$Res> {
  __$ReceivePaymentRequestDtoCopyWithImpl(_ReceivePaymentRequestDto _value,
      $Res Function(_ReceivePaymentRequestDto) _then)
      : super(_value, (v) => _then(v as _ReceivePaymentRequestDto));

  @override
  _ReceivePaymentRequestDto get _value =>
      super._value as _ReceivePaymentRequestDto;

  @override
  $Res call({
    Object? receiverAccount = freezed,
    Object? escrowAccount = freezed,
  }) {
    return _then(_ReceivePaymentRequestDto(
      receiverAccount: receiverAccount == freezed
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: escrowAccount == freezed
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReceivePaymentRequestDto implements _ReceivePaymentRequestDto {
  const _$_ReceivePaymentRequestDto(
      {required this.receiverAccount, required this.escrowAccount});

  factory _$_ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_ReceivePaymentRequestDtoFromJson(json);

  @override
  final String receiverAccount;
  @override
  final String escrowAccount;

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceivePaymentRequestDto &&
            const DeepCollectionEquality()
                .equals(other.receiverAccount, receiverAccount) &&
            const DeepCollectionEquality()
                .equals(other.escrowAccount, escrowAccount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(receiverAccount),
      const DeepCollectionEquality().hash(escrowAccount));

  @JsonKey(ignore: true)
  @override
  _$ReceivePaymentRequestDtoCopyWith<_ReceivePaymentRequestDto> get copyWith =>
      __$ReceivePaymentRequestDtoCopyWithImpl<_ReceivePaymentRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceivePaymentRequestDtoToJson(this);
  }
}

abstract class _ReceivePaymentRequestDto implements ReceivePaymentRequestDto {
  const factory _ReceivePaymentRequestDto(
      {required final String receiverAccount,
      required final String escrowAccount}) = _$_ReceivePaymentRequestDto;

  factory _ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$_ReceivePaymentRequestDto.fromJson;

  @override
  String get receiverAccount => throw _privateConstructorUsedError;
  @override
  String get escrowAccount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReceivePaymentRequestDtoCopyWith<_ReceivePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ReceivePaymentResponseDto _$ReceivePaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _ReceivePaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ReceivePaymentResponseDto {
  String get transaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceivePaymentResponseDtoCopyWith<ReceivePaymentResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory $ReceivePaymentResponseDtoCopyWith(ReceivePaymentResponseDto value,
          $Res Function(ReceivePaymentResponseDto) then) =
      _$ReceivePaymentResponseDtoCopyWithImpl<$Res>;
  $Res call({String transaction});
}

/// @nodoc
class _$ReceivePaymentResponseDtoCopyWithImpl<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  _$ReceivePaymentResponseDtoCopyWithImpl(this._value, this._then);

  final ReceivePaymentResponseDto _value;
  // ignore: unused_field
  final $Res Function(ReceivePaymentResponseDto) _then;

  @override
  $Res call({
    Object? transaction = freezed,
  }) {
    return _then(_value.copyWith(
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ReceivePaymentResponseDtoCopyWith<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory _$ReceivePaymentResponseDtoCopyWith(_ReceivePaymentResponseDto value,
          $Res Function(_ReceivePaymentResponseDto) then) =
      __$ReceivePaymentResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({String transaction});
}

/// @nodoc
class __$ReceivePaymentResponseDtoCopyWithImpl<$Res>
    extends _$ReceivePaymentResponseDtoCopyWithImpl<$Res>
    implements _$ReceivePaymentResponseDtoCopyWith<$Res> {
  __$ReceivePaymentResponseDtoCopyWithImpl(_ReceivePaymentResponseDto _value,
      $Res Function(_ReceivePaymentResponseDto) _then)
      : super(_value, (v) => _then(v as _ReceivePaymentResponseDto));

  @override
  _ReceivePaymentResponseDto get _value =>
      super._value as _ReceivePaymentResponseDto;

  @override
  $Res call({
    Object? transaction = freezed,
  }) {
    return _then(_ReceivePaymentResponseDto(
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReceivePaymentResponseDto implements _ReceivePaymentResponseDto {
  const _$_ReceivePaymentResponseDto({required this.transaction});

  factory _$_ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_ReceivePaymentResponseDtoFromJson(json);

  @override
  final String transaction;

  @override
  String toString() {
    return 'ReceivePaymentResponseDto(transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceivePaymentResponseDto &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(transaction));

  @JsonKey(ignore: true)
  @override
  _$ReceivePaymentResponseDtoCopyWith<_ReceivePaymentResponseDto>
      get copyWith =>
          __$ReceivePaymentResponseDtoCopyWithImpl<_ReceivePaymentResponseDto>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceivePaymentResponseDtoToJson(this);
  }
}

abstract class _ReceivePaymentResponseDto implements ReceivePaymentResponseDto {
  const factory _ReceivePaymentResponseDto(
      {required final String transaction}) = _$_ReceivePaymentResponseDto;

  factory _ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$_ReceivePaymentResponseDto.fromJson;

  @override
  String get transaction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReceivePaymentResponseDtoCopyWith<_ReceivePaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}
