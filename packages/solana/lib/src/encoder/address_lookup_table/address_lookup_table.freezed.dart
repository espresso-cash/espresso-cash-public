// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address_lookup_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddressLookupTableState {
  BigInt get deactivationSlot => throw _privateConstructorUsedError;
  int get lastExtendedSlot => throw _privateConstructorUsedError;
  int get lastExtendedSlotStartIndex => throw _privateConstructorUsedError;
  Ed25519HDPublicKey? get authority => throw _privateConstructorUsedError;
  List<Ed25519HDPublicKey> get addresses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressLookupTableStateCopyWith<AddressLookupTableState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressLookupTableStateCopyWith<$Res> {
  factory $AddressLookupTableStateCopyWith(AddressLookupTableState value,
          $Res Function(AddressLookupTableState) then) =
      _$AddressLookupTableStateCopyWithImpl<$Res>;
  $Res call(
      {BigInt deactivationSlot,
      int lastExtendedSlot,
      int lastExtendedSlotStartIndex,
      Ed25519HDPublicKey? authority,
      List<Ed25519HDPublicKey> addresses});
}

/// @nodoc
class _$AddressLookupTableStateCopyWithImpl<$Res>
    implements $AddressLookupTableStateCopyWith<$Res> {
  _$AddressLookupTableStateCopyWithImpl(this._value, this._then);

  final AddressLookupTableState _value;
  // ignore: unused_field
  final $Res Function(AddressLookupTableState) _then;

  @override
  $Res call({
    Object? deactivationSlot = freezed,
    Object? lastExtendedSlot = freezed,
    Object? lastExtendedSlotStartIndex = freezed,
    Object? authority = freezed,
    Object? addresses = freezed,
  }) {
    return _then(_value.copyWith(
      deactivationSlot: deactivationSlot == freezed
          ? _value.deactivationSlot
          : deactivationSlot // ignore: cast_nullable_to_non_nullable
              as BigInt,
      lastExtendedSlot: lastExtendedSlot == freezed
          ? _value.lastExtendedSlot
          : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
              as int,
      lastExtendedSlotStartIndex: lastExtendedSlotStartIndex == freezed
          ? _value.lastExtendedSlotStartIndex
          : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
              as int,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      addresses: addresses == freezed
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
    ));
  }
}

/// @nodoc
abstract class _$$_AddressLookupTableStateCopyWith<$Res>
    implements $AddressLookupTableStateCopyWith<$Res> {
  factory _$$_AddressLookupTableStateCopyWith(_$_AddressLookupTableState value,
          $Res Function(_$_AddressLookupTableState) then) =
      __$$_AddressLookupTableStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {BigInt deactivationSlot,
      int lastExtendedSlot,
      int lastExtendedSlotStartIndex,
      Ed25519HDPublicKey? authority,
      List<Ed25519HDPublicKey> addresses});
}

/// @nodoc
class __$$_AddressLookupTableStateCopyWithImpl<$Res>
    extends _$AddressLookupTableStateCopyWithImpl<$Res>
    implements _$$_AddressLookupTableStateCopyWith<$Res> {
  __$$_AddressLookupTableStateCopyWithImpl(_$_AddressLookupTableState _value,
      $Res Function(_$_AddressLookupTableState) _then)
      : super(_value, (v) => _then(v as _$_AddressLookupTableState));

  @override
  _$_AddressLookupTableState get _value =>
      super._value as _$_AddressLookupTableState;

  @override
  $Res call({
    Object? deactivationSlot = freezed,
    Object? lastExtendedSlot = freezed,
    Object? lastExtendedSlotStartIndex = freezed,
    Object? authority = freezed,
    Object? addresses = freezed,
  }) {
    return _then(_$_AddressLookupTableState(
      deactivationSlot: deactivationSlot == freezed
          ? _value.deactivationSlot
          : deactivationSlot // ignore: cast_nullable_to_non_nullable
              as BigInt,
      lastExtendedSlot: lastExtendedSlot == freezed
          ? _value.lastExtendedSlot
          : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
              as int,
      lastExtendedSlotStartIndex: lastExtendedSlotStartIndex == freezed
          ? _value.lastExtendedSlotStartIndex
          : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
              as int,
      authority: authority == freezed
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      addresses: addresses == freezed
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
    ));
  }
}

/// @nodoc

class _$_AddressLookupTableState implements _AddressLookupTableState {
  const _$_AddressLookupTableState(
      {required this.deactivationSlot,
      required this.lastExtendedSlot,
      required this.lastExtendedSlotStartIndex,
      required this.authority,
      required final List<Ed25519HDPublicKey> addresses})
      : _addresses = addresses;

  @override
  final BigInt deactivationSlot;
  @override
  final int lastExtendedSlot;
  @override
  final int lastExtendedSlotStartIndex;
  @override
  final Ed25519HDPublicKey? authority;
  final List<Ed25519HDPublicKey> _addresses;
  @override
  List<Ed25519HDPublicKey> get addresses {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  String toString() {
    return 'AddressLookupTableState(deactivationSlot: $deactivationSlot, lastExtendedSlot: $lastExtendedSlot, lastExtendedSlotStartIndex: $lastExtendedSlotStartIndex, authority: $authority, addresses: $addresses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressLookupTableState &&
            const DeepCollectionEquality()
                .equals(other.deactivationSlot, deactivationSlot) &&
            const DeepCollectionEquality()
                .equals(other.lastExtendedSlot, lastExtendedSlot) &&
            const DeepCollectionEquality().equals(
                other.lastExtendedSlotStartIndex, lastExtendedSlotStartIndex) &&
            const DeepCollectionEquality().equals(other.authority, authority) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(deactivationSlot),
      const DeepCollectionEquality().hash(lastExtendedSlot),
      const DeepCollectionEquality().hash(lastExtendedSlotStartIndex),
      const DeepCollectionEquality().hash(authority),
      const DeepCollectionEquality().hash(_addresses));

  @JsonKey(ignore: true)
  @override
  _$$_AddressLookupTableStateCopyWith<_$_AddressLookupTableState>
      get copyWith =>
          __$$_AddressLookupTableStateCopyWithImpl<_$_AddressLookupTableState>(
              this, _$identity);
}

abstract class _AddressLookupTableState implements AddressLookupTableState {
  const factory _AddressLookupTableState(
          {required final BigInt deactivationSlot,
          required final int lastExtendedSlot,
          required final int lastExtendedSlotStartIndex,
          required final Ed25519HDPublicKey? authority,
          required final List<Ed25519HDPublicKey> addresses}) =
      _$_AddressLookupTableState;

  @override
  BigInt get deactivationSlot;
  @override
  int get lastExtendedSlot;
  @override
  int get lastExtendedSlotStartIndex;
  @override
  Ed25519HDPublicKey? get authority;
  @override
  List<Ed25519HDPublicKey> get addresses;
  @override
  @JsonKey(ignore: true)
  _$$_AddressLookupTableStateCopyWith<_$_AddressLookupTableState>
      get copyWith => throw _privateConstructorUsedError;
}
