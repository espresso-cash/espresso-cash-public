// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_payment.dart';

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
  Cluster get cluster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentRequestDtoCopyWith<CreatePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentRequestDtoCopyWith<$Res> {
  factory $CreatePaymentRequestDtoCopyWith(CreatePaymentRequestDto value,
          $Res Function(CreatePaymentRequestDto) then) =
      _$CreatePaymentRequestDtoCopyWithImpl<$Res, CreatePaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      int amount,
      Cluster cluster});
}

/// @nodoc
class _$CreatePaymentRequestDtoCopyWithImpl<$Res,
        $Val extends CreatePaymentRequestDto>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  _$CreatePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? amount = null,
    Object? cluster = null,
  }) {
    return _then(_value.copyWith(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatePaymentRequestDtoCopyWith<$Res>
    implements $CreatePaymentRequestDtoCopyWith<$Res> {
  factory _$$_CreatePaymentRequestDtoCopyWith(_$_CreatePaymentRequestDto value,
          $Res Function(_$_CreatePaymentRequestDto) then) =
      __$$_CreatePaymentRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String escrowAccount,
      int amount,
      Cluster cluster});
}

/// @nodoc
class __$$_CreatePaymentRequestDtoCopyWithImpl<$Res>
    extends _$CreatePaymentRequestDtoCopyWithImpl<$Res,
        _$_CreatePaymentRequestDto>
    implements _$$_CreatePaymentRequestDtoCopyWith<$Res> {
  __$$_CreatePaymentRequestDtoCopyWithImpl(_$_CreatePaymentRequestDto _value,
      $Res Function(_$_CreatePaymentRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? escrowAccount = null,
    Object? amount = null,
    Object? cluster = null,
  }) {
    return _then(_$_CreatePaymentRequestDto(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatePaymentRequestDto implements _CreatePaymentRequestDto {
  const _$_CreatePaymentRequestDto(
      {required this.senderAccount,
      required this.escrowAccount,
      required this.amount,
      required this.cluster});

  factory _$_CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_CreatePaymentRequestDtoFromJson(json);

  @override
  final String senderAccount;
  @override
  final String escrowAccount;
  @override
  final int amount;
  @override
  final Cluster cluster;

  @override
  String toString() {
    return 'CreatePaymentRequestDto(senderAccount: $senderAccount, escrowAccount: $escrowAccount, amount: $amount, cluster: $cluster)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatePaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, senderAccount, escrowAccount, amount, cluster);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatePaymentRequestDtoCopyWith<_$_CreatePaymentRequestDto>
      get copyWith =>
          __$$_CreatePaymentRequestDtoCopyWithImpl<_$_CreatePaymentRequestDto>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatePaymentRequestDtoToJson(
      this,
    );
  }
}

abstract class _CreatePaymentRequestDto implements CreatePaymentRequestDto {
  const factory _CreatePaymentRequestDto(
      {required final String senderAccount,
      required final String escrowAccount,
      required final int amount,
      required final Cluster cluster}) = _$_CreatePaymentRequestDto;

  factory _CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$_CreatePaymentRequestDto.fromJson;

  @override
  String get senderAccount;
  @override
  String get escrowAccount;
  @override
  int get amount;
  @override
  Cluster get cluster;
  @override
  @JsonKey(ignore: true)
  _$$_CreatePaymentRequestDtoCopyWith<_$_CreatePaymentRequestDto>
      get copyWith => throw _privateConstructorUsedError;
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
      _$CreatePaymentResponseDtoCopyWithImpl<$Res, CreatePaymentResponseDto>;
  @useResult
  $Res call({String transaction});
}

/// @nodoc
class _$CreatePaymentResponseDtoCopyWithImpl<$Res,
        $Val extends CreatePaymentResponseDto>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  _$CreatePaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatePaymentResponseDtoCopyWith<$Res>
    implements $CreatePaymentResponseDtoCopyWith<$Res> {
  factory _$$_CreatePaymentResponseDtoCopyWith(
          _$_CreatePaymentResponseDto value,
          $Res Function(_$_CreatePaymentResponseDto) then) =
      __$$_CreatePaymentResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction});
}

/// @nodoc
class __$$_CreatePaymentResponseDtoCopyWithImpl<$Res>
    extends _$CreatePaymentResponseDtoCopyWithImpl<$Res,
        _$_CreatePaymentResponseDto>
    implements _$$_CreatePaymentResponseDtoCopyWith<$Res> {
  __$$_CreatePaymentResponseDtoCopyWithImpl(_$_CreatePaymentResponseDto _value,
      $Res Function(_$_CreatePaymentResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$_CreatePaymentResponseDto(
      transaction: null == transaction
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
            other is _$_CreatePaymentResponseDto &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatePaymentResponseDtoCopyWith<_$_CreatePaymentResponseDto>
      get copyWith => __$$_CreatePaymentResponseDtoCopyWithImpl<
          _$_CreatePaymentResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatePaymentResponseDtoToJson(
      this,
    );
  }
}

abstract class _CreatePaymentResponseDto implements CreatePaymentResponseDto {
  const factory _CreatePaymentResponseDto({required final String transaction}) =
      _$_CreatePaymentResponseDto;

  factory _CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$_CreatePaymentResponseDto.fromJson;

  @override
  String get transaction;
  @override
  @JsonKey(ignore: true)
  _$$_CreatePaymentResponseDtoCopyWith<_$_CreatePaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

ReceivePaymentRequestDto _$ReceivePaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _ReceivePaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ReceivePaymentRequestDto {
  String get receiverAccount => throw _privateConstructorUsedError;
  String get escrowAccount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceivePaymentRequestDtoCopyWith<ReceivePaymentRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory $ReceivePaymentRequestDtoCopyWith(ReceivePaymentRequestDto value,
          $Res Function(ReceivePaymentRequestDto) then) =
      _$ReceivePaymentRequestDtoCopyWithImpl<$Res, ReceivePaymentRequestDto>;
  @useResult
  $Res call({String receiverAccount, String escrowAccount, Cluster cluster});
}

/// @nodoc
class _$ReceivePaymentRequestDtoCopyWithImpl<$Res,
        $Val extends ReceivePaymentRequestDto>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  _$ReceivePaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
  }) {
    return _then(_value.copyWith(
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceivePaymentRequestDtoCopyWith<$Res>
    implements $ReceivePaymentRequestDtoCopyWith<$Res> {
  factory _$$_ReceivePaymentRequestDtoCopyWith(
          _$_ReceivePaymentRequestDto value,
          $Res Function(_$_ReceivePaymentRequestDto) then) =
      __$$_ReceivePaymentRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receiverAccount, String escrowAccount, Cluster cluster});
}

/// @nodoc
class __$$_ReceivePaymentRequestDtoCopyWithImpl<$Res>
    extends _$ReceivePaymentRequestDtoCopyWithImpl<$Res,
        _$_ReceivePaymentRequestDto>
    implements _$$_ReceivePaymentRequestDtoCopyWith<$Res> {
  __$$_ReceivePaymentRequestDtoCopyWithImpl(_$_ReceivePaymentRequestDto _value,
      $Res Function(_$_ReceivePaymentRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverAccount = null,
    Object? escrowAccount = null,
    Object? cluster = null,
  }) {
    return _then(_$_ReceivePaymentRequestDto(
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      escrowAccount: null == escrowAccount
          ? _value.escrowAccount
          : escrowAccount // ignore: cast_nullable_to_non_nullable
              as String,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReceivePaymentRequestDto implements _ReceivePaymentRequestDto {
  const _$_ReceivePaymentRequestDto(
      {required this.receiverAccount,
      required this.escrowAccount,
      required this.cluster});

  factory _$_ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_ReceivePaymentRequestDtoFromJson(json);

  @override
  final String receiverAccount;
  @override
  final String escrowAccount;
  @override
  final Cluster cluster;

  @override
  String toString() {
    return 'ReceivePaymentRequestDto(receiverAccount: $receiverAccount, escrowAccount: $escrowAccount, cluster: $cluster)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceivePaymentRequestDto &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.escrowAccount, escrowAccount) ||
                other.escrowAccount == escrowAccount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, receiverAccount, escrowAccount, cluster);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceivePaymentRequestDtoCopyWith<_$_ReceivePaymentRequestDto>
      get copyWith => __$$_ReceivePaymentRequestDtoCopyWithImpl<
          _$_ReceivePaymentRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceivePaymentRequestDtoToJson(
      this,
    );
  }
}

abstract class _ReceivePaymentRequestDto implements ReceivePaymentRequestDto {
  const factory _ReceivePaymentRequestDto(
      {required final String receiverAccount,
      required final String escrowAccount,
      required final Cluster cluster}) = _$_ReceivePaymentRequestDto;

  factory _ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$_ReceivePaymentRequestDto.fromJson;

  @override
  String get receiverAccount;
  @override
  String get escrowAccount;
  @override
  Cluster get cluster;
  @override
  @JsonKey(ignore: true)
  _$$_ReceivePaymentRequestDtoCopyWith<_$_ReceivePaymentRequestDto>
      get copyWith => throw _privateConstructorUsedError;
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
      _$ReceivePaymentResponseDtoCopyWithImpl<$Res, ReceivePaymentResponseDto>;
  @useResult
  $Res call({String transaction});
}

/// @nodoc
class _$ReceivePaymentResponseDtoCopyWithImpl<$Res,
        $Val extends ReceivePaymentResponseDto>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  _$ReceivePaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceivePaymentResponseDtoCopyWith<$Res>
    implements $ReceivePaymentResponseDtoCopyWith<$Res> {
  factory _$$_ReceivePaymentResponseDtoCopyWith(
          _$_ReceivePaymentResponseDto value,
          $Res Function(_$_ReceivePaymentResponseDto) then) =
      __$$_ReceivePaymentResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction});
}

/// @nodoc
class __$$_ReceivePaymentResponseDtoCopyWithImpl<$Res>
    extends _$ReceivePaymentResponseDtoCopyWithImpl<$Res,
        _$_ReceivePaymentResponseDto>
    implements _$$_ReceivePaymentResponseDtoCopyWith<$Res> {
  __$$_ReceivePaymentResponseDtoCopyWithImpl(
      _$_ReceivePaymentResponseDto _value,
      $Res Function(_$_ReceivePaymentResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$_ReceivePaymentResponseDto(
      transaction: null == transaction
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
            other is _$_ReceivePaymentResponseDto &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceivePaymentResponseDtoCopyWith<_$_ReceivePaymentResponseDto>
      get copyWith => __$$_ReceivePaymentResponseDtoCopyWithImpl<
          _$_ReceivePaymentResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceivePaymentResponseDtoToJson(
      this,
    );
  }
}

abstract class _ReceivePaymentResponseDto implements ReceivePaymentResponseDto {
  const factory _ReceivePaymentResponseDto(
      {required final String transaction}) = _$_ReceivePaymentResponseDto;

  factory _ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$_ReceivePaymentResponseDto.fromJson;

  @override
  String get transaction;
  @override
  @JsonKey(ignore: true)
  _$$_ReceivePaymentResponseDtoCopyWith<_$_ReceivePaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

CreateDirectPaymentRequestDto _$CreateDirectPaymentRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _CreateDirectPaymentRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDirectPaymentRequestDto {
  String get senderAccount => throw _privateConstructorUsedError;
  String get receiverAccount => throw _privateConstructorUsedError;
  String? get referenceAccount => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  Cluster get cluster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDirectPaymentRequestDtoCopyWith<CreateDirectPaymentRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory $CreateDirectPaymentRequestDtoCopyWith(
          CreateDirectPaymentRequestDto value,
          $Res Function(CreateDirectPaymentRequestDto) then) =
      _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
          CreateDirectPaymentRequestDto>;
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      String? referenceAccount,
      int amount,
      Cluster cluster});
}

/// @nodoc
class _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
        $Val extends CreateDirectPaymentRequestDto>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  _$CreateDirectPaymentRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? cluster = null,
  }) {
    return _then(_value.copyWith(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      referenceAccount: freezed == referenceAccount
          ? _value.referenceAccount
          : referenceAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateDirectPaymentRequestDtoCopyWith<$Res>
    implements $CreateDirectPaymentRequestDtoCopyWith<$Res> {
  factory _$$_CreateDirectPaymentRequestDtoCopyWith(
          _$_CreateDirectPaymentRequestDto value,
          $Res Function(_$_CreateDirectPaymentRequestDto) then) =
      __$$_CreateDirectPaymentRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderAccount,
      String receiverAccount,
      String? referenceAccount,
      int amount,
      Cluster cluster});
}

/// @nodoc
class __$$_CreateDirectPaymentRequestDtoCopyWithImpl<$Res>
    extends _$CreateDirectPaymentRequestDtoCopyWithImpl<$Res,
        _$_CreateDirectPaymentRequestDto>
    implements _$$_CreateDirectPaymentRequestDtoCopyWith<$Res> {
  __$$_CreateDirectPaymentRequestDtoCopyWithImpl(
      _$_CreateDirectPaymentRequestDto _value,
      $Res Function(_$_CreateDirectPaymentRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccount = null,
    Object? receiverAccount = null,
    Object? referenceAccount = freezed,
    Object? amount = null,
    Object? cluster = null,
  }) {
    return _then(_$_CreateDirectPaymentRequestDto(
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAccount: null == receiverAccount
          ? _value.receiverAccount
          : receiverAccount // ignore: cast_nullable_to_non_nullable
              as String,
      referenceAccount: freezed == referenceAccount
          ? _value.referenceAccount
          : referenceAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      cluster: null == cluster
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as Cluster,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateDirectPaymentRequestDto
    implements _CreateDirectPaymentRequestDto {
  const _$_CreateDirectPaymentRequestDto(
      {required this.senderAccount,
      required this.receiverAccount,
      required this.referenceAccount,
      required this.amount,
      required this.cluster});

  factory _$_CreateDirectPaymentRequestDto.fromJson(
          Map<String, dynamic> json) =>
      _$$_CreateDirectPaymentRequestDtoFromJson(json);

  @override
  final String senderAccount;
  @override
  final String receiverAccount;
  @override
  final String? referenceAccount;
  @override
  final int amount;
  @override
  final Cluster cluster;

  @override
  String toString() {
    return 'CreateDirectPaymentRequestDto(senderAccount: $senderAccount, receiverAccount: $receiverAccount, referenceAccount: $referenceAccount, amount: $amount, cluster: $cluster)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateDirectPaymentRequestDto &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount) &&
            (identical(other.receiverAccount, receiverAccount) ||
                other.receiverAccount == receiverAccount) &&
            (identical(other.referenceAccount, referenceAccount) ||
                other.referenceAccount == referenceAccount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cluster, cluster) || other.cluster == cluster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, senderAccount, receiverAccount,
      referenceAccount, amount, cluster);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateDirectPaymentRequestDtoCopyWith<_$_CreateDirectPaymentRequestDto>
      get copyWith => __$$_CreateDirectPaymentRequestDtoCopyWithImpl<
          _$_CreateDirectPaymentRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateDirectPaymentRequestDtoToJson(
      this,
    );
  }
}

abstract class _CreateDirectPaymentRequestDto
    implements CreateDirectPaymentRequestDto {
  const factory _CreateDirectPaymentRequestDto(
      {required final String senderAccount,
      required final String receiverAccount,
      required final String? referenceAccount,
      required final int amount,
      required final Cluster cluster}) = _$_CreateDirectPaymentRequestDto;

  factory _CreateDirectPaymentRequestDto.fromJson(Map<String, dynamic> json) =
      _$_CreateDirectPaymentRequestDto.fromJson;

  @override
  String get senderAccount;
  @override
  String get receiverAccount;
  @override
  String? get referenceAccount;
  @override
  int get amount;
  @override
  Cluster get cluster;
  @override
  @JsonKey(ignore: true)
  _$$_CreateDirectPaymentRequestDtoCopyWith<_$_CreateDirectPaymentRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

CreateDirectPaymentResponseDto _$CreateDirectPaymentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _CreateDirectPaymentResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDirectPaymentResponseDto {
  int get fee => throw _privateConstructorUsedError;
  String get transaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDirectPaymentResponseDtoCopyWith<CreateDirectPaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory $CreateDirectPaymentResponseDtoCopyWith(
          CreateDirectPaymentResponseDto value,
          $Res Function(CreateDirectPaymentResponseDto) then) =
      _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
          CreateDirectPaymentResponseDto>;
  @useResult
  $Res call({int fee, String transaction});
}

/// @nodoc
class _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
        $Val extends CreateDirectPaymentResponseDto>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  _$CreateDirectPaymentResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
  }) {
    return _then(_value.copyWith(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateDirectPaymentResponseDtoCopyWith<$Res>
    implements $CreateDirectPaymentResponseDtoCopyWith<$Res> {
  factory _$$_CreateDirectPaymentResponseDtoCopyWith(
          _$_CreateDirectPaymentResponseDto value,
          $Res Function(_$_CreateDirectPaymentResponseDto) then) =
      __$$_CreateDirectPaymentResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, String transaction});
}

/// @nodoc
class __$$_CreateDirectPaymentResponseDtoCopyWithImpl<$Res>
    extends _$CreateDirectPaymentResponseDtoCopyWithImpl<$Res,
        _$_CreateDirectPaymentResponseDto>
    implements _$$_CreateDirectPaymentResponseDtoCopyWith<$Res> {
  __$$_CreateDirectPaymentResponseDtoCopyWithImpl(
      _$_CreateDirectPaymentResponseDto _value,
      $Res Function(_$_CreateDirectPaymentResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
  }) {
    return _then(_$_CreateDirectPaymentResponseDto(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateDirectPaymentResponseDto
    implements _CreateDirectPaymentResponseDto {
  const _$_CreateDirectPaymentResponseDto(
      {required this.fee, required this.transaction});

  factory _$_CreateDirectPaymentResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$$_CreateDirectPaymentResponseDtoFromJson(json);

  @override
  final int fee;
  @override
  final String transaction;

  @override
  String toString() {
    return 'CreateDirectPaymentResponseDto(fee: $fee, transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateDirectPaymentResponseDto &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateDirectPaymentResponseDtoCopyWith<_$_CreateDirectPaymentResponseDto>
      get copyWith => __$$_CreateDirectPaymentResponseDtoCopyWithImpl<
          _$_CreateDirectPaymentResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateDirectPaymentResponseDtoToJson(
      this,
    );
  }
}

abstract class _CreateDirectPaymentResponseDto
    implements CreateDirectPaymentResponseDto {
  const factory _CreateDirectPaymentResponseDto(
      {required final int fee,
      required final String transaction}) = _$_CreateDirectPaymentResponseDto;

  factory _CreateDirectPaymentResponseDto.fromJson(Map<String, dynamic> json) =
      _$_CreateDirectPaymentResponseDto.fromJson;

  @override
  int get fee;
  @override
  String get transaction;
  @override
  @JsonKey(ignore: true)
  _$$_CreateDirectPaymentResponseDtoCopyWith<_$_CreateDirectPaymentResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}
