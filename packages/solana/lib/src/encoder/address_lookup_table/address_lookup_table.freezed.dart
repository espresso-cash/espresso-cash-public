// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_lookup_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressLookupTableState {
  BigInt get deactivationSlot;
  int get lastExtendedSlot;
  int get lastExtendedSlotStartIndex;
  Ed25519HDPublicKey? get authority;
  List<Ed25519HDPublicKey> get addresses;

  /// Create a copy of AddressLookupTableState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressLookupTableStateCopyWith<AddressLookupTableState> get copyWith =>
      _$AddressLookupTableStateCopyWithImpl<AddressLookupTableState>(
        this as AddressLookupTableState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddressLookupTableState &&
            (identical(other.deactivationSlot, deactivationSlot) ||
                other.deactivationSlot == deactivationSlot) &&
            (identical(other.lastExtendedSlot, lastExtendedSlot) ||
                other.lastExtendedSlot == lastExtendedSlot) &&
            (identical(other.lastExtendedSlotStartIndex, lastExtendedSlotStartIndex) ||
                other.lastExtendedSlotStartIndex == lastExtendedSlotStartIndex) &&
            (identical(other.authority, authority) || other.authority == authority) &&
            const DeepCollectionEquality().equals(other.addresses, addresses));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    deactivationSlot,
    lastExtendedSlot,
    lastExtendedSlotStartIndex,
    authority,
    const DeepCollectionEquality().hash(addresses),
  );

  @override
  String toString() {
    return 'AddressLookupTableState(deactivationSlot: $deactivationSlot, lastExtendedSlot: $lastExtendedSlot, lastExtendedSlotStartIndex: $lastExtendedSlotStartIndex, authority: $authority, addresses: $addresses)';
  }
}

/// @nodoc
abstract mixin class $AddressLookupTableStateCopyWith<$Res> {
  factory $AddressLookupTableStateCopyWith(
    AddressLookupTableState value,
    $Res Function(AddressLookupTableState) _then,
  ) = _$AddressLookupTableStateCopyWithImpl;
  @useResult
  $Res call({
    BigInt deactivationSlot,
    int lastExtendedSlot,
    int lastExtendedSlotStartIndex,
    Ed25519HDPublicKey? authority,
    List<Ed25519HDPublicKey> addresses,
  });
}

/// @nodoc
class _$AddressLookupTableStateCopyWithImpl<$Res>
    implements $AddressLookupTableStateCopyWith<$Res> {
  _$AddressLookupTableStateCopyWithImpl(this._self, this._then);

  final AddressLookupTableState _self;
  final $Res Function(AddressLookupTableState) _then;

  /// Create a copy of AddressLookupTableState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deactivationSlot = null,
    Object? lastExtendedSlot = null,
    Object? lastExtendedSlotStartIndex = null,
    Object? authority = freezed,
    Object? addresses = null,
  }) {
    return _then(
      _self.copyWith(
        deactivationSlot:
            null == deactivationSlot
                ? _self.deactivationSlot
                : deactivationSlot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
        lastExtendedSlot:
            null == lastExtendedSlot
                ? _self.lastExtendedSlot
                : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
                    as int,
        lastExtendedSlotStartIndex:
            null == lastExtendedSlotStartIndex
                ? _self.lastExtendedSlotStartIndex
                : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        authority:
            freezed == authority
                ? _self.authority
                : authority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        addresses:
            null == addresses
                ? _self.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
      ),
    );
  }
}

/// @nodoc

class _AddressLookupTableState implements AddressLookupTableState {
  const _AddressLookupTableState({
    required this.deactivationSlot,
    required this.lastExtendedSlot,
    required this.lastExtendedSlotStartIndex,
    required this.authority,
    required final List<Ed25519HDPublicKey> addresses,
  }) : _addresses = addresses;

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
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  /// Create a copy of AddressLookupTableState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressLookupTableStateCopyWith<_AddressLookupTableState> get copyWith =>
      __$AddressLookupTableStateCopyWithImpl<_AddressLookupTableState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddressLookupTableState &&
            (identical(other.deactivationSlot, deactivationSlot) ||
                other.deactivationSlot == deactivationSlot) &&
            (identical(other.lastExtendedSlot, lastExtendedSlot) ||
                other.lastExtendedSlot == lastExtendedSlot) &&
            (identical(other.lastExtendedSlotStartIndex, lastExtendedSlotStartIndex) ||
                other.lastExtendedSlotStartIndex == lastExtendedSlotStartIndex) &&
            (identical(other.authority, authority) || other.authority == authority) &&
            const DeepCollectionEquality().equals(other._addresses, _addresses));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    deactivationSlot,
    lastExtendedSlot,
    lastExtendedSlotStartIndex,
    authority,
    const DeepCollectionEquality().hash(_addresses),
  );

  @override
  String toString() {
    return 'AddressLookupTableState(deactivationSlot: $deactivationSlot, lastExtendedSlot: $lastExtendedSlot, lastExtendedSlotStartIndex: $lastExtendedSlotStartIndex, authority: $authority, addresses: $addresses)';
  }
}

/// @nodoc
abstract mixin class _$AddressLookupTableStateCopyWith<$Res>
    implements $AddressLookupTableStateCopyWith<$Res> {
  factory _$AddressLookupTableStateCopyWith(
    _AddressLookupTableState value,
    $Res Function(_AddressLookupTableState) _then,
  ) = __$AddressLookupTableStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    BigInt deactivationSlot,
    int lastExtendedSlot,
    int lastExtendedSlotStartIndex,
    Ed25519HDPublicKey? authority,
    List<Ed25519HDPublicKey> addresses,
  });
}

/// @nodoc
class __$AddressLookupTableStateCopyWithImpl<$Res>
    implements _$AddressLookupTableStateCopyWith<$Res> {
  __$AddressLookupTableStateCopyWithImpl(this._self, this._then);

  final _AddressLookupTableState _self;
  final $Res Function(_AddressLookupTableState) _then;

  /// Create a copy of AddressLookupTableState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? deactivationSlot = null,
    Object? lastExtendedSlot = null,
    Object? lastExtendedSlotStartIndex = null,
    Object? authority = freezed,
    Object? addresses = null,
  }) {
    return _then(
      _AddressLookupTableState(
        deactivationSlot:
            null == deactivationSlot
                ? _self.deactivationSlot
                : deactivationSlot // ignore: cast_nullable_to_non_nullable
                    as BigInt,
        lastExtendedSlot:
            null == lastExtendedSlot
                ? _self.lastExtendedSlot
                : lastExtendedSlot // ignore: cast_nullable_to_non_nullable
                    as int,
        lastExtendedSlotStartIndex:
            null == lastExtendedSlotStartIndex
                ? _self.lastExtendedSlotStartIndex
                : lastExtendedSlotStartIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        authority:
            freezed == authority
                ? _self.authority
                : authority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        addresses:
            null == addresses
                ? _self._addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
      ),
    );
  }
}
