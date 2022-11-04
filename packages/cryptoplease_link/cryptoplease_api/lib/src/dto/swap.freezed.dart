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

SwapResponseDto _$SwapResponseDtoFromJson(Map<String, dynamic> json) {
  return _SwapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SwapResponseDto {
  String get swapTransaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapResponseDtoCopyWith<SwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapResponseDtoCopyWith<$Res> {
  factory $SwapResponseDtoCopyWith(
          SwapResponseDto value, $Res Function(SwapResponseDto) then) =
      _$SwapResponseDtoCopyWithImpl<$Res>;
  $Res call({String swapTransaction});
}

/// @nodoc
class _$SwapResponseDtoCopyWithImpl<$Res>
    implements $SwapResponseDtoCopyWith<$Res> {
  _$SwapResponseDtoCopyWithImpl(this._value, this._then);

  final SwapResponseDto _value;
  // ignore: unused_field
  final $Res Function(SwapResponseDto) _then;

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
abstract class _$$_SwapResponseDtoCopyWith<$Res>
    implements $SwapResponseDtoCopyWith<$Res> {
  factory _$$_SwapResponseDtoCopyWith(
          _$_SwapResponseDto value, $Res Function(_$_SwapResponseDto) then) =
      __$$_SwapResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({String swapTransaction});
}

/// @nodoc
class __$$_SwapResponseDtoCopyWithImpl<$Res>
    extends _$SwapResponseDtoCopyWithImpl<$Res>
    implements _$$_SwapResponseDtoCopyWith<$Res> {
  __$$_SwapResponseDtoCopyWithImpl(
      _$_SwapResponseDto _value, $Res Function(_$_SwapResponseDto) _then)
      : super(_value, (v) => _then(v as _$_SwapResponseDto));

  @override
  _$_SwapResponseDto get _value => super._value as _$_SwapResponseDto;

  @override
  $Res call({
    Object? swapTransaction = freezed,
  }) {
    return _then(_$_SwapResponseDto(
      swapTransaction: swapTransaction == freezed
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapResponseDto implements _SwapResponseDto {
  const _$_SwapResponseDto({required this.swapTransaction});

  factory _$_SwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapResponseDtoFromJson(json);

  @override
  final String swapTransaction;

  @override
  String toString() {
    return 'SwapResponseDto(swapTransaction: $swapTransaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapResponseDto &&
            const DeepCollectionEquality()
                .equals(other.swapTransaction, swapTransaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(swapTransaction));

  @JsonKey(ignore: true)
  @override
  _$$_SwapResponseDtoCopyWith<_$_SwapResponseDto> get copyWith =>
      __$$_SwapResponseDtoCopyWithImpl<_$_SwapResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapResponseDtoToJson(
      this,
    );
  }
}

abstract class _SwapResponseDto implements SwapResponseDto {
  const factory _SwapResponseDto({required final String swapTransaction}) =
      _$_SwapResponseDto;

  factory _SwapResponseDto.fromJson(Map<String, dynamic> json) =
      _$_SwapResponseDto.fromJson;

  @override
  String get swapTransaction;
  @override
  @JsonKey(ignore: true)
  _$$_SwapResponseDtoCopyWith<_$_SwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}
