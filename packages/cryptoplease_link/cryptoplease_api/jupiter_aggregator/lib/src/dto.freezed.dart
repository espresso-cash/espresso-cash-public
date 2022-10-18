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

QuoteRequestDto _$QuoteRequestDtoFromJson(Map<String, dynamic> json) {
  return _QuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteRequestDto {
  String get inputMint => throw _privateConstructorUsedError;
  String get outputMint => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  SwapMode get swapMode => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  double? get slippage => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  double? get feeBps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteRequestDtoCopyWith<QuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteRequestDtoCopyWith<$Res> {
  factory $QuoteRequestDtoCopyWith(
          QuoteRequestDto value, $Res Function(QuoteRequestDto) then) =
      _$QuoteRequestDtoCopyWithImpl<$Res, QuoteRequestDto>;
  @useResult
  $Res call(
      {String inputMint,
      String outputMint,
      int amount,
      SwapMode swapMode,
      @JsonKey(includeIfNull: false) double? slippage,
      @JsonKey(includeIfNull: false) double? feeBps});
}

/// @nodoc
class _$QuoteRequestDtoCopyWithImpl<$Res, $Val extends QuoteRequestDto>
    implements $QuoteRequestDtoCopyWith<$Res> {
  _$QuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? swapMode = null,
    Object? slippage = freezed,
    Object? feeBps = freezed,
  }) {
    return _then(_value.copyWith(
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double?,
      feeBps: freezed == feeBps
          ? _value.feeBps
          : feeBps // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuoteRequestDtoCopyWith<$Res>
    implements $QuoteRequestDtoCopyWith<$Res> {
  factory _$$_QuoteRequestDtoCopyWith(
          _$_QuoteRequestDto value, $Res Function(_$_QuoteRequestDto) then) =
      __$$_QuoteRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputMint,
      String outputMint,
      int amount,
      SwapMode swapMode,
      @JsonKey(includeIfNull: false) double? slippage,
      @JsonKey(includeIfNull: false) double? feeBps});
}

/// @nodoc
class __$$_QuoteRequestDtoCopyWithImpl<$Res>
    extends _$QuoteRequestDtoCopyWithImpl<$Res, _$_QuoteRequestDto>
    implements _$$_QuoteRequestDtoCopyWith<$Res> {
  __$$_QuoteRequestDtoCopyWithImpl(
      _$_QuoteRequestDto _value, $Res Function(_$_QuoteRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? swapMode = null,
    Object? slippage = freezed,
    Object? feeBps = freezed,
  }) {
    return _then(_$_QuoteRequestDto(
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double?,
      feeBps: freezed == feeBps
          ? _value.feeBps
          : feeBps // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuoteRequestDto implements _QuoteRequestDto {
  const _$_QuoteRequestDto(
      {required this.inputMint,
      required this.outputMint,
      required this.amount,
      this.swapMode = SwapMode.exactIn,
      @JsonKey(includeIfNull: false) this.slippage,
      @JsonKey(includeIfNull: false) this.feeBps});

  factory _$_QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_QuoteRequestDtoFromJson(json);

  @override
  final String inputMint;
  @override
  final String outputMint;
  @override
  final int amount;
  @override
  @JsonKey()
  final SwapMode swapMode;
  @override
  @JsonKey(includeIfNull: false)
  final double? slippage;
  @override
  @JsonKey(includeIfNull: false)
  final double? feeBps;

  @override
  String toString() {
    return 'QuoteRequestDto(inputMint: $inputMint, outputMint: $outputMint, amount: $amount, swapMode: $swapMode, slippage: $slippage, feeBps: $feeBps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteRequestDto &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.swapMode, swapMode) ||
                other.swapMode == swapMode) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.feeBps, feeBps) || other.feeBps == feeBps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, inputMint, outputMint, amount, swapMode, slippage, feeBps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuoteRequestDtoCopyWith<_$_QuoteRequestDto> get copyWith =>
      __$$_QuoteRequestDtoCopyWithImpl<_$_QuoteRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuoteRequestDtoToJson(
      this,
    );
  }
}

abstract class _QuoteRequestDto implements QuoteRequestDto {
  const factory _QuoteRequestDto(
          {required final String inputMint,
          required final String outputMint,
          required final int amount,
          final SwapMode swapMode,
          @JsonKey(includeIfNull: false) final double? slippage,
          @JsonKey(includeIfNull: false) final double? feeBps}) =
      _$_QuoteRequestDto;

  factory _QuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$_QuoteRequestDto.fromJson;

  @override
  String get inputMint;
  @override
  String get outputMint;
  @override
  int get amount;
  @override
  SwapMode get swapMode;
  @override
  @JsonKey(includeIfNull: false)
  double? get slippage;
  @override
  @JsonKey(includeIfNull: false)
  double? get feeBps;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteRequestDtoCopyWith<_$_QuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteResponseDto _$QuoteResponseDtoFromJson(Map<String, dynamic> json) {
  return _QuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteResponseDto {
  @JsonKey(name: 'data')
  List<JupiterRoute> get routes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteResponseDtoCopyWith<QuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteResponseDtoCopyWith<$Res> {
  factory $QuoteResponseDtoCopyWith(
          QuoteResponseDto value, $Res Function(QuoteResponseDto) then) =
      _$QuoteResponseDtoCopyWithImpl<$Res, QuoteResponseDto>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<JupiterRoute> routes});
}

/// @nodoc
class _$QuoteResponseDtoCopyWithImpl<$Res, $Val extends QuoteResponseDto>
    implements $QuoteResponseDtoCopyWith<$Res> {
  _$QuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routes = null,
  }) {
    return _then(_value.copyWith(
      routes: null == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<JupiterRoute>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuoteResponseDtoCopyWith<$Res>
    implements $QuoteResponseDtoCopyWith<$Res> {
  factory _$$_QuoteResponseDtoCopyWith(
          _$_QuoteResponseDto value, $Res Function(_$_QuoteResponseDto) then) =
      __$$_QuoteResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<JupiterRoute> routes});
}

/// @nodoc
class __$$_QuoteResponseDtoCopyWithImpl<$Res>
    extends _$QuoteResponseDtoCopyWithImpl<$Res, _$_QuoteResponseDto>
    implements _$$_QuoteResponseDtoCopyWith<$Res> {
  __$$_QuoteResponseDtoCopyWithImpl(
      _$_QuoteResponseDto _value, $Res Function(_$_QuoteResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routes = null,
  }) {
    return _then(_$_QuoteResponseDto(
      routes: null == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<JupiterRoute>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuoteResponseDto implements _QuoteResponseDto {
  const _$_QuoteResponseDto(
      {@JsonKey(name: 'data') required final List<JupiterRoute> routes})
      : _routes = routes;

  factory _$_QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_QuoteResponseDtoFromJson(json);

  final List<JupiterRoute> _routes;
  @override
  @JsonKey(name: 'data')
  List<JupiterRoute> get routes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  @override
  String toString() {
    return 'QuoteResponseDto(routes: $routes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteResponseDto &&
            const DeepCollectionEquality().equals(other._routes, _routes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_routes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuoteResponseDtoCopyWith<_$_QuoteResponseDto> get copyWith =>
      __$$_QuoteResponseDtoCopyWithImpl<_$_QuoteResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuoteResponseDtoToJson(
      this,
    );
  }
}

abstract class _QuoteResponseDto implements QuoteResponseDto {
  const factory _QuoteResponseDto(
          {@JsonKey(name: 'data') required final List<JupiterRoute> routes}) =
      _$_QuoteResponseDto;

  factory _QuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$_QuoteResponseDto.fromJson;

  @override
  @JsonKey(name: 'data')
  List<JupiterRoute> get routes;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteResponseDtoCopyWith<_$_QuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapRequestDto _$SwapRequestDtoFromJson(Map<String, dynamic> json) {
  return _SwapRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRequestDto {
  String get userPublicKey => throw _privateConstructorUsedError;
  JupiterRoute get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRequestDtoCopyWith<SwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRequestDtoCopyWith<$Res> {
  factory $SwapRequestDtoCopyWith(
          SwapRequestDto value, $Res Function(SwapRequestDto) then) =
      _$SwapRequestDtoCopyWithImpl<$Res, SwapRequestDto>;
  @useResult
  $Res call({String userPublicKey, JupiterRoute route});

  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$SwapRequestDtoCopyWithImpl<$Res, $Val extends SwapRequestDto>
    implements $SwapRequestDtoCopyWith<$Res> {
  _$SwapRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPublicKey = null,
    Object? route = null,
  }) {
    return _then(_value.copyWith(
      userPublicKey: null == userPublicKey
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterRouteCopyWith<$Res> get route {
    return $JupiterRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SwapRequestDtoCopyWith<$Res>
    implements $SwapRequestDtoCopyWith<$Res> {
  factory _$$_SwapRequestDtoCopyWith(
          _$_SwapRequestDto value, $Res Function(_$_SwapRequestDto) then) =
      __$$_SwapRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userPublicKey, JupiterRoute route});

  @override
  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_SwapRequestDtoCopyWithImpl<$Res>
    extends _$SwapRequestDtoCopyWithImpl<$Res, _$_SwapRequestDto>
    implements _$$_SwapRequestDtoCopyWith<$Res> {
  __$$_SwapRequestDtoCopyWithImpl(
      _$_SwapRequestDto _value, $Res Function(_$_SwapRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPublicKey = null,
    Object? route = null,
  }) {
    return _then(_$_SwapRequestDto(
      userPublicKey: null == userPublicKey
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRequestDto implements _SwapRequestDto {
  const _$_SwapRequestDto({required this.userPublicKey, required this.route});

  factory _$_SwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRequestDtoFromJson(json);

  @override
  final String userPublicKey;
  @override
  final JupiterRoute route;

  @override
  String toString() {
    return 'SwapRequestDto(userPublicKey: $userPublicKey, route: $route)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRequestDto &&
            (identical(other.userPublicKey, userPublicKey) ||
                other.userPublicKey == userPublicKey) &&
            (identical(other.route, route) || other.route == route));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userPublicKey, route);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SwapRequestDtoCopyWith<_$_SwapRequestDto> get copyWith =>
      __$$_SwapRequestDtoCopyWithImpl<_$_SwapRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRequestDtoToJson(
      this,
    );
  }
}

abstract class _SwapRequestDto implements SwapRequestDto {
  const factory _SwapRequestDto(
      {required final String userPublicKey,
      required final JupiterRoute route}) = _$_SwapRequestDto;

  factory _SwapRequestDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRequestDto.fromJson;

  @override
  String get userPublicKey;
  @override
  JupiterRoute get route;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRequestDtoCopyWith<_$_SwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
