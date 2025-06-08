// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GasFeeRequestDto {
  String get network;

  /// Create a copy of GasFeeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GasFeeRequestDtoCopyWith<GasFeeRequestDto> get copyWith =>
      _$GasFeeRequestDtoCopyWithImpl<GasFeeRequestDto>(this as GasFeeRequestDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GasFeeRequestDto &&
            (identical(other.network, network) || other.network == network));
  }

  @override
  int get hashCode => Object.hash(runtimeType, network);

  @override
  String toString() {
    return 'GasFeeRequestDto(network: $network)';
  }
}

/// @nodoc
abstract mixin class $GasFeeRequestDtoCopyWith<$Res> {
  factory $GasFeeRequestDtoCopyWith(GasFeeRequestDto value, $Res Function(GasFeeRequestDto) _then) =
      _$GasFeeRequestDtoCopyWithImpl;
  @useResult
  $Res call({String network});
}

/// @nodoc
class _$GasFeeRequestDtoCopyWithImpl<$Res> implements $GasFeeRequestDtoCopyWith<$Res> {
  _$GasFeeRequestDtoCopyWithImpl(this._self, this._then);

  final GasFeeRequestDto _self;
  final $Res Function(GasFeeRequestDto) _then;

  /// Create a copy of GasFeeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? network = null}) {
    return _then(
      _self.copyWith(
        network:
            null == network
                ? _self.network
                : network // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _GasFeeRequestDto implements GasFeeRequestDto {
  const _GasFeeRequestDto({required this.network});

  @override
  final String network;

  /// Create a copy of GasFeeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GasFeeRequestDtoCopyWith<_GasFeeRequestDto> get copyWith =>
      __$GasFeeRequestDtoCopyWithImpl<_GasFeeRequestDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GasFeeRequestDto &&
            (identical(other.network, network) || other.network == network));
  }

  @override
  int get hashCode => Object.hash(runtimeType, network);

  @override
  String toString() {
    return 'GasFeeRequestDto(network: $network)';
  }
}

/// @nodoc
abstract mixin class _$GasFeeRequestDtoCopyWith<$Res> implements $GasFeeRequestDtoCopyWith<$Res> {
  factory _$GasFeeRequestDtoCopyWith(
    _GasFeeRequestDto value,
    $Res Function(_GasFeeRequestDto) _then,
  ) = __$GasFeeRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String network});
}

/// @nodoc
class __$GasFeeRequestDtoCopyWithImpl<$Res> implements _$GasFeeRequestDtoCopyWith<$Res> {
  __$GasFeeRequestDtoCopyWithImpl(this._self, this._then);

  final _GasFeeRequestDto _self;
  final $Res Function(_GasFeeRequestDto) _then;

  /// Create a copy of GasFeeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? network = null}) {
    return _then(
      _GasFeeRequestDto(
        network:
            null == network
                ? _self.network
                : network // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$GasFeeResponseDto {
  GasFeeEstimate get low;
  GasFeeEstimate get medium;
  GasFeeEstimate get high;
  String get estimatedBaseFee;
  double get networkCongestion;

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GasFeeResponseDtoCopyWith<GasFeeResponseDto> get copyWith =>
      _$GasFeeResponseDtoCopyWithImpl<GasFeeResponseDto>(this as GasFeeResponseDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GasFeeResponseDto &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.estimatedBaseFee, estimatedBaseFee) ||
                other.estimatedBaseFee == estimatedBaseFee) &&
            (identical(other.networkCongestion, networkCongestion) ||
                other.networkCongestion == networkCongestion));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, low, medium, high, estimatedBaseFee, networkCongestion);

  @override
  String toString() {
    return 'GasFeeResponseDto(low: $low, medium: $medium, high: $high, estimatedBaseFee: $estimatedBaseFee, networkCongestion: $networkCongestion)';
  }
}

/// @nodoc
abstract mixin class $GasFeeResponseDtoCopyWith<$Res> {
  factory $GasFeeResponseDtoCopyWith(
    GasFeeResponseDto value,
    $Res Function(GasFeeResponseDto) _then,
  ) = _$GasFeeResponseDtoCopyWithImpl;
  @useResult
  $Res call({
    GasFeeEstimate low,
    GasFeeEstimate medium,
    GasFeeEstimate high,
    String estimatedBaseFee,
    double networkCongestion,
  });

  $GasFeeEstimateCopyWith<$Res> get low;
  $GasFeeEstimateCopyWith<$Res> get medium;
  $GasFeeEstimateCopyWith<$Res> get high;
}

/// @nodoc
class _$GasFeeResponseDtoCopyWithImpl<$Res> implements $GasFeeResponseDtoCopyWith<$Res> {
  _$GasFeeResponseDtoCopyWithImpl(this._self, this._then);

  final GasFeeResponseDto _self;
  final $Res Function(GasFeeResponseDto) _then;

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
  }) {
    return _then(
      _self.copyWith(
        low:
            null == low
                ? _self.low
                : low // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        medium:
            null == medium
                ? _self.medium
                : medium // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        high:
            null == high
                ? _self.high
                : high // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        estimatedBaseFee:
            null == estimatedBaseFee
                ? _self.estimatedBaseFee
                : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
                    as String,
        networkCongestion:
            null == networkCongestion
                ? _self.networkCongestion
                : networkCongestion // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get low {
    return $GasFeeEstimateCopyWith<$Res>(_self.low, (value) {
      return _then(_self.copyWith(low: value));
    });
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get medium {
    return $GasFeeEstimateCopyWith<$Res>(_self.medium, (value) {
      return _then(_self.copyWith(medium: value));
    });
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get high {
    return $GasFeeEstimateCopyWith<$Res>(_self.high, (value) {
      return _then(_self.copyWith(high: value));
    });
  }
}

/// @nodoc

class _GasFeeResponseDto implements GasFeeResponseDto {
  const _GasFeeResponseDto({
    required this.low,
    required this.medium,
    required this.high,
    required this.estimatedBaseFee,
    required this.networkCongestion,
  });

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

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GasFeeResponseDtoCopyWith<_GasFeeResponseDto> get copyWith =>
      __$GasFeeResponseDtoCopyWithImpl<_GasFeeResponseDto>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GasFeeResponseDto &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.estimatedBaseFee, estimatedBaseFee) ||
                other.estimatedBaseFee == estimatedBaseFee) &&
            (identical(other.networkCongestion, networkCongestion) ||
                other.networkCongestion == networkCongestion));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, low, medium, high, estimatedBaseFee, networkCongestion);

  @override
  String toString() {
    return 'GasFeeResponseDto(low: $low, medium: $medium, high: $high, estimatedBaseFee: $estimatedBaseFee, networkCongestion: $networkCongestion)';
  }
}

/// @nodoc
abstract mixin class _$GasFeeResponseDtoCopyWith<$Res> implements $GasFeeResponseDtoCopyWith<$Res> {
  factory _$GasFeeResponseDtoCopyWith(
    _GasFeeResponseDto value,
    $Res Function(_GasFeeResponseDto) _then,
  ) = __$GasFeeResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({
    GasFeeEstimate low,
    GasFeeEstimate medium,
    GasFeeEstimate high,
    String estimatedBaseFee,
    double networkCongestion,
  });

  @override
  $GasFeeEstimateCopyWith<$Res> get low;
  @override
  $GasFeeEstimateCopyWith<$Res> get medium;
  @override
  $GasFeeEstimateCopyWith<$Res> get high;
}

/// @nodoc
class __$GasFeeResponseDtoCopyWithImpl<$Res> implements _$GasFeeResponseDtoCopyWith<$Res> {
  __$GasFeeResponseDtoCopyWithImpl(this._self, this._then);

  final _GasFeeResponseDto _self;
  final $Res Function(_GasFeeResponseDto) _then;

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
  }) {
    return _then(
      _GasFeeResponseDto(
        low:
            null == low
                ? _self.low
                : low // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        medium:
            null == medium
                ? _self.medium
                : medium // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        high:
            null == high
                ? _self.high
                : high // ignore: cast_nullable_to_non_nullable
                    as GasFeeEstimate,
        estimatedBaseFee:
            null == estimatedBaseFee
                ? _self.estimatedBaseFee
                : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
                    as String,
        networkCongestion:
            null == networkCongestion
                ? _self.networkCongestion
                : networkCongestion // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get low {
    return $GasFeeEstimateCopyWith<$Res>(_self.low, (value) {
      return _then(_self.copyWith(low: value));
    });
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get medium {
    return $GasFeeEstimateCopyWith<$Res>(_self.medium, (value) {
      return _then(_self.copyWith(medium: value));
    });
  }

  /// Create a copy of GasFeeResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<$Res> get high {
    return $GasFeeEstimateCopyWith<$Res>(_self.high, (value) {
      return _then(_self.copyWith(high: value));
    });
  }
}

/// @nodoc
mixin _$GasFeeEstimate {
  String get suggestedMaxPriorityFeePerGas;
  String get suggestedMaxFeePerGas;
  int get minWaitTimeEstimate;
  int get maxWaitTimeEstimate;

  /// Create a copy of GasFeeEstimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GasFeeEstimateCopyWith<GasFeeEstimate> get copyWith =>
      _$GasFeeEstimateCopyWithImpl<GasFeeEstimate>(this as GasFeeEstimate, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GasFeeEstimate &&
            (identical(other.suggestedMaxPriorityFeePerGas, suggestedMaxPriorityFeePerGas) ||
                other.suggestedMaxPriorityFeePerGas == suggestedMaxPriorityFeePerGas) &&
            (identical(other.suggestedMaxFeePerGas, suggestedMaxFeePerGas) ||
                other.suggestedMaxFeePerGas == suggestedMaxFeePerGas) &&
            (identical(other.minWaitTimeEstimate, minWaitTimeEstimate) ||
                other.minWaitTimeEstimate == minWaitTimeEstimate) &&
            (identical(other.maxWaitTimeEstimate, maxWaitTimeEstimate) ||
                other.maxWaitTimeEstimate == maxWaitTimeEstimate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    suggestedMaxPriorityFeePerGas,
    suggestedMaxFeePerGas,
    minWaitTimeEstimate,
    maxWaitTimeEstimate,
  );

  @override
  String toString() {
    return 'GasFeeEstimate(suggestedMaxPriorityFeePerGas: $suggestedMaxPriorityFeePerGas, suggestedMaxFeePerGas: $suggestedMaxFeePerGas, minWaitTimeEstimate: $minWaitTimeEstimate, maxWaitTimeEstimate: $maxWaitTimeEstimate)';
  }
}

/// @nodoc
abstract mixin class $GasFeeEstimateCopyWith<$Res> {
  factory $GasFeeEstimateCopyWith(GasFeeEstimate value, $Res Function(GasFeeEstimate) _then) =
      _$GasFeeEstimateCopyWithImpl;
  @useResult
  $Res call({
    String suggestedMaxPriorityFeePerGas,
    String suggestedMaxFeePerGas,
    int minWaitTimeEstimate,
    int maxWaitTimeEstimate,
  });
}

/// @nodoc
class _$GasFeeEstimateCopyWithImpl<$Res> implements $GasFeeEstimateCopyWith<$Res> {
  _$GasFeeEstimateCopyWithImpl(this._self, this._then);

  final GasFeeEstimate _self;
  final $Res Function(GasFeeEstimate) _then;

  /// Create a copy of GasFeeEstimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(
      _self.copyWith(
        suggestedMaxPriorityFeePerGas:
            null == suggestedMaxPriorityFeePerGas
                ? _self.suggestedMaxPriorityFeePerGas
                : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
                    as String,
        suggestedMaxFeePerGas:
            null == suggestedMaxFeePerGas
                ? _self.suggestedMaxFeePerGas
                : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
                    as String,
        minWaitTimeEstimate:
            null == minWaitTimeEstimate
                ? _self.minWaitTimeEstimate
                : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
                    as int,
        maxWaitTimeEstimate:
            null == maxWaitTimeEstimate
                ? _self.maxWaitTimeEstimate
                : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _GasFeeEstimate implements GasFeeEstimate {
  _GasFeeEstimate({
    required this.suggestedMaxPriorityFeePerGas,
    required this.suggestedMaxFeePerGas,
    required this.minWaitTimeEstimate,
    required this.maxWaitTimeEstimate,
  });

  @override
  final String suggestedMaxPriorityFeePerGas;
  @override
  final String suggestedMaxFeePerGas;
  @override
  final int minWaitTimeEstimate;
  @override
  final int maxWaitTimeEstimate;

  /// Create a copy of GasFeeEstimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GasFeeEstimateCopyWith<_GasFeeEstimate> get copyWith =>
      __$GasFeeEstimateCopyWithImpl<_GasFeeEstimate>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GasFeeEstimate &&
            (identical(other.suggestedMaxPriorityFeePerGas, suggestedMaxPriorityFeePerGas) ||
                other.suggestedMaxPriorityFeePerGas == suggestedMaxPriorityFeePerGas) &&
            (identical(other.suggestedMaxFeePerGas, suggestedMaxFeePerGas) ||
                other.suggestedMaxFeePerGas == suggestedMaxFeePerGas) &&
            (identical(other.minWaitTimeEstimate, minWaitTimeEstimate) ||
                other.minWaitTimeEstimate == minWaitTimeEstimate) &&
            (identical(other.maxWaitTimeEstimate, maxWaitTimeEstimate) ||
                other.maxWaitTimeEstimate == maxWaitTimeEstimate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    suggestedMaxPriorityFeePerGas,
    suggestedMaxFeePerGas,
    minWaitTimeEstimate,
    maxWaitTimeEstimate,
  );

  @override
  String toString() {
    return 'GasFeeEstimate(suggestedMaxPriorityFeePerGas: $suggestedMaxPriorityFeePerGas, suggestedMaxFeePerGas: $suggestedMaxFeePerGas, minWaitTimeEstimate: $minWaitTimeEstimate, maxWaitTimeEstimate: $maxWaitTimeEstimate)';
  }
}

/// @nodoc
abstract mixin class _$GasFeeEstimateCopyWith<$Res> implements $GasFeeEstimateCopyWith<$Res> {
  factory _$GasFeeEstimateCopyWith(_GasFeeEstimate value, $Res Function(_GasFeeEstimate) _then) =
      __$GasFeeEstimateCopyWithImpl;
  @override
  @useResult
  $Res call({
    String suggestedMaxPriorityFeePerGas,
    String suggestedMaxFeePerGas,
    int minWaitTimeEstimate,
    int maxWaitTimeEstimate,
  });
}

/// @nodoc
class __$GasFeeEstimateCopyWithImpl<$Res> implements _$GasFeeEstimateCopyWith<$Res> {
  __$GasFeeEstimateCopyWithImpl(this._self, this._then);

  final _GasFeeEstimate _self;
  final $Res Function(_GasFeeEstimate) _then;

  /// Create a copy of GasFeeEstimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(
      _GasFeeEstimate(
        suggestedMaxPriorityFeePerGas:
            null == suggestedMaxPriorityFeePerGas
                ? _self.suggestedMaxPriorityFeePerGas
                : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
                    as String,
        suggestedMaxFeePerGas:
            null == suggestedMaxFeePerGas
                ? _self.suggestedMaxFeePerGas
                : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
                    as String,
        minWaitTimeEstimate:
            null == minWaitTimeEstimate
                ? _self.minWaitTimeEstimate
                : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
                    as int,
        maxWaitTimeEstimate:
            null == maxWaitTimeEstimate
                ? _self.maxWaitTimeEstimate
                : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
