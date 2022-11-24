// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwapRouteRequestDto _$SwapRouteRequestDtoFromJson(Map<String, dynamic> json) {
  return _SwapRouteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRouteRequestDto {
  String get inputToken => throw _privateConstructorUsedError;
  String get outputToken => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  SwapMatch get match => throw _privateConstructorUsedError;
  SwapSlippage get slippage => throw _privateConstructorUsedError;
  String get userAccount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRouteRequestDtoCopyWith<SwapRouteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRouteRequestDtoCopyWith<$Res> {
  factory $SwapRouteRequestDtoCopyWith(
          SwapRouteRequestDto value, $Res Function(SwapRouteRequestDto) then) =
      _$SwapRouteRequestDtoCopyWithImpl<$Res>;
  $Res call(
      {String inputToken,
      String outputToken,
      String amount,
      SwapMatch match,
      SwapSlippage slippage,
      String userAccount});
}

/// @nodoc
class _$SwapRouteRequestDtoCopyWithImpl<$Res>
    implements $SwapRouteRequestDtoCopyWith<$Res> {
  _$SwapRouteRequestDtoCopyWithImpl(this._value, this._then);

  final SwapRouteRequestDto _value;
  // ignore: unused_field
  final $Res Function(SwapRouteRequestDto) _then;

  @override
  $Res call({
    Object? inputToken = freezed,
    Object? outputToken = freezed,
    Object? amount = freezed,
    Object? match = freezed,
    Object? slippage = freezed,
    Object? userAccount = freezed,
  }) {
    return _then(_value.copyWith(
      inputToken: inputToken == freezed
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: outputToken == freezed
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      match: match == freezed
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as SwapMatch,
      slippage: slippage == freezed
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as SwapSlippage,
      userAccount: userAccount == freezed
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SwapRouteRequestDtoCopyWith<$Res>
    implements $SwapRouteRequestDtoCopyWith<$Res> {
  factory _$$_SwapRouteRequestDtoCopyWith(_$_SwapRouteRequestDto value,
          $Res Function(_$_SwapRouteRequestDto) then) =
      __$$_SwapRouteRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String inputToken,
      String outputToken,
      String amount,
      SwapMatch match,
      SwapSlippage slippage,
      String userAccount});
}

/// @nodoc
class __$$_SwapRouteRequestDtoCopyWithImpl<$Res>
    extends _$SwapRouteRequestDtoCopyWithImpl<$Res>
    implements _$$_SwapRouteRequestDtoCopyWith<$Res> {
  __$$_SwapRouteRequestDtoCopyWithImpl(_$_SwapRouteRequestDto _value,
      $Res Function(_$_SwapRouteRequestDto) _then)
      : super(_value, (v) => _then(v as _$_SwapRouteRequestDto));

  @override
  _$_SwapRouteRequestDto get _value => super._value as _$_SwapRouteRequestDto;

  @override
  $Res call({
    Object? inputToken = freezed,
    Object? outputToken = freezed,
    Object? amount = freezed,
    Object? match = freezed,
    Object? slippage = freezed,
    Object? userAccount = freezed,
  }) {
    return _then(_$_SwapRouteRequestDto(
      inputToken: inputToken == freezed
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: outputToken == freezed
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      match: match == freezed
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as SwapMatch,
      slippage: slippage == freezed
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as SwapSlippage,
      userAccount: userAccount == freezed
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRouteRequestDto implements _SwapRouteRequestDto {
  const _$_SwapRouteRequestDto(
      {required this.inputToken,
      required this.outputToken,
      required this.amount,
      required this.match,
      required this.slippage,
      required this.userAccount});

  factory _$_SwapRouteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRouteRequestDtoFromJson(json);

  @override
  final String inputToken;
  @override
  final String outputToken;
  @override
  final String amount;
  @override
  final SwapMatch match;
  @override
  final SwapSlippage slippage;
  @override
  final String userAccount;

  @override
  String toString() {
    return 'SwapRouteRequestDto(inputToken: $inputToken, outputToken: $outputToken, amount: $amount, match: $match, slippage: $slippage, userAccount: $userAccount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRouteRequestDto &&
            const DeepCollectionEquality()
                .equals(other.inputToken, inputToken) &&
            const DeepCollectionEquality()
                .equals(other.outputToken, outputToken) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.match, match) &&
            const DeepCollectionEquality().equals(other.slippage, slippage) &&
            const DeepCollectionEquality()
                .equals(other.userAccount, userAccount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(inputToken),
      const DeepCollectionEquality().hash(outputToken),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(match),
      const DeepCollectionEquality().hash(slippage),
      const DeepCollectionEquality().hash(userAccount));

  @JsonKey(ignore: true)
  @override
  _$$_SwapRouteRequestDtoCopyWith<_$_SwapRouteRequestDto> get copyWith =>
      __$$_SwapRouteRequestDtoCopyWithImpl<_$_SwapRouteRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRouteRequestDtoToJson(
      this,
    );
  }
}

abstract class _SwapRouteRequestDto implements SwapRouteRequestDto {
  const factory _SwapRouteRequestDto(
      {required final String inputToken,
      required final String outputToken,
      required final String amount,
      required final SwapMatch match,
      required final SwapSlippage slippage,
      required final String userAccount}) = _$_SwapRouteRequestDto;

  factory _SwapRouteRequestDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRouteRequestDto.fromJson;

  @override
  String get inputToken;
  @override
  String get outputToken;
  @override
  String get amount;
  @override
  SwapMatch get match;
  @override
  SwapSlippage get slippage;
  @override
  String get userAccount;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRouteRequestDtoCopyWith<_$_SwapRouteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapRouteResponseDto _$SwapRouteResponseDtoFromJson(Map<String, dynamic> json) {
  return _SwapRouteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRouteResponseDto {
  JupiterRoute? get bestRoute => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRouteResponseDtoCopyWith<SwapRouteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRouteResponseDtoCopyWith<$Res> {
  factory $SwapRouteResponseDtoCopyWith(SwapRouteResponseDto value,
          $Res Function(SwapRouteResponseDto) then) =
      _$SwapRouteResponseDtoCopyWithImpl<$Res>;
  $Res call({JupiterRoute? bestRoute, int feeInUsdc});

  $JupiterRouteCopyWith<$Res>? get bestRoute;
}

/// @nodoc
class _$SwapRouteResponseDtoCopyWithImpl<$Res>
    implements $SwapRouteResponseDtoCopyWith<$Res> {
  _$SwapRouteResponseDtoCopyWithImpl(this._value, this._then);

  final SwapRouteResponseDto _value;
  // ignore: unused_field
  final $Res Function(SwapRouteResponseDto) _then;

  @override
  $Res call({
    Object? bestRoute = freezed,
    Object? feeInUsdc = freezed,
  }) {
    return _then(_value.copyWith(
      bestRoute: bestRoute == freezed
          ? _value.bestRoute
          : bestRoute // ignore: cast_nullable_to_non_nullable
              as JupiterRoute?,
      feeInUsdc: feeInUsdc == freezed
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $JupiterRouteCopyWith<$Res>? get bestRoute {
    if (_value.bestRoute == null) {
      return null;
    }

    return $JupiterRouteCopyWith<$Res>(_value.bestRoute!, (value) {
      return _then(_value.copyWith(bestRoute: value));
    });
  }
}

/// @nodoc
abstract class _$$_SwapRouteResponseDtoCopyWith<$Res>
    implements $SwapRouteResponseDtoCopyWith<$Res> {
  factory _$$_SwapRouteResponseDtoCopyWith(_$_SwapRouteResponseDto value,
          $Res Function(_$_SwapRouteResponseDto) then) =
      __$$_SwapRouteResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({JupiterRoute? bestRoute, int feeInUsdc});

  @override
  $JupiterRouteCopyWith<$Res>? get bestRoute;
}

/// @nodoc
class __$$_SwapRouteResponseDtoCopyWithImpl<$Res>
    extends _$SwapRouteResponseDtoCopyWithImpl<$Res>
    implements _$$_SwapRouteResponseDtoCopyWith<$Res> {
  __$$_SwapRouteResponseDtoCopyWithImpl(_$_SwapRouteResponseDto _value,
      $Res Function(_$_SwapRouteResponseDto) _then)
      : super(_value, (v) => _then(v as _$_SwapRouteResponseDto));

  @override
  _$_SwapRouteResponseDto get _value => super._value as _$_SwapRouteResponseDto;

  @override
  $Res call({
    Object? bestRoute = freezed,
    Object? feeInUsdc = freezed,
  }) {
    return _then(_$_SwapRouteResponseDto(
      bestRoute: bestRoute == freezed
          ? _value.bestRoute
          : bestRoute // ignore: cast_nullable_to_non_nullable
              as JupiterRoute?,
      feeInUsdc: feeInUsdc == freezed
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRouteResponseDto implements _SwapRouteResponseDto {
  const _$_SwapRouteResponseDto(
      {required this.bestRoute, required this.feeInUsdc});

  factory _$_SwapRouteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRouteResponseDtoFromJson(json);

  @override
  final JupiterRoute? bestRoute;
  @override
  final int feeInUsdc;

  @override
  String toString() {
    return 'SwapRouteResponseDto(bestRoute: $bestRoute, feeInUsdc: $feeInUsdc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRouteResponseDto &&
            const DeepCollectionEquality().equals(other.bestRoute, bestRoute) &&
            const DeepCollectionEquality().equals(other.feeInUsdc, feeInUsdc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bestRoute),
      const DeepCollectionEquality().hash(feeInUsdc));

  @JsonKey(ignore: true)
  @override
  _$$_SwapRouteResponseDtoCopyWith<_$_SwapRouteResponseDto> get copyWith =>
      __$$_SwapRouteResponseDtoCopyWithImpl<_$_SwapRouteResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRouteResponseDtoToJson(
      this,
    );
  }
}

abstract class _SwapRouteResponseDto implements SwapRouteResponseDto {
  const factory _SwapRouteResponseDto(
      {required final JupiterRoute? bestRoute,
      required final int feeInUsdc}) = _$_SwapRouteResponseDto;

  factory _SwapRouteResponseDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRouteResponseDto.fromJson;

  @override
  JupiterRoute? get bestRoute;
  @override
  int get feeInUsdc;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRouteResponseDtoCopyWith<_$_SwapRouteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapTxResponseDto _$SwapTxResponseDtoFromJson(Map<String, dynamic> json) {
  return _SwapTxResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SwapTxResponseDto {
  String get swapTransaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapTxResponseDtoCopyWith<SwapTxResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapTxResponseDtoCopyWith<$Res> {
  factory $SwapTxResponseDtoCopyWith(
          SwapTxResponseDto value, $Res Function(SwapTxResponseDto) then) =
      _$SwapTxResponseDtoCopyWithImpl<$Res>;
  $Res call({String swapTransaction});
}

/// @nodoc
class _$SwapTxResponseDtoCopyWithImpl<$Res>
    implements $SwapTxResponseDtoCopyWith<$Res> {
  _$SwapTxResponseDtoCopyWithImpl(this._value, this._then);

  final SwapTxResponseDto _value;
  // ignore: unused_field
  final $Res Function(SwapTxResponseDto) _then;

  @override
  $Res call({
    Object? swapTransaction = freezed,
  }) {
    return _then(_value.copyWith(
      swapTransaction: swapTransaction == freezed
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SwapTxResponseDtoCopyWith<$Res>
    implements $SwapTxResponseDtoCopyWith<$Res> {
  factory _$$_SwapTxResponseDtoCopyWith(_$_SwapTxResponseDto value,
          $Res Function(_$_SwapTxResponseDto) then) =
      __$$_SwapTxResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({String swapTransaction});
}

/// @nodoc
class __$$_SwapTxResponseDtoCopyWithImpl<$Res>
    extends _$SwapTxResponseDtoCopyWithImpl<$Res>
    implements _$$_SwapTxResponseDtoCopyWith<$Res> {
  __$$_SwapTxResponseDtoCopyWithImpl(
      _$_SwapTxResponseDto _value, $Res Function(_$_SwapTxResponseDto) _then)
      : super(_value, (v) => _then(v as _$_SwapTxResponseDto));

  @override
  _$_SwapTxResponseDto get _value => super._value as _$_SwapTxResponseDto;

  @override
  $Res call({
    Object? swapTransaction = freezed,
  }) {
    return _then(_$_SwapTxResponseDto(
      swapTransaction: swapTransaction == freezed
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapTxResponseDto implements _SwapTxResponseDto {
  const _$_SwapTxResponseDto({required this.swapTransaction});

  factory _$_SwapTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapTxResponseDtoFromJson(json);

  @override
  final String swapTransaction;

  @override
  String toString() {
    return 'SwapTxResponseDto(swapTransaction: $swapTransaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapTxResponseDto &&
            const DeepCollectionEquality()
                .equals(other.swapTransaction, swapTransaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(swapTransaction));

  @JsonKey(ignore: true)
  @override
  _$$_SwapTxResponseDtoCopyWith<_$_SwapTxResponseDto> get copyWith =>
      __$$_SwapTxResponseDtoCopyWithImpl<_$_SwapTxResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapTxResponseDtoToJson(
      this,
    );
  }
}

abstract class _SwapTxResponseDto implements SwapTxResponseDto {
  const factory _SwapTxResponseDto({required final String swapTransaction}) =
      _$_SwapTxResponseDto;

  factory _SwapTxResponseDto.fromJson(Map<String, dynamic> json) =
      _$_SwapTxResponseDto.fromJson;

  @override
  String get swapTransaction;
  @override
  @JsonKey(ignore: true)
  _$$_SwapTxResponseDtoCopyWith<_$_SwapTxResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapTxRequestDto _$SwapTxRequestDtoFromJson(Map<String, dynamic> json) {
  return _SwapTxRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapTxRequestDto {
  String get userAccount => throw _privateConstructorUsedError;
  JupiterRoute get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapTxRequestDtoCopyWith<SwapTxRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapTxRequestDtoCopyWith<$Res> {
  factory $SwapTxRequestDtoCopyWith(
          SwapTxRequestDto value, $Res Function(SwapTxRequestDto) then) =
      _$SwapTxRequestDtoCopyWithImpl<$Res>;
  $Res call({String userAccount, JupiterRoute route});

  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$SwapTxRequestDtoCopyWithImpl<$Res>
    implements $SwapTxRequestDtoCopyWith<$Res> {
  _$SwapTxRequestDtoCopyWithImpl(this._value, this._then);

  final SwapTxRequestDto _value;
  // ignore: unused_field
  final $Res Function(SwapTxRequestDto) _then;

  @override
  $Res call({
    Object? userAccount = freezed,
    Object? route = freezed,
  }) {
    return _then(_value.copyWith(
      userAccount: userAccount == freezed
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }

  @override
  $JupiterRouteCopyWith<$Res> get route {
    return $JupiterRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value));
    });
  }
}

/// @nodoc
abstract class _$$_SwapTxRequestDtoCopyWith<$Res>
    implements $SwapTxRequestDtoCopyWith<$Res> {
  factory _$$_SwapTxRequestDtoCopyWith(
          _$_SwapTxRequestDto value, $Res Function(_$_SwapTxRequestDto) then) =
      __$$_SwapTxRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String userAccount, JupiterRoute route});

  @override
  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_SwapTxRequestDtoCopyWithImpl<$Res>
    extends _$SwapTxRequestDtoCopyWithImpl<$Res>
    implements _$$_SwapTxRequestDtoCopyWith<$Res> {
  __$$_SwapTxRequestDtoCopyWithImpl(
      _$_SwapTxRequestDto _value, $Res Function(_$_SwapTxRequestDto) _then)
      : super(_value, (v) => _then(v as _$_SwapTxRequestDto));

  @override
  _$_SwapTxRequestDto get _value => super._value as _$_SwapTxRequestDto;

  @override
  $Res call({
    Object? userAccount = freezed,
    Object? route = freezed,
  }) {
    return _then(_$_SwapTxRequestDto(
      userAccount: userAccount == freezed
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapTxRequestDto implements _SwapTxRequestDto {
  const _$_SwapTxRequestDto({required this.userAccount, required this.route});

  factory _$_SwapTxRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapTxRequestDtoFromJson(json);

  @override
  final String userAccount;
  @override
  final JupiterRoute route;

  @override
  String toString() {
    return 'SwapTxRequestDto(userAccount: $userAccount, route: $route)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapTxRequestDto &&
            const DeepCollectionEquality()
                .equals(other.userAccount, userAccount) &&
            const DeepCollectionEquality().equals(other.route, route));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userAccount),
      const DeepCollectionEquality().hash(route));

  @JsonKey(ignore: true)
  @override
  _$$_SwapTxRequestDtoCopyWith<_$_SwapTxRequestDto> get copyWith =>
      __$$_SwapTxRequestDtoCopyWithImpl<_$_SwapTxRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapTxRequestDtoToJson(
      this,
    );
  }
}

abstract class _SwapTxRequestDto implements SwapTxRequestDto {
  const factory _SwapTxRequestDto(
      {required final String userAccount,
      required final JupiterRoute route}) = _$_SwapTxRequestDto;

  factory _SwapTxRequestDto.fromJson(Map<String, dynamic> json) =
      _$_SwapTxRequestDto.fromJson;

  @override
  String get userAccount;
  @override
  JupiterRoute get route;
  @override
  @JsonKey(ignore: true)
  _$$_SwapTxRequestDtoCopyWith<_$_SwapTxRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
