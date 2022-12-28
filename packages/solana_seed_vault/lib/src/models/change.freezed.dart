// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChangeNotified {
  List<Uri> get uris => throw _privateConstructorUsedError;
  int get flags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeNotifiedCopyWith<ChangeNotified> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeNotifiedCopyWith<$Res> {
  factory $ChangeNotifiedCopyWith(
          ChangeNotified value, $Res Function(ChangeNotified) then) =
      _$ChangeNotifiedCopyWithImpl<$Res, ChangeNotified>;
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class _$ChangeNotifiedCopyWithImpl<$Res, $Val extends ChangeNotified>
    implements $ChangeNotifiedCopyWith<$Res> {
  _$ChangeNotifiedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uris = null,
    Object? flags = null,
  }) {
    return _then(_value.copyWith(
      uris: null == uris
          ? _value.uris
          : uris // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChangeNotifiedCopyWith<$Res>
    implements $ChangeNotifiedCopyWith<$Res> {
  factory _$$_ChangeNotifiedCopyWith(
          _$_ChangeNotified value, $Res Function(_$_ChangeNotified) then) =
      __$$_ChangeNotifiedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uri> uris, int flags});
}

/// @nodoc
class __$$_ChangeNotifiedCopyWithImpl<$Res>
    extends _$ChangeNotifiedCopyWithImpl<$Res, _$_ChangeNotified>
    implements _$$_ChangeNotifiedCopyWith<$Res> {
  __$$_ChangeNotifiedCopyWithImpl(
      _$_ChangeNotified _value, $Res Function(_$_ChangeNotified) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uris = null,
    Object? flags = null,
  }) {
    return _then(_$_ChangeNotified(
      uris: null == uris
          ? _value._uris
          : uris // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChangeNotified implements _ChangeNotified {
  const _$_ChangeNotified({required final List<Uri> uris, required this.flags})
      : _uris = uris;

  final List<Uri> _uris;
  @override
  List<Uri> get uris {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uris);
  }

  @override
  final int flags;

  @override
  String toString() {
    return 'ChangeNotified(uris: $uris, flags: $flags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeNotified &&
            const DeepCollectionEquality().equals(other._uris, _uris) &&
            (identical(other.flags, flags) || other.flags == flags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_uris), flags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeNotifiedCopyWith<_$_ChangeNotified> get copyWith =>
      __$$_ChangeNotifiedCopyWithImpl<_$_ChangeNotified>(this, _$identity);
}

abstract class _ChangeNotified implements ChangeNotified {
  const factory _ChangeNotified(
      {required final List<Uri> uris,
      required final int flags}) = _$_ChangeNotified;

  @override
  List<Uri> get uris;
  @override
  int get flags;
  @override
  @JsonKey(ignore: true)
  _$$_ChangeNotifiedCopyWith<_$_ChangeNotified> get copyWith =>
      throw _privateConstructorUsedError;
}
