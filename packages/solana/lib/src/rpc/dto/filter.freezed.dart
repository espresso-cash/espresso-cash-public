// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Filter _$FilterFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
    case 'dataSize':
      return DataSizeFilter.fromJson(json);
    case 'memcmp':
      return MemcmpFilter.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Filter',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

  DataSizeFilter dataSize(int dataSize) {
    return DataSizeFilter(
      dataSize,
    );
  }

  MemcmpFilter memcmp({required int offset, required String bytes}) {
    return MemcmpFilter(
      offset: offset,
      bytes: bytes,
    );
  }

  Filter fromJson(Map<String, Object> json) {
    return Filter.fromJson(json);
  }
}

/// @nodoc
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int dataSize) dataSize,
    required TResult Function(int offset, String bytes) memcmp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSizeFilter value) dataSize,
    required TResult Function(MemcmpFilter value) memcmp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;
}

/// @nodoc
abstract class $DataSizeFilterCopyWith<$Res> {
  factory $DataSizeFilterCopyWith(
          DataSizeFilter value, $Res Function(DataSizeFilter) then) =
      _$DataSizeFilterCopyWithImpl<$Res>;
  $Res call({int dataSize});
}

/// @nodoc
class _$DataSizeFilterCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $DataSizeFilterCopyWith<$Res> {
  _$DataSizeFilterCopyWithImpl(
      DataSizeFilter _value, $Res Function(DataSizeFilter) _then)
      : super(_value, (v) => _then(v as DataSizeFilter));

  @override
  DataSizeFilter get _value => super._value as DataSizeFilter;

  @override
  $Res call({
    Object? dataSize = freezed,
  }) {
    return _then(DataSizeFilter(
      dataSize == freezed
          ? _value.dataSize
          : dataSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSizeFilter implements DataSizeFilter {
  const _$DataSizeFilter(this.dataSize);

  factory _$DataSizeFilter.fromJson(Map<String, dynamic> json) =>
      _$$DataSizeFilterFromJson(json);

  @override
  final int dataSize;

  @override
  String toString() {
    return 'Filter.dataSize(dataSize: $dataSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DataSizeFilter &&
            (identical(other.dataSize, dataSize) ||
                const DeepCollectionEquality()
                    .equals(other.dataSize, dataSize)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(dataSize);

  @JsonKey(ignore: true)
  @override
  $DataSizeFilterCopyWith<DataSizeFilter> get copyWith =>
      _$DataSizeFilterCopyWithImpl<DataSizeFilter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int dataSize) dataSize,
    required TResult Function(int offset, String bytes) memcmp,
  }) {
    return dataSize(this.dataSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
  }) {
    return dataSize?.call(this.dataSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
    required TResult orElse(),
  }) {
    if (dataSize != null) {
      return dataSize(this.dataSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSizeFilter value) dataSize,
    required TResult Function(MemcmpFilter value) memcmp,
  }) {
    return dataSize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
  }) {
    return dataSize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
    required TResult orElse(),
  }) {
    if (dataSize != null) {
      return dataSize(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSizeFilterToJson(this)..['runtimeType'] = 'dataSize';
  }
}

abstract class DataSizeFilter implements Filter {
  const factory DataSizeFilter(int dataSize) = _$DataSizeFilter;

  factory DataSizeFilter.fromJson(Map<String, dynamic> json) =
      _$DataSizeFilter.fromJson;

  int get dataSize => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSizeFilterCopyWith<DataSizeFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemcmpFilterCopyWith<$Res> {
  factory $MemcmpFilterCopyWith(
          MemcmpFilter value, $Res Function(MemcmpFilter) then) =
      _$MemcmpFilterCopyWithImpl<$Res>;
  $Res call({int offset, String bytes});
}

/// @nodoc
class _$MemcmpFilterCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements $MemcmpFilterCopyWith<$Res> {
  _$MemcmpFilterCopyWithImpl(
      MemcmpFilter _value, $Res Function(MemcmpFilter) _then)
      : super(_value, (v) => _then(v as MemcmpFilter));

  @override
  MemcmpFilter get _value => super._value as MemcmpFilter;

  @override
  $Res call({
    Object? offset = freezed,
    Object? bytes = freezed,
  }) {
    return _then(MemcmpFilter(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      bytes: bytes == freezed
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemcmpFilter implements MemcmpFilter {
  const _$MemcmpFilter({required this.offset, required this.bytes});

  factory _$MemcmpFilter.fromJson(Map<String, dynamic> json) =>
      _$$MemcmpFilterFromJson(json);

  @override
  final int offset;
  @override
  final String bytes;

  @override
  String toString() {
    return 'Filter.memcmp(offset: $offset, bytes: $bytes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MemcmpFilter &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.bytes, bytes) ||
                const DeepCollectionEquality().equals(other.bytes, bytes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(offset) ^
      const DeepCollectionEquality().hash(bytes);

  @JsonKey(ignore: true)
  @override
  $MemcmpFilterCopyWith<MemcmpFilter> get copyWith =>
      _$MemcmpFilterCopyWithImpl<MemcmpFilter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int dataSize) dataSize,
    required TResult Function(int offset, String bytes) memcmp,
  }) {
    return memcmp(offset, bytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
  }) {
    return memcmp?.call(offset, bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int dataSize)? dataSize,
    TResult Function(int offset, String bytes)? memcmp,
    required TResult orElse(),
  }) {
    if (memcmp != null) {
      return memcmp(offset, bytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSizeFilter value) dataSize,
    required TResult Function(MemcmpFilter value) memcmp,
  }) {
    return memcmp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
  }) {
    return memcmp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSizeFilter value)? dataSize,
    TResult Function(MemcmpFilter value)? memcmp,
    required TResult orElse(),
  }) {
    if (memcmp != null) {
      return memcmp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MemcmpFilterToJson(this)..['runtimeType'] = 'memcmp';
  }
}

abstract class MemcmpFilter implements Filter {
  const factory MemcmpFilter({required int offset, required String bytes}) =
      _$MemcmpFilter;

  factory MemcmpFilter.fromJson(Map<String, dynamic> json) =
      _$MemcmpFilter.fromJson;

  int get offset => throw _privateConstructorUsedError;
  String get bytes => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemcmpFilterCopyWith<MemcmpFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
