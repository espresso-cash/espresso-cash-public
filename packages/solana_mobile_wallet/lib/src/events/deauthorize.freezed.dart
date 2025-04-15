// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deauthorize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DeauthorizeEvent {
  String? get identityName => throw _privateConstructorUsedError;
  Uri? get identityUri => throw _privateConstructorUsedError;
  Uri? get iconUri => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeauthorizeEventCopyWith<DeauthorizeEvent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeauthorizeEventCopyWith<$Res> {
  factory $DeauthorizeEventCopyWith(DeauthorizeEvent value, $Res Function(DeauthorizeEvent) then) =
      _$DeauthorizeEventCopyWithImpl<$Res, DeauthorizeEvent>;
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class _$DeauthorizeEventCopyWithImpl<$Res, $Val extends DeauthorizeEvent>
    implements $DeauthorizeEventCopyWith<$Res> {
  _$DeauthorizeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
  }) {
    return _then(
      _value.copyWith(
            identityName:
                freezed == identityName
                    ? _value.identityName
                    : identityName // ignore: cast_nullable_to_non_nullable
                        as String?,
            identityUri:
                freezed == identityUri
                    ? _value.identityUri
                    : identityUri // ignore: cast_nullable_to_non_nullable
                        as Uri?,
            iconUri:
                freezed == iconUri
                    ? _value.iconUri
                    : iconUri // ignore: cast_nullable_to_non_nullable
                        as Uri?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeauthorizeEventImplCopyWith<$Res> implements $DeauthorizeEventCopyWith<$Res> {
  factory _$$DeauthorizeEventImplCopyWith(
    _$DeauthorizeEventImpl value,
    $Res Function(_$DeauthorizeEventImpl) then,
  ) = __$$DeauthorizeEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class __$$DeauthorizeEventImplCopyWithImpl<$Res>
    extends _$DeauthorizeEventCopyWithImpl<$Res, _$DeauthorizeEventImpl>
    implements _$$DeauthorizeEventImplCopyWith<$Res> {
  __$$DeauthorizeEventImplCopyWithImpl(
    _$DeauthorizeEventImpl _value,
    $Res Function(_$DeauthorizeEventImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
  }) {
    return _then(
      _$DeauthorizeEventImpl(
        identityName:
            freezed == identityName
                ? _value.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _value.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconUri:
            freezed == iconUri
                ? _value.iconUri
                : iconUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }
}

/// @nodoc

class _$DeauthorizeEventImpl implements _DeauthorizeEvent {
  const _$DeauthorizeEventImpl({
    required this.identityName,
    required this.identityUri,
    required this.iconUri,
  });

  @override
  final String? identityName;
  @override
  final Uri? identityUri;
  @override
  final Uri? iconUri;

  @override
  String toString() {
    return 'DeauthorizeEvent(identityName: $identityName, identityUri: $identityUri, iconUri: $iconUri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeauthorizeEventImpl &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconUri, iconUri) || other.iconUri == iconUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityName, identityUri, iconUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeauthorizeEventImplCopyWith<_$DeauthorizeEventImpl> get copyWith =>
      __$$DeauthorizeEventImplCopyWithImpl<_$DeauthorizeEventImpl>(this, _$identity);
}

abstract class _DeauthorizeEvent implements DeauthorizeEvent {
  const factory _DeauthorizeEvent({
    required final String? identityName,
    required final Uri? identityUri,
    required final Uri? iconUri,
  }) = _$DeauthorizeEventImpl;

  @override
  String? get identityName;
  @override
  Uri? get identityUri;
  @override
  Uri? get iconUri;
  @override
  @JsonKey(ignore: true)
  _$$DeauthorizeEventImplCopyWith<_$DeauthorizeEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
