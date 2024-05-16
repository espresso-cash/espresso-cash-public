// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GasFeeRequestDto _$GasFeeRequestDtoFromJson(Map<String, dynamic> json) {
  return _GasFeeRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GasFeeRequestDto {
  String get network => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GasFeeRequestDtoCopyWith<GasFeeRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasFeeRequestDtoCopyWith<$Res> {
  factory $GasFeeRequestDtoCopyWith(
          GasFeeRequestDto value, $Res Function(GasFeeRequestDto) then) =
      _$GasFeeRequestDtoCopyWithImpl<$Res, GasFeeRequestDto>;
  @useResult
  $Res call({String network});
}

/// @nodoc
class _$GasFeeRequestDtoCopyWithImpl<$Res, $Val extends GasFeeRequestDto>
    implements $GasFeeRequestDtoCopyWith<$Res> {
  _$GasFeeRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GasFeeRequestDtoImplCopyWith<$Res>
    implements $GasFeeRequestDtoCopyWith<$Res> {
  factory _$$GasFeeRequestDtoImplCopyWith(_$GasFeeRequestDtoImpl value,
          $Res Function(_$GasFeeRequestDtoImpl) then) =
      __$$GasFeeRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String network});
}

/// @nodoc
class __$$GasFeeRequestDtoImplCopyWithImpl<$Res>
    extends _$GasFeeRequestDtoCopyWithImpl<$Res, _$GasFeeRequestDtoImpl>
    implements _$$GasFeeRequestDtoImplCopyWith<$Res> {
  __$$GasFeeRequestDtoImplCopyWithImpl(_$GasFeeRequestDtoImpl _value,
      $Res Function(_$GasFeeRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
  }) {
    return _then(_$GasFeeRequestDtoImpl(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasFeeRequestDtoImpl implements _GasFeeRequestDto {
  const _$GasFeeRequestDtoImpl({required this.network});

  factory _$GasFeeRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasFeeRequestDtoImplFromJson(json);

  @override
  final String network;

  @override
  String toString() {
    return 'GasFeeRequestDto(network: $network)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasFeeRequestDtoImpl &&
            (identical(other.network, network) || other.network == network));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, network);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GasFeeRequestDtoImplCopyWith<_$GasFeeRequestDtoImpl> get copyWith =>
      __$$GasFeeRequestDtoImplCopyWithImpl<_$GasFeeRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasFeeRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _GasFeeRequestDto implements GasFeeRequestDto {
  const factory _GasFeeRequestDto({required final String network}) =
      _$GasFeeRequestDtoImpl;

  factory _GasFeeRequestDto.fromJson(Map<String, dynamic> json) =
      _$GasFeeRequestDtoImpl.fromJson;

  @override
  String get network;
  @override
  @JsonKey(ignore: true)
  _$$GasFeeRequestDtoImplCopyWith<_$GasFeeRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GasFeeResponseDto _$GasFeeResponseDtoFromJson(Map<String, dynamic> json) {
  return _GasFeeResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GasFeeResponseDto {
  GasFeeEstimate get low => throw _privateConstructorUsedError;
  GasFeeEstimate get medium => throw _privateConstructorUsedError;
  GasFeeEstimate get high => throw _privateConstructorUsedError;
  String get estimatedBaseFee => throw _privateConstructorUsedError;
  double get networkCongestion => throw _privateConstructorUsedError;
  List<String> get latestPriorityFeeRange => throw _privateConstructorUsedError;
  List<String> get historicalPriorityFeeRange =>
      throw _privateConstructorUsedError;
  List<String> get historicalBaseFeeRange => throw _privateConstructorUsedError;
  String get priorityFeeTrend => throw _privateConstructorUsedError;
  String get baseFeeTrend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GasFeeResponseDtoCopyWith<GasFeeResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasFeeResponseDtoCopyWith<$Res> {
  factory $GasFeeResponseDtoCopyWith(
          GasFeeResponseDto value, $Res Function(GasFeeResponseDto) then) =
      _$GasFeeResponseDtoCopyWithImpl<$Res, GasFeeResponseDto>;
  @useResult
  $Res call(
      {GasFeeEstimate low,
      GasFeeEstimate medium,
      GasFeeEstimate high,
      String estimatedBaseFee,
      double networkCongestion,
      List<String> latestPriorityFeeRange,
      List<String> historicalPriorityFeeRange,
      List<String> historicalBaseFeeRange,
      String priorityFeeTrend,
      String baseFeeTrend});

  $GasFeeEstimateCopyWith<$Res> get low;
  $GasFeeEstimateCopyWith<$Res> get medium;
  $GasFeeEstimateCopyWith<$Res> get high;
}

/// @nodoc
class _$GasFeeResponseDtoCopyWithImpl<$Res, $Val extends GasFeeResponseDto>
    implements $GasFeeResponseDtoCopyWith<$Res> {
  _$GasFeeResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
    Object? latestPriorityFeeRange = null,
    Object? historicalPriorityFeeRange = null,
    Object? historicalBaseFeeRange = null,
    Object? priorityFeeTrend = null,
    Object? baseFeeTrend = null,
  }) {
    return _then(_value.copyWith(
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      estimatedBaseFee: null == estimatedBaseFee
          ? _value.estimatedBaseFee
          : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
              as String,
      networkCongestion: null == networkCongestion
          ? _value.networkCongestion
          : networkCongestion // ignore: cast_nullable_to_non_nullable
              as double,
      latestPriorityFeeRange: null == latestPriorityFeeRange
          ? _value.latestPriorityFeeRange
          : latestPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalPriorityFeeRange: null == historicalPriorityFeeRange
          ? _value.historicalPriorityFeeRange
          : historicalPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalBaseFeeRange: null == historicalBaseFeeRange
          ? _value.historicalBaseFeeRange
          : historicalBaseFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priorityFeeTrend: null == priorityFeeTrend
          ? _value.priorityFeeTrend
          : priorityFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
      baseFeeTrend: null == baseFeeTrend
          ? _value.baseFeeTrend
          : baseFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get low {
    return $GasFeeEstimateCopyWith<$Res>(_value.low, (value) {
      return _then(_value.copyWith(low: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get medium {
    return $GasFeeEstimateCopyWith<$Res>(_value.medium, (value) {
      return _then(_value.copyWith(medium: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get high {
    return $GasFeeEstimateCopyWith<$Res>(_value.high, (value) {
      return _then(_value.copyWith(high: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GasFeeResponseDtoImplCopyWith<$Res>
    implements $GasFeeResponseDtoCopyWith<$Res> {
  factory _$$GasFeeResponseDtoImplCopyWith(_$GasFeeResponseDtoImpl value,
          $Res Function(_$GasFeeResponseDtoImpl) then) =
      __$$GasFeeResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GasFeeEstimate low,
      GasFeeEstimate medium,
      GasFeeEstimate high,
      String estimatedBaseFee,
      double networkCongestion,
      List<String> latestPriorityFeeRange,
      List<String> historicalPriorityFeeRange,
      List<String> historicalBaseFeeRange,
      String priorityFeeTrend,
      String baseFeeTrend});

  @override
  $GasFeeEstimateCopyWith<$Res> get low;
  @override
  $GasFeeEstimateCopyWith<$Res> get medium;
  @override
  $GasFeeEstimateCopyWith<$Res> get high;
}

/// @nodoc
class __$$GasFeeResponseDtoImplCopyWithImpl<$Res>
    extends _$GasFeeResponseDtoCopyWithImpl<$Res, _$GasFeeResponseDtoImpl>
    implements _$$GasFeeResponseDtoImplCopyWith<$Res> {
  __$$GasFeeResponseDtoImplCopyWithImpl(_$GasFeeResponseDtoImpl _value,
      $Res Function(_$GasFeeResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
    Object? latestPriorityFeeRange = null,
    Object? historicalPriorityFeeRange = null,
    Object? historicalBaseFeeRange = null,
    Object? priorityFeeTrend = null,
    Object? baseFeeTrend = null,
  }) {
    return _then(_$GasFeeResponseDtoImpl(
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as GasFeeEstimate,
      estimatedBaseFee: null == estimatedBaseFee
          ? _value.estimatedBaseFee
          : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
              as String,
      networkCongestion: null == networkCongestion
          ? _value.networkCongestion
          : networkCongestion // ignore: cast_nullable_to_non_nullable
              as double,
      latestPriorityFeeRange: null == latestPriorityFeeRange
          ? _value._latestPriorityFeeRange
          : latestPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalPriorityFeeRange: null == historicalPriorityFeeRange
          ? _value._historicalPriorityFeeRange
          : historicalPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalBaseFeeRange: null == historicalBaseFeeRange
          ? _value._historicalBaseFeeRange
          : historicalBaseFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priorityFeeTrend: null == priorityFeeTrend
          ? _value.priorityFeeTrend
          : priorityFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
      baseFeeTrend: null == baseFeeTrend
          ? _value.baseFeeTrend
          : baseFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasFeeResponseDtoImpl implements _GasFeeResponseDto {
  const _$GasFeeResponseDtoImpl(
      {required this.low,
      required this.medium,
      required this.high,
      required this.estimatedBaseFee,
      required this.networkCongestion,
      required final List<String> latestPriorityFeeRange,
      required final List<String> historicalPriorityFeeRange,
      required final List<String> historicalBaseFeeRange,
      required this.priorityFeeTrend,
      required this.baseFeeTrend})
      : _latestPriorityFeeRange = latestPriorityFeeRange,
        _historicalPriorityFeeRange = historicalPriorityFeeRange,
        _historicalBaseFeeRange = historicalBaseFeeRange;

  factory _$GasFeeResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasFeeResponseDtoImplFromJson(json);

  @override
  final GasFeeEstimate low;
  @override
  final GasFeeEstimate medium;
  @override
  final GasFeeEstimate high;
  @override
  final String estimatedBaseFee;
  @override
  final double networkCongestion;
  final List<String> _latestPriorityFeeRange;
  @override
  List<String> get latestPriorityFeeRange {
    if (_latestPriorityFeeRange is EqualUnmodifiableListView)
      return _latestPriorityFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latestPriorityFeeRange);
  }

  final List<String> _historicalPriorityFeeRange;
  @override
  List<String> get historicalPriorityFeeRange {
    if (_historicalPriorityFeeRange is EqualUnmodifiableListView)
      return _historicalPriorityFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalPriorityFeeRange);
  }

  final List<String> _historicalBaseFeeRange;
  @override
  List<String> get historicalBaseFeeRange {
    if (_historicalBaseFeeRange is EqualUnmodifiableListView)
      return _historicalBaseFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalBaseFeeRange);
  }

  @override
  final String priorityFeeTrend;
  @override
  final String baseFeeTrend;

  @override
  String toString() {
    return 'GasFeeResponseDto(low: $low, medium: $medium, high: $high, estimatedBaseFee: $estimatedBaseFee, networkCongestion: $networkCongestion, latestPriorityFeeRange: $latestPriorityFeeRange, historicalPriorityFeeRange: $historicalPriorityFeeRange, historicalBaseFeeRange: $historicalBaseFeeRange, priorityFeeTrend: $priorityFeeTrend, baseFeeTrend: $baseFeeTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasFeeResponseDtoImpl &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.estimatedBaseFee, estimatedBaseFee) ||
                other.estimatedBaseFee == estimatedBaseFee) &&
            (identical(other.networkCongestion, networkCongestion) ||
                other.networkCongestion == networkCongestion) &&
            const DeepCollectionEquality().equals(
                other._latestPriorityFeeRange, _latestPriorityFeeRange) &&
            const DeepCollectionEquality().equals(
                other._historicalPriorityFeeRange,
                _historicalPriorityFeeRange) &&
            const DeepCollectionEquality().equals(
                other._historicalBaseFeeRange, _historicalBaseFeeRange) &&
            (identical(other.priorityFeeTrend, priorityFeeTrend) ||
                other.priorityFeeTrend == priorityFeeTrend) &&
            (identical(other.baseFeeTrend, baseFeeTrend) ||
                other.baseFeeTrend == baseFeeTrend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      low,
      medium,
      high,
      estimatedBaseFee,
      networkCongestion,
      const DeepCollectionEquality().hash(_latestPriorityFeeRange),
      const DeepCollectionEquality().hash(_historicalPriorityFeeRange),
      const DeepCollectionEquality().hash(_historicalBaseFeeRange),
      priorityFeeTrend,
      baseFeeTrend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GasFeeResponseDtoImplCopyWith<_$GasFeeResponseDtoImpl> get copyWith =>
      __$$GasFeeResponseDtoImplCopyWithImpl<_$GasFeeResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasFeeResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GasFeeResponseDto implements GasFeeResponseDto {
  const factory _GasFeeResponseDto(
      {required final GasFeeEstimate low,
      required final GasFeeEstimate medium,
      required final GasFeeEstimate high,
      required final String estimatedBaseFee,
      required final double networkCongestion,
      required final List<String> latestPriorityFeeRange,
      required final List<String> historicalPriorityFeeRange,
      required final List<String> historicalBaseFeeRange,
      required final String priorityFeeTrend,
      required final String baseFeeTrend}) = _$GasFeeResponseDtoImpl;

  factory _GasFeeResponseDto.fromJson(Map<String, dynamic> json) =
      _$GasFeeResponseDtoImpl.fromJson;

  @override
  GasFeeEstimate get low;
  @override
  GasFeeEstimate get medium;
  @override
  GasFeeEstimate get high;
  @override
  String get estimatedBaseFee;
  @override
  double get networkCongestion;
  @override
  List<String> get latestPriorityFeeRange;
  @override
  List<String> get historicalPriorityFeeRange;
  @override
  List<String> get historicalBaseFeeRange;
  @override
  String get priorityFeeTrend;
  @override
  String get baseFeeTrend;
  @override
  @JsonKey(ignore: true)
  _$$GasFeeResponseDtoImplCopyWith<_$GasFeeResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GasFeeEstimate _$GasFeeEstimateFromJson(Map<String, dynamic> json) {
  return _GasFeeEstimate.fromJson(json);
}

/// @nodoc
mixin _$GasFeeEstimate {
  String get suggestedMaxPriorityFeePerGas =>
      throw _privateConstructorUsedError;
  String get suggestedMaxFeePerGas => throw _privateConstructorUsedError;
  int get minWaitTimeEstimate => throw _privateConstructorUsedError;
  int get maxWaitTimeEstimate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GasFeeEstimateCopyWith<GasFeeEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasFeeEstimateCopyWith<$Res> {
  factory $GasFeeEstimateCopyWith(
          GasFeeEstimate value, $Res Function(GasFeeEstimate) then) =
      _$GasFeeEstimateCopyWithImpl<$Res, GasFeeEstimate>;
  @useResult
  $Res call(
      {String suggestedMaxPriorityFeePerGas,
      String suggestedMaxFeePerGas,
      int minWaitTimeEstimate,
      int maxWaitTimeEstimate});
}

/// @nodoc
class _$GasFeeEstimateCopyWithImpl<$Res, $Val extends GasFeeEstimate>
    implements $GasFeeEstimateCopyWith<$Res> {
  _$GasFeeEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(_value.copyWith(
      suggestedMaxPriorityFeePerGas: null == suggestedMaxPriorityFeePerGas
          ? _value.suggestedMaxPriorityFeePerGas
          : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedMaxFeePerGas: null == suggestedMaxFeePerGas
          ? _value.suggestedMaxFeePerGas
          : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      minWaitTimeEstimate: null == minWaitTimeEstimate
          ? _value.minWaitTimeEstimate
          : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      maxWaitTimeEstimate: null == maxWaitTimeEstimate
          ? _value.maxWaitTimeEstimate
          : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GasFeeEstimateImplCopyWith<$Res>
    implements $GasFeeEstimateCopyWith<$Res> {
  factory _$$GasFeeEstimateImplCopyWith(_$GasFeeEstimateImpl value,
          $Res Function(_$GasFeeEstimateImpl) then) =
      __$$GasFeeEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String suggestedMaxPriorityFeePerGas,
      String suggestedMaxFeePerGas,
      int minWaitTimeEstimate,
      int maxWaitTimeEstimate});
}

/// @nodoc
class __$$GasFeeEstimateImplCopyWithImpl<$Res>
    extends _$GasFeeEstimateCopyWithImpl<$Res, _$GasFeeEstimateImpl>
    implements _$$GasFeeEstimateImplCopyWith<$Res> {
  __$$GasFeeEstimateImplCopyWithImpl(
      _$GasFeeEstimateImpl _value, $Res Function(_$GasFeeEstimateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(_$GasFeeEstimateImpl(
      suggestedMaxPriorityFeePerGas: null == suggestedMaxPriorityFeePerGas
          ? _value.suggestedMaxPriorityFeePerGas
          : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedMaxFeePerGas: null == suggestedMaxFeePerGas
          ? _value.suggestedMaxFeePerGas
          : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      minWaitTimeEstimate: null == minWaitTimeEstimate
          ? _value.minWaitTimeEstimate
          : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      maxWaitTimeEstimate: null == maxWaitTimeEstimate
          ? _value.maxWaitTimeEstimate
          : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasFeeEstimateImpl implements _GasFeeEstimate {
  _$GasFeeEstimateImpl(
      {required this.suggestedMaxPriorityFeePerGas,
      required this.suggestedMaxFeePerGas,
      required this.minWaitTimeEstimate,
      required this.maxWaitTimeEstimate});

  factory _$GasFeeEstimateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasFeeEstimateImplFromJson(json);

  @override
  final String suggestedMaxPriorityFeePerGas;
  @override
  final String suggestedMaxFeePerGas;
  @override
  final int minWaitTimeEstimate;
  @override
  final int maxWaitTimeEstimate;

  @override
  String toString() {
    return 'GasFeeEstimate(suggestedMaxPriorityFeePerGas: $suggestedMaxPriorityFeePerGas, suggestedMaxFeePerGas: $suggestedMaxFeePerGas, minWaitTimeEstimate: $minWaitTimeEstimate, maxWaitTimeEstimate: $maxWaitTimeEstimate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasFeeEstimateImpl &&
            (identical(other.suggestedMaxPriorityFeePerGas,
                    suggestedMaxPriorityFeePerGas) ||
                other.suggestedMaxPriorityFeePerGas ==
                    suggestedMaxPriorityFeePerGas) &&
            (identical(other.suggestedMaxFeePerGas, suggestedMaxFeePerGas) ||
                other.suggestedMaxFeePerGas == suggestedMaxFeePerGas) &&
            (identical(other.minWaitTimeEstimate, minWaitTimeEstimate) ||
                other.minWaitTimeEstimate == minWaitTimeEstimate) &&
            (identical(other.maxWaitTimeEstimate, maxWaitTimeEstimate) ||
                other.maxWaitTimeEstimate == maxWaitTimeEstimate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, suggestedMaxPriorityFeePerGas,
      suggestedMaxFeePerGas, minWaitTimeEstimate, maxWaitTimeEstimate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GasFeeEstimateImplCopyWith<_$GasFeeEstimateImpl> get copyWith =>
      __$$GasFeeEstimateImplCopyWithImpl<_$GasFeeEstimateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasFeeEstimateImplToJson(
      this,
    );
  }
}

abstract class _GasFeeEstimate implements GasFeeEstimate {
  factory _GasFeeEstimate(
      {required final String suggestedMaxPriorityFeePerGas,
      required final String suggestedMaxFeePerGas,
      required final int minWaitTimeEstimate,
      required final int maxWaitTimeEstimate}) = _$GasFeeEstimateImpl;

  factory _GasFeeEstimate.fromJson(Map<String, dynamic> json) =
      _$GasFeeEstimateImpl.fromJson;

  @override
  String get suggestedMaxPriorityFeePerGas;
  @override
  String get suggestedMaxFeePerGas;
  @override
  int get minWaitTimeEstimate;
  @override
  int get maxWaitTimeEstimate;
  @override
  @JsonKey(ignore: true)
  _$$GasFeeEstimateImplCopyWith<_$GasFeeEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
