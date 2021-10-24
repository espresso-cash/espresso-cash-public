// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Result _$ResultFromJson(Map<String, dynamic> json) {
  switch (json['kind'] as String?) {
    case 'wrapped':
      return WrappedResult.fromJson(json);
    case 'simple':
      return SimpleResult.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'kind', 'Result', 'Invalid union type "${json['kind']}"!');
  }
}

/// @nodoc
class _$ResultTearOff {
  const _$ResultTearOff();

  WrappedResult wrapped(
      {required String type,
      required String description,
      bool nullable = false}) {
    return WrappedResult(
      type: type,
      description: description,
      nullable: nullable,
    );
  }

  SimpleResult simple(
      {required String type,
      required String description,
      bool nullable = false}) {
    return SimpleResult(
      type: type,
      description: description,
      nullable: nullable,
    );
  }

  Result fromJson(Map<String, Object> json) {
    return Result.fromJson(json);
  }
}

/// @nodoc
const $Result = _$ResultTearOff();

/// @nodoc
mixin _$Result {
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get nullable => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type, String description, bool nullable)
        wrapped,
    required TResult Function(String type, String description, bool nullable)
        simple,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WrappedResult value) wrapped,
    required TResult Function(SimpleResult value) simple,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultCopyWith<Result> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<$Res> {
  factory $ResultCopyWith(Result value, $Res Function(Result) then) =
      _$ResultCopyWithImpl<$Res>;
  $Res call({String type, String description, bool nullable});
}

/// @nodoc
class _$ResultCopyWithImpl<$Res> implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result _value;
  // ignore: unused_field
  final $Res Function(Result) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? description = freezed,
    Object? nullable = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class $WrappedResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory $WrappedResultCopyWith(
          WrappedResult value, $Res Function(WrappedResult) then) =
      _$WrappedResultCopyWithImpl<$Res>;
  @override
  $Res call({String type, String description, bool nullable});
}

/// @nodoc
class _$WrappedResultCopyWithImpl<$Res> extends _$ResultCopyWithImpl<$Res>
    implements $WrappedResultCopyWith<$Res> {
  _$WrappedResultCopyWithImpl(
      WrappedResult _value, $Res Function(WrappedResult) _then)
      : super(_value, (v) => _then(v as WrappedResult));

  @override
  WrappedResult get _value => super._value as WrappedResult;

  @override
  $Res call({
    Object? type = freezed,
    Object? description = freezed,
    Object? nullable = freezed,
  }) {
    return _then(WrappedResult(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('wrapped')
class _$WrappedResult extends WrappedResult {
  const _$WrappedResult(
      {required this.type, required this.description, this.nullable = false})
      : super._();

  factory _$WrappedResult.fromJson(Map<String, dynamic> json) =>
      _$$WrappedResultFromJson(json);

  @override
  final String type;
  @override
  final String description;
  @JsonKey(defaultValue: false)
  @override
  final bool nullable;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WrappedResult &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.nullable, nullable) ||
                const DeepCollectionEquality()
                    .equals(other.nullable, nullable)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(nullable);

  @JsonKey(ignore: true)
  @override
  $WrappedResultCopyWith<WrappedResult> get copyWith =>
      _$WrappedResultCopyWithImpl<WrappedResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type, String description, bool nullable)
        wrapped,
    required TResult Function(String type, String description, bool nullable)
        simple,
  }) {
    return wrapped(type, description, nullable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
  }) {
    return wrapped?.call(type, description, nullable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
    required TResult orElse(),
  }) {
    if (wrapped != null) {
      return wrapped(type, description, nullable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WrappedResult value) wrapped,
    required TResult Function(SimpleResult value) simple,
  }) {
    return wrapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
  }) {
    return wrapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
    required TResult orElse(),
  }) {
    if (wrapped != null) {
      return wrapped(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WrappedResultToJson(this)..['kind'] = 'wrapped';
  }
}

abstract class WrappedResult extends Result {
  const factory WrappedResult(
      {required String type,
      required String description,
      bool nullable}) = _$WrappedResult;
  const WrappedResult._() : super._();

  factory WrappedResult.fromJson(Map<String, dynamic> json) =
      _$WrappedResult.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  bool get nullable => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $WrappedResultCopyWith<WrappedResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory $SimpleResultCopyWith(
          SimpleResult value, $Res Function(SimpleResult) then) =
      _$SimpleResultCopyWithImpl<$Res>;
  @override
  $Res call({String type, String description, bool nullable});
}

/// @nodoc
class _$SimpleResultCopyWithImpl<$Res> extends _$ResultCopyWithImpl<$Res>
    implements $SimpleResultCopyWith<$Res> {
  _$SimpleResultCopyWithImpl(
      SimpleResult _value, $Res Function(SimpleResult) _then)
      : super(_value, (v) => _then(v as SimpleResult));

  @override
  SimpleResult get _value => super._value as SimpleResult;

  @override
  $Res call({
    Object? type = freezed,
    Object? description = freezed,
    Object? nullable = freezed,
  }) {
    return _then(SimpleResult(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      nullable: nullable == freezed
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('simple')
class _$SimpleResult extends SimpleResult {
  const _$SimpleResult(
      {required this.type, required this.description, this.nullable = false})
      : super._();

  factory _$SimpleResult.fromJson(Map<String, dynamic> json) =>
      _$$SimpleResultFromJson(json);

  @override
  final String type;
  @override
  final String description;
  @JsonKey(defaultValue: false)
  @override
  final bool nullable;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SimpleResult &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.nullable, nullable) ||
                const DeepCollectionEquality()
                    .equals(other.nullable, nullable)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(nullable);

  @JsonKey(ignore: true)
  @override
  $SimpleResultCopyWith<SimpleResult> get copyWith =>
      _$SimpleResultCopyWithImpl<SimpleResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type, String description, bool nullable)
        wrapped,
    required TResult Function(String type, String description, bool nullable)
        simple,
  }) {
    return simple(type, description, nullable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
  }) {
    return simple?.call(type, description, nullable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type, String description, bool nullable)? wrapped,
    TResult Function(String type, String description, bool nullable)? simple,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(type, description, nullable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WrappedResult value) wrapped,
    required TResult Function(SimpleResult value) simple,
  }) {
    return simple(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
  }) {
    return simple?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WrappedResult value)? wrapped,
    TResult Function(SimpleResult value)? simple,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleResultToJson(this)..['kind'] = 'simple';
  }
}

abstract class SimpleResult extends Result {
  const factory SimpleResult(
      {required String type,
      required String description,
      bool nullable}) = _$SimpleResult;
  const SimpleResult._() : super._();

  factory SimpleResult.fromJson(Map<String, dynamic> json) =
      _$SimpleResult.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  bool get nullable => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $SimpleResultCopyWith<SimpleResult> get copyWith =>
      throw _privateConstructorUsedError;
}
