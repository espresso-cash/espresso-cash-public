// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seed_vault_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeedVaultNotification {
  List<Uri> get uris;
  int get flags;

  /// Create a copy of SeedVaultNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeedVaultNotificationCopyWith<SeedVaultNotification> get copyWith =>
      _$SeedVaultNotificationCopyWithImpl<SeedVaultNotification>(
        this as SeedVaultNotification,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeedVaultNotification &&
            const DeepCollectionEquality().equals(other.uris, uris) &&
            (identical(other.flags, flags) || other.flags == flags));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(uris), flags);

  @override
  String toString() {
    return 'SeedVaultNotification(uris: $uris, flags: $flags)';
  }
}

/// @nodoc
abstract mixin class $SeedVaultNotificationCopyWith<$Res> {
  factory $SeedVaultNotificationCopyWith(
    SeedVaultNotification value,
    $Res Function(SeedVaultNotification) _then,
  ) = _$SeedVaultNotificationCopyWithImpl;
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class _$SeedVaultNotificationCopyWithImpl<$Res> implements $SeedVaultNotificationCopyWith<$Res> {
  _$SeedVaultNotificationCopyWithImpl(this._self, this._then);

  final SeedVaultNotification _self;
  final $Res Function(SeedVaultNotification) _then;

  /// Create a copy of SeedVaultNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uris = null, Object? flags = null}) {
    return _then(
      _self.copyWith(
        uris:
            null == uris
                ? _self.uris
                : uris // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
        flags:
            null == flags
                ? _self.flags
                : flags // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _SeedVaultNotification implements SeedVaultNotification {
  const _SeedVaultNotification({required final List<Uri> uris, required this.flags}) : _uris = uris;

  final List<Uri> _uris;
  @override
  List<Uri> get uris {
    if (_uris is EqualUnmodifiableListView) return _uris;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uris);
  }

  @override
  final int flags;

  /// Create a copy of SeedVaultNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeedVaultNotificationCopyWith<_SeedVaultNotification> get copyWith =>
      __$SeedVaultNotificationCopyWithImpl<_SeedVaultNotification>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeedVaultNotification &&
            const DeepCollectionEquality().equals(other._uris, _uris) &&
            (identical(other.flags, flags) || other.flags == flags));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_uris), flags);

  @override
  String toString() {
    return 'SeedVaultNotification(uris: $uris, flags: $flags)';
  }
}

/// @nodoc
abstract mixin class _$SeedVaultNotificationCopyWith<$Res>
    implements $SeedVaultNotificationCopyWith<$Res> {
  factory _$SeedVaultNotificationCopyWith(
    _SeedVaultNotification value,
    $Res Function(_SeedVaultNotification) _then,
  ) = __$SeedVaultNotificationCopyWithImpl;
  @override
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class __$SeedVaultNotificationCopyWithImpl<$Res> implements _$SeedVaultNotificationCopyWith<$Res> {
  __$SeedVaultNotificationCopyWithImpl(this._self, this._then);

  final _SeedVaultNotification _self;
  final $Res Function(_SeedVaultNotification) _then;

  /// Create a copy of SeedVaultNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? uris = null, Object? flags = null}) {
    return _then(
      _SeedVaultNotification(
        uris:
            null == uris
                ? _self._uris
                : uris // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
        flags:
            null == flags
                ? _self.flags
                : flags // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}
