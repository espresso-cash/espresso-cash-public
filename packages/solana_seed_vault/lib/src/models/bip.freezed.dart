// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BipLevel {
  int get index => throw _privateConstructorUsedError;
  bool get hardened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BipLevelCopyWith<BipLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BipLevelCopyWith<$Res> {
  factory $BipLevelCopyWith(BipLevel value, $Res Function(BipLevel) then) =
      _$BipLevelCopyWithImpl<$Res, BipLevel>;
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class _$BipLevelCopyWithImpl<$Res, $Val extends BipLevel>
    implements $BipLevelCopyWith<$Res> {
  _$BipLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? hardened = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      hardened: null == hardened
          ? _value.hardened
          : hardened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BipLevelCopyWith<$Res> implements $BipLevelCopyWith<$Res> {
  factory _$$_BipLevelCopyWith(
          _$_BipLevel value, $Res Function(_$_BipLevel) then) =
      __$$_BipLevelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class __$$_BipLevelCopyWithImpl<$Res>
    extends _$BipLevelCopyWithImpl<$Res, _$_BipLevel>
    implements _$$_BipLevelCopyWith<$Res> {
  __$$_BipLevelCopyWithImpl(
      _$_BipLevel _value, $Res Function(_$_BipLevel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? hardened = null,
  }) {
    return _then(_$_BipLevel(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      hardened: null == hardened
          ? _value.hardened
          : hardened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BipLevel implements _BipLevel {
  const _$_BipLevel({required this.index, required this.hardened});

  @override
  final int index;
  @override
  final bool hardened;

  @override
  String toString() {
    return 'BipLevel(index: $index, hardened: $hardened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BipLevel &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hardened, hardened) ||
                other.hardened == hardened));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, hardened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BipLevelCopyWith<_$_BipLevel> get copyWith =>
      __$$_BipLevelCopyWithImpl<_$_BipLevel>(this, _$identity);
}

abstract class _BipLevel implements BipLevel {
  const factory _BipLevel(
      {required final int index, required final bool hardened}) = _$_BipLevel;

  @override
  int get index;
  @override
  bool get hardened;
  @override
  @JsonKey(ignore: true)
  _$$_BipLevelCopyWith<_$_BipLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Bip32Data {
  List<BipLevel> get levels => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $Bip32DataCopyWith<Bip32Data> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Bip32DataCopyWith<$Res> {
  factory $Bip32DataCopyWith(Bip32Data value, $Res Function(Bip32Data) then) =
      _$Bip32DataCopyWithImpl<$Res, Bip32Data>;
  @useResult
  $Res call({List<BipLevel> levels});
}

/// @nodoc
class _$Bip32DataCopyWithImpl<$Res, $Val extends Bip32Data>
    implements $Bip32DataCopyWith<$Res> {
  _$Bip32DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levels = null,
  }) {
    return _then(_value.copyWith(
      levels: null == levels
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<BipLevel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_Bip32DataCopyWith<$Res> implements $Bip32DataCopyWith<$Res> {
  factory _$$_Bip32DataCopyWith(
          _$_Bip32Data value, $Res Function(_$_Bip32Data) then) =
      __$$_Bip32DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BipLevel> levels});
}

/// @nodoc
class __$$_Bip32DataCopyWithImpl<$Res>
    extends _$Bip32DataCopyWithImpl<$Res, _$_Bip32Data>
    implements _$$_Bip32DataCopyWith<$Res> {
  __$$_Bip32DataCopyWithImpl(
      _$_Bip32Data _value, $Res Function(_$_Bip32Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levels = null,
  }) {
    return _then(_$_Bip32Data(
      levels: null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<BipLevel>,
    ));
  }
}

/// @nodoc

class _$_Bip32Data implements _Bip32Data {
  const _$_Bip32Data({required final List<BipLevel> levels}) : _levels = levels;

  final List<BipLevel> _levels;
  @override
  List<BipLevel> get levels {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  String toString() {
    return 'Bip32Data(levels: $levels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bip32Data &&
            const DeepCollectionEquality().equals(other._levels, _levels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_levels));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_Bip32DataCopyWith<_$_Bip32Data> get copyWith =>
      __$$_Bip32DataCopyWithImpl<_$_Bip32Data>(this, _$identity);
}

abstract class _Bip32Data implements Bip32Data {
  const factory _Bip32Data({required final List<BipLevel> levels}) =
      _$_Bip32Data;

  @override
  List<BipLevel> get levels;
  @override
  @JsonKey(ignore: true)
  _$$_Bip32DataCopyWith<_$_Bip32Data> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Bip44Data {
  BipLevel get account => throw _privateConstructorUsedError;
  BipLevel? get change => throw _privateConstructorUsedError;
  BipLevel? get addressIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $Bip44DataCopyWith<Bip44Data> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Bip44DataCopyWith<$Res> {
  factory $Bip44DataCopyWith(Bip44Data value, $Res Function(Bip44Data) then) =
      _$Bip44DataCopyWithImpl<$Res, Bip44Data>;
  @useResult
  $Res call({BipLevel account, BipLevel? change, BipLevel? addressIndex});

  $BipLevelCopyWith<$Res> get account;
  $BipLevelCopyWith<$Res>? get change;
  $BipLevelCopyWith<$Res>? get addressIndex;
}

/// @nodoc
class _$Bip44DataCopyWithImpl<$Res, $Val extends Bip44Data>
    implements $Bip44DataCopyWith<$Res> {
  _$Bip44DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? change = freezed,
    Object? addressIndex = freezed,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as BipLevel,
      change: freezed == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as BipLevel?,
      addressIndex: freezed == addressIndex
          ? _value.addressIndex
          : addressIndex // ignore: cast_nullable_to_non_nullable
              as BipLevel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res> get account {
    return $BipLevelCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get change {
    if (_value.change == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_value.change!, (value) {
      return _then(_value.copyWith(change: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get addressIndex {
    if (_value.addressIndex == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_value.addressIndex!, (value) {
      return _then(_value.copyWith(addressIndex: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_Bip44DataCopyWith<$Res> implements $Bip44DataCopyWith<$Res> {
  factory _$$_Bip44DataCopyWith(
          _$_Bip44Data value, $Res Function(_$_Bip44Data) then) =
      __$$_Bip44DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BipLevel account, BipLevel? change, BipLevel? addressIndex});

  @override
  $BipLevelCopyWith<$Res> get account;
  @override
  $BipLevelCopyWith<$Res>? get change;
  @override
  $BipLevelCopyWith<$Res>? get addressIndex;
}

/// @nodoc
class __$$_Bip44DataCopyWithImpl<$Res>
    extends _$Bip44DataCopyWithImpl<$Res, _$_Bip44Data>
    implements _$$_Bip44DataCopyWith<$Res> {
  __$$_Bip44DataCopyWithImpl(
      _$_Bip44Data _value, $Res Function(_$_Bip44Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? change = freezed,
    Object? addressIndex = freezed,
  }) {
    return _then(_$_Bip44Data(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as BipLevel,
      change: freezed == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as BipLevel?,
      addressIndex: freezed == addressIndex
          ? _value.addressIndex
          : addressIndex // ignore: cast_nullable_to_non_nullable
              as BipLevel?,
    ));
  }
}

/// @nodoc

class _$_Bip44Data implements _Bip44Data {
  const _$_Bip44Data({required this.account, this.change, this.addressIndex});

  @override
  final BipLevel account;
  @override
  final BipLevel? change;
  @override
  final BipLevel? addressIndex;

  @override
  String toString() {
    return 'Bip44Data(account: $account, change: $change, addressIndex: $addressIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bip44Data &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.addressIndex, addressIndex) ||
                other.addressIndex == addressIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, change, addressIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_Bip44DataCopyWith<_$_Bip44Data> get copyWith =>
      __$$_Bip44DataCopyWithImpl<_$_Bip44Data>(this, _$identity);
}

abstract class _Bip44Data implements Bip44Data {
  const factory _Bip44Data(
      {required final BipLevel account,
      final BipLevel? change,
      final BipLevel? addressIndex}) = _$_Bip44Data;

  @override
  BipLevel get account;
  @override
  BipLevel? get change;
  @override
  BipLevel? get addressIndex;
  @override
  @JsonKey(ignore: true)
  _$$_Bip44DataCopyWith<_$_Bip44Data> get copyWith =>
      throw _privateConstructorUsedError;
}
