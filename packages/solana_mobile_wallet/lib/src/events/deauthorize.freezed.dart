// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deauthorize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeauthorizeEvent {
  String? get identityName;
  Uri? get identityUri;
  Uri? get iconUri;

  /// Create a copy of DeauthorizeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeauthorizeEventCopyWith<DeauthorizeEvent> get copyWith =>
      _$DeauthorizeEventCopyWithImpl<DeauthorizeEvent>(this as DeauthorizeEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeauthorizeEvent &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconUri, iconUri) || other.iconUri == iconUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityName, identityUri, iconUri);

  @override
  String toString() {
    return 'DeauthorizeEvent(identityName: $identityName, identityUri: $identityUri, iconUri: $iconUri)';
  }
}

/// @nodoc
abstract mixin class $DeauthorizeEventCopyWith<$Res> {
  factory $DeauthorizeEventCopyWith(DeauthorizeEvent value, $Res Function(DeauthorizeEvent) _then) =
      _$DeauthorizeEventCopyWithImpl;
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class _$DeauthorizeEventCopyWithImpl<$Res> implements $DeauthorizeEventCopyWith<$Res> {
  _$DeauthorizeEventCopyWithImpl(this._self, this._then);

  final DeauthorizeEvent _self;
  final $Res Function(DeauthorizeEvent) _then;

  /// Create a copy of DeauthorizeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
  }) {
    return _then(
      _self.copyWith(
        identityName:
            freezed == identityName
                ? _self.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _self.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconUri:
            freezed == iconUri
                ? _self.iconUri
                : iconUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }
}

/// @nodoc

class _DeauthorizeEvent implements DeauthorizeEvent {
  const _DeauthorizeEvent({
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

  /// Create a copy of DeauthorizeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeauthorizeEventCopyWith<_DeauthorizeEvent> get copyWith =>
      __$DeauthorizeEventCopyWithImpl<_DeauthorizeEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeauthorizeEvent &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconUri, iconUri) || other.iconUri == iconUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityName, identityUri, iconUri);

  @override
  String toString() {
    return 'DeauthorizeEvent(identityName: $identityName, identityUri: $identityUri, iconUri: $iconUri)';
  }
}

/// @nodoc
abstract mixin class _$DeauthorizeEventCopyWith<$Res> implements $DeauthorizeEventCopyWith<$Res> {
  factory _$DeauthorizeEventCopyWith(
    _DeauthorizeEvent value,
    $Res Function(_DeauthorizeEvent) _then,
  ) = __$DeauthorizeEventCopyWithImpl;
  @override
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class __$DeauthorizeEventCopyWithImpl<$Res> implements _$DeauthorizeEventCopyWith<$Res> {
  __$DeauthorizeEventCopyWithImpl(this._self, this._then);

  final _DeauthorizeEvent _self;
  final $Res Function(_DeauthorizeEvent) _then;

  /// Create a copy of DeauthorizeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
  }) {
    return _then(
      _DeauthorizeEvent(
        identityName:
            freezed == identityName
                ? _self.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _self.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconUri:
            freezed == iconUri
                ? _self.iconUri
                : iconUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }
}
