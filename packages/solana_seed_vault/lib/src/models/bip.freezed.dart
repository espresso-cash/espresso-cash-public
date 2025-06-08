// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BipLevel {
  int get index;
  bool get hardened;

  /// Create a copy of BipLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<BipLevel> get copyWith =>
      _$BipLevelCopyWithImpl<BipLevel>(this as BipLevel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BipLevel &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hardened, hardened) || other.hardened == hardened));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, hardened);

  @override
  String toString() {
    return 'BipLevel(index: $index, hardened: $hardened)';
  }
}

/// @nodoc
abstract mixin class $BipLevelCopyWith<$Res> {
  factory $BipLevelCopyWith(BipLevel value, $Res Function(BipLevel) _then) = _$BipLevelCopyWithImpl;
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class _$BipLevelCopyWithImpl<$Res> implements $BipLevelCopyWith<$Res> {
  _$BipLevelCopyWithImpl(this._self, this._then);

  final BipLevel _self;
  final $Res Function(BipLevel) _then;

  /// Create a copy of BipLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null, Object? hardened = null}) {
    return _then(
      _self.copyWith(
        index:
            null == index
                ? _self.index
                : index // ignore: cast_nullable_to_non_nullable
                    as int,
        hardened:
            null == hardened
                ? _self.hardened
                : hardened // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _BipLevel implements BipLevel {
  const _BipLevel({required this.index, required this.hardened});

  @override
  final int index;
  @override
  final bool hardened;

  /// Create a copy of BipLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BipLevelCopyWith<_BipLevel> get copyWith =>
      __$BipLevelCopyWithImpl<_BipLevel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BipLevel &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hardened, hardened) || other.hardened == hardened));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, hardened);

  @override
  String toString() {
    return 'BipLevel(index: $index, hardened: $hardened)';
  }
}

/// @nodoc
abstract mixin class _$BipLevelCopyWith<$Res> implements $BipLevelCopyWith<$Res> {
  factory _$BipLevelCopyWith(_BipLevel value, $Res Function(_BipLevel) _then) =
      __$BipLevelCopyWithImpl;
  @override
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class __$BipLevelCopyWithImpl<$Res> implements _$BipLevelCopyWith<$Res> {
  __$BipLevelCopyWithImpl(this._self, this._then);

  final _BipLevel _self;
  final $Res Function(_BipLevel) _then;

  /// Create a copy of BipLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? index = null, Object? hardened = null}) {
    return _then(
      _BipLevel(
        index:
            null == index
                ? _self.index
                : index // ignore: cast_nullable_to_non_nullable
                    as int,
        hardened:
            null == hardened
                ? _self.hardened
                : hardened // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
mixin _$Bip44Data {
  BipLevel get account;
  BipLevel? get change;
  BipLevel? get addressIndex;

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Bip44DataCopyWith<Bip44Data> get copyWith =>
      _$Bip44DataCopyWithImpl<Bip44Data>(this as Bip44Data, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Bip44Data &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.addressIndex, addressIndex) || other.addressIndex == addressIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, change, addressIndex);

  @override
  String toString() {
    return 'Bip44Data(account: $account, change: $change, addressIndex: $addressIndex)';
  }
}

/// @nodoc
abstract mixin class $Bip44DataCopyWith<$Res> {
  factory $Bip44DataCopyWith(Bip44Data value, $Res Function(Bip44Data) _then) =
      _$Bip44DataCopyWithImpl;
  @useResult
  $Res call({BipLevel account, BipLevel? change, BipLevel? addressIndex});

  $BipLevelCopyWith<$Res> get account;
  $BipLevelCopyWith<$Res>? get change;
  $BipLevelCopyWith<$Res>? get addressIndex;
}

/// @nodoc
class _$Bip44DataCopyWithImpl<$Res> implements $Bip44DataCopyWith<$Res> {
  _$Bip44DataCopyWithImpl(this._self, this._then);

  final Bip44Data _self;
  final $Res Function(Bip44Data) _then;

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null, Object? change = freezed, Object? addressIndex = freezed}) {
    return _then(
      _self.copyWith(
        account:
            null == account
                ? _self.account
                : account // ignore: cast_nullable_to_non_nullable
                    as BipLevel,
        change:
            freezed == change
                ? _self.change
                : change // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
        addressIndex:
            freezed == addressIndex
                ? _self.addressIndex
                : addressIndex // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
      ),
    );
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res> get account {
    return $BipLevelCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get change {
    if (_self.change == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_self.change!, (value) {
      return _then(_self.copyWith(change: value));
    });
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get addressIndex {
    if (_self.addressIndex == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_self.addressIndex!, (value) {
      return _then(_self.copyWith(addressIndex: value));
    });
  }
}

/// @nodoc

class _Bip44Data implements Bip44Data {
  const _Bip44Data({required this.account, this.change, this.addressIndex});

  @override
  final BipLevel account;
  @override
  final BipLevel? change;
  @override
  final BipLevel? addressIndex;

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Bip44DataCopyWith<_Bip44Data> get copyWith =>
      __$Bip44DataCopyWithImpl<_Bip44Data>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Bip44Data &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.addressIndex, addressIndex) || other.addressIndex == addressIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, change, addressIndex);

  @override
  String toString() {
    return 'Bip44Data(account: $account, change: $change, addressIndex: $addressIndex)';
  }
}

/// @nodoc
abstract mixin class _$Bip44DataCopyWith<$Res> implements $Bip44DataCopyWith<$Res> {
  factory _$Bip44DataCopyWith(_Bip44Data value, $Res Function(_Bip44Data) _then) =
      __$Bip44DataCopyWithImpl;
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
class __$Bip44DataCopyWithImpl<$Res> implements _$Bip44DataCopyWith<$Res> {
  __$Bip44DataCopyWithImpl(this._self, this._then);

  final _Bip44Data _self;
  final $Res Function(_Bip44Data) _then;

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? account = null, Object? change = freezed, Object? addressIndex = freezed}) {
    return _then(
      _Bip44Data(
        account:
            null == account
                ? _self.account
                : account // ignore: cast_nullable_to_non_nullable
                    as BipLevel,
        change:
            freezed == change
                ? _self.change
                : change // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
        addressIndex:
            freezed == addressIndex
                ? _self.addressIndex
                : addressIndex // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
      ),
    );
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res> get account {
    return $BipLevelCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get change {
    if (_self.change == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_self.change!, (value) {
      return _then(_self.copyWith(change: value));
    });
  }

  /// Create a copy of Bip44Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BipLevelCopyWith<$Res>? get addressIndex {
    if (_self.addressIndex == null) {
      return null;
    }

    return $BipLevelCopyWith<$Res>(_self.addressIndex!, (value) {
      return _then(_self.copyWith(addressIndex: value));
    });
  }
}
