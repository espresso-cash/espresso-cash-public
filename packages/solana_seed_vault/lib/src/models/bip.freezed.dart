// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BipLevel {
  int get index => throw _privateConstructorUsedError;
  bool get hardened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BipLevelCopyWith<BipLevel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BipLevelCopyWith<$Res> {
  factory $BipLevelCopyWith(BipLevel value, $Res Function(BipLevel) then) =
      _$BipLevelCopyWithImpl<$Res, BipLevel>;
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class _$BipLevelCopyWithImpl<$Res, $Val extends BipLevel> implements $BipLevelCopyWith<$Res> {
  _$BipLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null, Object? hardened = null}) {
    return _then(
      _value.copyWith(
            index:
                null == index
                    ? _value.index
                    : index // ignore: cast_nullable_to_non_nullable
                        as int,
            hardened:
                null == hardened
                    ? _value.hardened
                    : hardened // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BipLevelImplCopyWith<$Res> implements $BipLevelCopyWith<$Res> {
  factory _$$BipLevelImplCopyWith(_$BipLevelImpl value, $Res Function(_$BipLevelImpl) then) =
      __$$BipLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, bool hardened});
}

/// @nodoc
class __$$BipLevelImplCopyWithImpl<$Res> extends _$BipLevelCopyWithImpl<$Res, _$BipLevelImpl>
    implements _$$BipLevelImplCopyWith<$Res> {
  __$$BipLevelImplCopyWithImpl(_$BipLevelImpl _value, $Res Function(_$BipLevelImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null, Object? hardened = null}) {
    return _then(
      _$BipLevelImpl(
        index:
            null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                    as int,
        hardened:
            null == hardened
                ? _value.hardened
                : hardened // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$BipLevelImpl implements _BipLevel {
  const _$BipLevelImpl({required this.index, required this.hardened});

  @override
  final int index;
  @override
  final bool hardened;

  @override
  String toString() {
    return 'BipLevel(index: $index, hardened: $hardened)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BipLevelImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hardened, hardened) || other.hardened == hardened));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, hardened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BipLevelImplCopyWith<_$BipLevelImpl> get copyWith =>
      __$$BipLevelImplCopyWithImpl<_$BipLevelImpl>(this, _$identity);
}

abstract class _BipLevel implements BipLevel {
  const factory _BipLevel({required final int index, required final bool hardened}) =
      _$BipLevelImpl;

  @override
  int get index;
  @override
  bool get hardened;
  @override
  @JsonKey(ignore: true)
  _$$BipLevelImplCopyWith<_$BipLevelImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Bip44Data {
  BipLevel get account => throw _privateConstructorUsedError;
  BipLevel? get change => throw _privateConstructorUsedError;
  BipLevel? get addressIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $Bip44DataCopyWith<Bip44Data> get copyWith => throw _privateConstructorUsedError;
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
class _$Bip44DataCopyWithImpl<$Res, $Val extends Bip44Data> implements $Bip44DataCopyWith<$Res> {
  _$Bip44DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null, Object? change = freezed, Object? addressIndex = freezed}) {
    return _then(
      _value.copyWith(
            account:
                null == account
                    ? _value.account
                    : account // ignore: cast_nullable_to_non_nullable
                        as BipLevel,
            change:
                freezed == change
                    ? _value.change
                    : change // ignore: cast_nullable_to_non_nullable
                        as BipLevel?,
            addressIndex:
                freezed == addressIndex
                    ? _value.addressIndex
                    : addressIndex // ignore: cast_nullable_to_non_nullable
                        as BipLevel?,
          )
          as $Val,
    );
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
abstract class _$$Bip44DataImplCopyWith<$Res> implements $Bip44DataCopyWith<$Res> {
  factory _$$Bip44DataImplCopyWith(_$Bip44DataImpl value, $Res Function(_$Bip44DataImpl) then) =
      __$$Bip44DataImplCopyWithImpl<$Res>;
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
class __$$Bip44DataImplCopyWithImpl<$Res> extends _$Bip44DataCopyWithImpl<$Res, _$Bip44DataImpl>
    implements _$$Bip44DataImplCopyWith<$Res> {
  __$$Bip44DataImplCopyWithImpl(_$Bip44DataImpl _value, $Res Function(_$Bip44DataImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null, Object? change = freezed, Object? addressIndex = freezed}) {
    return _then(
      _$Bip44DataImpl(
        account:
            null == account
                ? _value.account
                : account // ignore: cast_nullable_to_non_nullable
                    as BipLevel,
        change:
            freezed == change
                ? _value.change
                : change // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
        addressIndex:
            freezed == addressIndex
                ? _value.addressIndex
                : addressIndex // ignore: cast_nullable_to_non_nullable
                    as BipLevel?,
      ),
    );
  }
}

/// @nodoc

class _$Bip44DataImpl implements _Bip44Data {
  const _$Bip44DataImpl({required this.account, this.change, this.addressIndex});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Bip44DataImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.addressIndex, addressIndex) || other.addressIndex == addressIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, change, addressIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Bip44DataImplCopyWith<_$Bip44DataImpl> get copyWith =>
      __$$Bip44DataImplCopyWithImpl<_$Bip44DataImpl>(this, _$identity);
}

abstract class _Bip44Data implements Bip44Data {
  const factory _Bip44Data({
    required final BipLevel account,
    final BipLevel? change,
    final BipLevel? addressIndex,
  }) = _$Bip44DataImpl;

  @override
  BipLevel get account;
  @override
  BipLevel? get change;
  @override
  BipLevel? get addressIndex;
  @override
  @JsonKey(ignore: true)
  _$$Bip44DataImplCopyWith<_$Bip44DataImpl> get copyWith => throw _privateConstructorUsedError;
}
