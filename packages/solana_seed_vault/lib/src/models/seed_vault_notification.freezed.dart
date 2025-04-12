// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seed_vault_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SeedVaultNotification {
  List<Uri> get uris => throw _privateConstructorUsedError;
  int get flags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeedVaultNotificationCopyWith<SeedVaultNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeedVaultNotificationCopyWith<$Res> {
  factory $SeedVaultNotificationCopyWith(
    SeedVaultNotification value,
    $Res Function(SeedVaultNotification) then,
  ) = _$SeedVaultNotificationCopyWithImpl<$Res, SeedVaultNotification>;
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class _$SeedVaultNotificationCopyWithImpl<$Res, $Val extends SeedVaultNotification>
    implements $SeedVaultNotificationCopyWith<$Res> {
  _$SeedVaultNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uris = null, Object? flags = null}) {
    return _then(
      _value.copyWith(
            uris:
                null == uris
                    ? _value.uris
                    : uris // ignore: cast_nullable_to_non_nullable
                        as List<Uri>,
            flags:
                null == flags
                    ? _value.flags
                    : flags // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeedVaultNotificationImplCopyWith<$Res>
    implements $SeedVaultNotificationCopyWith<$Res> {
  factory _$$SeedVaultNotificationImplCopyWith(
    _$SeedVaultNotificationImpl value,
    $Res Function(_$SeedVaultNotificationImpl) then,
  ) = __$$SeedVaultNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class __$$SeedVaultNotificationImplCopyWithImpl<$Res>
    extends _$SeedVaultNotificationCopyWithImpl<$Res, _$SeedVaultNotificationImpl>
    implements _$$SeedVaultNotificationImplCopyWith<$Res> {
  __$$SeedVaultNotificationImplCopyWithImpl(
    _$SeedVaultNotificationImpl _value,
    $Res Function(_$SeedVaultNotificationImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uris = null, Object? flags = null}) {
    return _then(
      _$SeedVaultNotificationImpl(
        uris:
            null == uris
                ? _value._uris
                : uris // ignore: cast_nullable_to_non_nullable
                    as List<Uri>,
        flags:
            null == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$SeedVaultNotificationImpl implements _SeedVaultNotification {
  const _$SeedVaultNotificationImpl({required final List<Uri> uris, required this.flags})
    : _uris = uris;

  final List<Uri> _uris;
  @override
  List<Uri> get uris {
    if (_uris is EqualUnmodifiableListView) return _uris;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uris);
  }

  @override
  final int flags;

  @override
  String toString() {
    return 'SeedVaultNotification(uris: $uris, flags: $flags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeedVaultNotificationImpl &&
            const DeepCollectionEquality().equals(other._uris, _uris) &&
            (identical(other.flags, flags) || other.flags == flags));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_uris), flags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeedVaultNotificationImplCopyWith<_$SeedVaultNotificationImpl> get copyWith =>
      __$$SeedVaultNotificationImplCopyWithImpl<_$SeedVaultNotificationImpl>(this, _$identity);
}

abstract class _SeedVaultNotification implements SeedVaultNotification {
  const factory _SeedVaultNotification({required final List<Uri> uris, required final int flags}) =
      _$SeedVaultNotificationImpl;

  @override
  List<Uri> get uris;
  @override
  int get flags;
  @override
  @JsonKey(ignore: true)
  _$$SeedVaultNotificationImplCopyWith<_$SeedVaultNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
