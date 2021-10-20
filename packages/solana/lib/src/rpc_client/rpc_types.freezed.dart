// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rpc_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommitmentObject _$CommitmentObjectFromJson(Map<String, dynamic> json) {
  return _CommitmentObject.fromJson(json);
}

/// @nodoc
class _$CommitmentObjectTearOff {
  const _$CommitmentObjectTearOff();

  _CommitmentObject call({required Commitment commitment}) {
    return _CommitmentObject(
      commitment: commitment,
    );
  }

  CommitmentObject fromJson(Map<String, Object> json) {
    return CommitmentObject.fromJson(json);
  }
}

/// @nodoc
const $CommitmentObject = _$CommitmentObjectTearOff();

/// @nodoc
mixin _$CommitmentObject {
  Commitment get commitment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommitmentObjectCopyWith<CommitmentObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommitmentObjectCopyWith<$Res> {
  factory $CommitmentObjectCopyWith(
          CommitmentObject value, $Res Function(CommitmentObject) then) =
      _$CommitmentObjectCopyWithImpl<$Res>;
  $Res call({Commitment commitment});
}

/// @nodoc
class _$CommitmentObjectCopyWithImpl<$Res>
    implements $CommitmentObjectCopyWith<$Res> {
  _$CommitmentObjectCopyWithImpl(this._value, this._then);

  final CommitmentObject _value;
  // ignore: unused_field
  final $Res Function(CommitmentObject) _then;

  @override
  $Res call({
    Object? commitment = freezed,
  }) {
    return _then(_value.copyWith(
      commitment: commitment == freezed
          ? _value.commitment
          : commitment // ignore: cast_nullable_to_non_nullable
              as Commitment,
    ));
  }
}

/// @nodoc
abstract class _$CommitmentObjectCopyWith<$Res>
    implements $CommitmentObjectCopyWith<$Res> {
  factory _$CommitmentObjectCopyWith(
          _CommitmentObject value, $Res Function(_CommitmentObject) then) =
      __$CommitmentObjectCopyWithImpl<$Res>;
  @override
  $Res call({Commitment commitment});
}

/// @nodoc
class __$CommitmentObjectCopyWithImpl<$Res>
    extends _$CommitmentObjectCopyWithImpl<$Res>
    implements _$CommitmentObjectCopyWith<$Res> {
  __$CommitmentObjectCopyWithImpl(
      _CommitmentObject _value, $Res Function(_CommitmentObject) _then)
      : super(_value, (v) => _then(v as _CommitmentObject));

  @override
  _CommitmentObject get _value => super._value as _CommitmentObject;

  @override
  $Res call({
    Object? commitment = freezed,
  }) {
    return _then(_CommitmentObject(
      commitment: commitment == freezed
          ? _value.commitment
          : commitment // ignore: cast_nullable_to_non_nullable
              as Commitment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommitmentObject implements _CommitmentObject {
  const _$_CommitmentObject({required this.commitment});

  factory _$_CommitmentObject.fromJson(Map<String, dynamic> json) =>
      _$$_CommitmentObjectFromJson(json);

  @override
  final Commitment commitment;

  @override
  String toString() {
    return 'CommitmentObject(commitment: $commitment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommitmentObject &&
            (identical(other.commitment, commitment) ||
                const DeepCollectionEquality()
                    .equals(other.commitment, commitment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(commitment);

  @JsonKey(ignore: true)
  @override
  _$CommitmentObjectCopyWith<_CommitmentObject> get copyWith =>
      __$CommitmentObjectCopyWithImpl<_CommitmentObject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommitmentObjectToJson(this);
  }
}

abstract class _CommitmentObject implements CommitmentObject {
  const factory _CommitmentObject({required Commitment commitment}) =
      _$_CommitmentObject;

  factory _CommitmentObject.fromJson(Map<String, dynamic> json) =
      _$_CommitmentObject.fromJson;

  @override
  Commitment get commitment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommitmentObjectCopyWith<_CommitmentObject> get copyWith =>
      throw _privateConstructorUsedError;
}

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
class _$AccountTearOff {
  const _$AccountTearOff();

  _Account call(
      {required int lamports,
      required String owner,
      @AccountDataConverter() required AccountData? data,
      required bool executable,
      required int rentEpoch}) {
    return _Account(
      lamports: lamports,
      owner: owner,
      data: data,
      executable: executable,
      rentEpoch: rentEpoch,
    );
  }

  Account fromJson(Map<String, Object> json) {
    return Account.fromJson(json);
  }
}

/// @nodoc
const $Account = _$AccountTearOff();

/// @nodoc
mixin _$Account {
  int get lamports => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  @AccountDataConverter()
  AccountData? get data => throw _privateConstructorUsedError;
  bool get executable => throw _privateConstructorUsedError;
  int get rentEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res>;
  $Res call(
      {int lamports,
      String owner,
      @AccountDataConverter() AccountData? data,
      bool executable,
      int rentEpoch});

  $AccountDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$AccountCopyWithImpl<$Res> implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  final Account _value;
  // ignore: unused_field
  final $Res Function(Account) _then;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? owner = freezed,
    Object? data = freezed,
    Object? executable = freezed,
    Object? rentEpoch = freezed,
  }) {
    return _then(_value.copyWith(
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AccountData?,
      executable: executable == freezed
          ? _value.executable
          : executable // ignore: cast_nullable_to_non_nullable
              as bool,
      rentEpoch: rentEpoch == freezed
          ? _value.rentEpoch
          : rentEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $AccountDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AccountDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc
abstract class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) then) =
      __$AccountCopyWithImpl<$Res>;
  @override
  $Res call(
      {int lamports,
      String owner,
      @AccountDataConverter() AccountData? data,
      bool executable,
      int rentEpoch});

  @override
  $AccountDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$AccountCopyWithImpl<$Res> extends _$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(_Account _value, $Res Function(_Account) _then)
      : super(_value, (v) => _then(v as _Account));

  @override
  _Account get _value => super._value as _Account;

  @override
  $Res call({
    Object? lamports = freezed,
    Object? owner = freezed,
    Object? data = freezed,
    Object? executable = freezed,
    Object? rentEpoch = freezed,
  }) {
    return _then(_Account(
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AccountData?,
      executable: executable == freezed
          ? _value.executable
          : executable // ignore: cast_nullable_to_non_nullable
              as bool,
      rentEpoch: rentEpoch == freezed
          ? _value.rentEpoch
          : rentEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Account implements _Account {
  const _$_Account(
      {required this.lamports,
      required this.owner,
      @AccountDataConverter() required this.data,
      required this.executable,
      required this.rentEpoch});

  factory _$_Account.fromJson(Map<String, dynamic> json) =>
      _$$_AccountFromJson(json);

  @override
  final int lamports;
  @override
  final String owner;
  @override
  @AccountDataConverter()
  final AccountData? data;
  @override
  final bool executable;
  @override
  final int rentEpoch;

  @override
  String toString() {
    return 'Account(lamports: $lamports, owner: $owner, data: $data, executable: $executable, rentEpoch: $rentEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Account &&
            (identical(other.lamports, lamports) ||
                const DeepCollectionEquality()
                    .equals(other.lamports, lamports)) &&
            (identical(other.owner, owner) ||
                const DeepCollectionEquality().equals(other.owner, owner)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.executable, executable) ||
                const DeepCollectionEquality()
                    .equals(other.executable, executable)) &&
            (identical(other.rentEpoch, rentEpoch) ||
                const DeepCollectionEquality()
                    .equals(other.rentEpoch, rentEpoch)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lamports) ^
      const DeepCollectionEquality().hash(owner) ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(executable) ^
      const DeepCollectionEquality().hash(rentEpoch);

  @JsonKey(ignore: true)
  @override
  _$AccountCopyWith<_Account> get copyWith =>
      __$AccountCopyWithImpl<_Account>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountToJson(this);
  }
}

abstract class _Account implements Account {
  const factory _Account(
      {required int lamports,
      required String owner,
      @AccountDataConverter() required AccountData? data,
      required bool executable,
      required int rentEpoch}) = _$_Account;

  factory _Account.fromJson(Map<String, dynamic> json) = _$_Account.fromJson;

  @override
  int get lamports => throw _privateConstructorUsedError;
  @override
  String get owner => throw _privateConstructorUsedError;
  @override
  @AccountDataConverter()
  AccountData? get data => throw _privateConstructorUsedError;
  @override
  bool get executable => throw _privateConstructorUsedError;
  @override
  int get rentEpoch => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AccountCopyWith<_Account> get copyWith =>
      throw _privateConstructorUsedError;
}

Block _$BlockFromJson(Map<String, dynamic> json) {
  return _Block.fromJson(json);
}

/// @nodoc
class _$BlockTearOff {
  const _$BlockTearOff();

  _Block call(
      {required String blockhash,
      required String previousBlockhash,
      required int parentSlot,
      required List<Transaction> transactions,
      required Meta? meta,
      required List<String> signatures,
      required List<Reward> rewards,
      required int? blockTime,
      required int? blockHeight}) {
    return _Block(
      blockhash: blockhash,
      previousBlockhash: previousBlockhash,
      parentSlot: parentSlot,
      transactions: transactions,
      meta: meta,
      signatures: signatures,
      rewards: rewards,
      blockTime: blockTime,
      blockHeight: blockHeight,
    );
  }

  Block fromJson(Map<String, Object> json) {
    return Block.fromJson(json);
  }
}

/// @nodoc
const $Block = _$BlockTearOff();

/// @nodoc
mixin _$Block {
  String get blockhash => throw _privateConstructorUsedError;
  String get previousBlockhash => throw _privateConstructorUsedError;
  int get parentSlot => throw _privateConstructorUsedError;
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  Meta? get meta => throw _privateConstructorUsedError;
  List<String> get signatures => throw _privateConstructorUsedError;
  List<Reward> get rewards => throw _privateConstructorUsedError;
  int? get blockTime => throw _privateConstructorUsedError;
  int? get blockHeight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockCopyWith<Block> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockCopyWith<$Res> {
  factory $BlockCopyWith(Block value, $Res Function(Block) then) =
      _$BlockCopyWithImpl<$Res>;
  $Res call(
      {String blockhash,
      String previousBlockhash,
      int parentSlot,
      List<Transaction> transactions,
      Meta? meta,
      List<String> signatures,
      List<Reward> rewards,
      int? blockTime,
      int? blockHeight});

  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BlockCopyWithImpl<$Res> implements $BlockCopyWith<$Res> {
  _$BlockCopyWithImpl(this._value, this._then);

  final Block _value;
  // ignore: unused_field
  final $Res Function(Block) _then;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? previousBlockhash = freezed,
    Object? parentSlot = freezed,
    Object? transactions = freezed,
    Object? meta = freezed,
    Object? signatures = freezed,
    Object? rewards = freezed,
    Object? blockTime = freezed,
    Object? blockHeight = freezed,
  }) {
    return _then(_value.copyWith(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      previousBlockhash: previousBlockhash == freezed
          ? _value.previousBlockhash
          : previousBlockhash // ignore: cast_nullable_to_non_nullable
              as String,
      parentSlot: parentSlot == freezed
          ? _value.parentSlot
          : parentSlot // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      signatures: signatures == freezed
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewards: rewards == freezed
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<Reward>,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $MetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $MetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc
abstract class _$BlockCopyWith<$Res> implements $BlockCopyWith<$Res> {
  factory _$BlockCopyWith(_Block value, $Res Function(_Block) then) =
      __$BlockCopyWithImpl<$Res>;
  @override
  $Res call(
      {String blockhash,
      String previousBlockhash,
      int parentSlot,
      List<Transaction> transactions,
      Meta? meta,
      List<String> signatures,
      List<Reward> rewards,
      int? blockTime,
      int? blockHeight});

  @override
  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$BlockCopyWithImpl<$Res> extends _$BlockCopyWithImpl<$Res>
    implements _$BlockCopyWith<$Res> {
  __$BlockCopyWithImpl(_Block _value, $Res Function(_Block) _then)
      : super(_value, (v) => _then(v as _Block));

  @override
  _Block get _value => super._value as _Block;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? previousBlockhash = freezed,
    Object? parentSlot = freezed,
    Object? transactions = freezed,
    Object? meta = freezed,
    Object? signatures = freezed,
    Object? rewards = freezed,
    Object? blockTime = freezed,
    Object? blockHeight = freezed,
  }) {
    return _then(_Block(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      previousBlockhash: previousBlockhash == freezed
          ? _value.previousBlockhash
          : previousBlockhash // ignore: cast_nullable_to_non_nullable
              as String,
      parentSlot: parentSlot == freezed
          ? _value.parentSlot
          : parentSlot // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: transactions == freezed
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      signatures: signatures == freezed
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewards: rewards == freezed
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<Reward>,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Block implements _Block {
  const _$_Block(
      {required this.blockhash,
      required this.previousBlockhash,
      required this.parentSlot,
      required this.transactions,
      required this.meta,
      required this.signatures,
      required this.rewards,
      required this.blockTime,
      required this.blockHeight});

  factory _$_Block.fromJson(Map<String, dynamic> json) =>
      _$$_BlockFromJson(json);

  @override
  final String blockhash;
  @override
  final String previousBlockhash;
  @override
  final int parentSlot;
  @override
  final List<Transaction> transactions;
  @override
  final Meta? meta;
  @override
  final List<String> signatures;
  @override
  final List<Reward> rewards;
  @override
  final int? blockTime;
  @override
  final int? blockHeight;

  @override
  String toString() {
    return 'Block(blockhash: $blockhash, previousBlockhash: $previousBlockhash, parentSlot: $parentSlot, transactions: $transactions, meta: $meta, signatures: $signatures, rewards: $rewards, blockTime: $blockTime, blockHeight: $blockHeight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Block &&
            (identical(other.blockhash, blockhash) ||
                const DeepCollectionEquality()
                    .equals(other.blockhash, blockhash)) &&
            (identical(other.previousBlockhash, previousBlockhash) ||
                const DeepCollectionEquality()
                    .equals(other.previousBlockhash, previousBlockhash)) &&
            (identical(other.parentSlot, parentSlot) ||
                const DeepCollectionEquality()
                    .equals(other.parentSlot, parentSlot)) &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality()
                    .equals(other.transactions, transactions)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.signatures, signatures) ||
                const DeepCollectionEquality()
                    .equals(other.signatures, signatures)) &&
            (identical(other.rewards, rewards) ||
                const DeepCollectionEquality()
                    .equals(other.rewards, rewards)) &&
            (identical(other.blockTime, blockTime) ||
                const DeepCollectionEquality()
                    .equals(other.blockTime, blockTime)) &&
            (identical(other.blockHeight, blockHeight) ||
                const DeepCollectionEquality()
                    .equals(other.blockHeight, blockHeight)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(blockhash) ^
      const DeepCollectionEquality().hash(previousBlockhash) ^
      const DeepCollectionEquality().hash(parentSlot) ^
      const DeepCollectionEquality().hash(transactions) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(signatures) ^
      const DeepCollectionEquality().hash(rewards) ^
      const DeepCollectionEquality().hash(blockTime) ^
      const DeepCollectionEquality().hash(blockHeight);

  @JsonKey(ignore: true)
  @override
  _$BlockCopyWith<_Block> get copyWith =>
      __$BlockCopyWithImpl<_Block>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlockToJson(this);
  }
}

abstract class _Block implements Block {
  const factory _Block(
      {required String blockhash,
      required String previousBlockhash,
      required int parentSlot,
      required List<Transaction> transactions,
      required Meta? meta,
      required List<String> signatures,
      required List<Reward> rewards,
      required int? blockTime,
      required int? blockHeight}) = _$_Block;

  factory _Block.fromJson(Map<String, dynamic> json) = _$_Block.fromJson;

  @override
  String get blockhash => throw _privateConstructorUsedError;
  @override
  String get previousBlockhash => throw _privateConstructorUsedError;
  @override
  int get parentSlot => throw _privateConstructorUsedError;
  @override
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  @override
  Meta? get meta => throw _privateConstructorUsedError;
  @override
  List<String> get signatures => throw _privateConstructorUsedError;
  @override
  List<Reward> get rewards => throw _privateConstructorUsedError;
  @override
  int? get blockTime => throw _privateConstructorUsedError;
  @override
  int? get blockHeight => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlockCopyWith<_Block> get copyWith => throw _privateConstructorUsedError;
}

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return _Meta.fromJson(json);
}

/// @nodoc
class _$MetaTearOff {
  const _$MetaTearOff();

  _Meta call(
      {required Map<String, dynamic>? err,
      required int fee,
      required List<int> preBalances,
      required List<int> postBalances,
      required List<InnerInstruction> innerInstructions,
      required List<TokenBalance> preTokenBalances,
      required List<TokenBalance> postTokenBalances,
      required List<String> logMessages}) {
    return _Meta(
      err: err,
      fee: fee,
      preBalances: preBalances,
      postBalances: postBalances,
      innerInstructions: innerInstructions,
      preTokenBalances: preTokenBalances,
      postTokenBalances: postTokenBalances,
      logMessages: logMessages,
    );
  }

  Meta fromJson(Map<String, Object> json) {
    return Meta.fromJson(json);
  }
}

/// @nodoc
const $Meta = _$MetaTearOff();

/// @nodoc
mixin _$Meta {
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;
  List<int> get preBalances => throw _privateConstructorUsedError;
  List<int> get postBalances => throw _privateConstructorUsedError;
  List<InnerInstruction> get innerInstructions =>
      throw _privateConstructorUsedError;
  List<TokenBalance> get preTokenBalances => throw _privateConstructorUsedError;
  List<TokenBalance> get postTokenBalances =>
      throw _privateConstructorUsedError;
  List<String> get logMessages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetaCopyWith<Meta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaCopyWith<$Res> {
  factory $MetaCopyWith(Meta value, $Res Function(Meta) then) =
      _$MetaCopyWithImpl<$Res>;
  $Res call(
      {Map<String, dynamic>? err,
      int fee,
      List<int> preBalances,
      List<int> postBalances,
      List<InnerInstruction> innerInstructions,
      List<TokenBalance> preTokenBalances,
      List<TokenBalance> postTokenBalances,
      List<String> logMessages});
}

/// @nodoc
class _$MetaCopyWithImpl<$Res> implements $MetaCopyWith<$Res> {
  _$MetaCopyWithImpl(this._value, this._then);

  final Meta _value;
  // ignore: unused_field
  final $Res Function(Meta) _then;

  @override
  $Res call({
    Object? err = freezed,
    Object? fee = freezed,
    Object? preBalances = freezed,
    Object? postBalances = freezed,
    Object? innerInstructions = freezed,
    Object? preTokenBalances = freezed,
    Object? postTokenBalances = freezed,
    Object? logMessages = freezed,
  }) {
    return _then(_value.copyWith(
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      preBalances: preBalances == freezed
          ? _value.preBalances
          : preBalances // ignore: cast_nullable_to_non_nullable
              as List<int>,
      postBalances: postBalances == freezed
          ? _value.postBalances
          : postBalances // ignore: cast_nullable_to_non_nullable
              as List<int>,
      innerInstructions: innerInstructions == freezed
          ? _value.innerInstructions
          : innerInstructions // ignore: cast_nullable_to_non_nullable
              as List<InnerInstruction>,
      preTokenBalances: preTokenBalances == freezed
          ? _value.preTokenBalances
          : preTokenBalances // ignore: cast_nullable_to_non_nullable
              as List<TokenBalance>,
      postTokenBalances: postTokenBalances == freezed
          ? _value.postTokenBalances
          : postTokenBalances // ignore: cast_nullable_to_non_nullable
              as List<TokenBalance>,
      logMessages: logMessages == freezed
          ? _value.logMessages
          : logMessages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$MetaCopyWith<$Res> implements $MetaCopyWith<$Res> {
  factory _$MetaCopyWith(_Meta value, $Res Function(_Meta) then) =
      __$MetaCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, dynamic>? err,
      int fee,
      List<int> preBalances,
      List<int> postBalances,
      List<InnerInstruction> innerInstructions,
      List<TokenBalance> preTokenBalances,
      List<TokenBalance> postTokenBalances,
      List<String> logMessages});
}

/// @nodoc
class __$MetaCopyWithImpl<$Res> extends _$MetaCopyWithImpl<$Res>
    implements _$MetaCopyWith<$Res> {
  __$MetaCopyWithImpl(_Meta _value, $Res Function(_Meta) _then)
      : super(_value, (v) => _then(v as _Meta));

  @override
  _Meta get _value => super._value as _Meta;

  @override
  $Res call({
    Object? err = freezed,
    Object? fee = freezed,
    Object? preBalances = freezed,
    Object? postBalances = freezed,
    Object? innerInstructions = freezed,
    Object? preTokenBalances = freezed,
    Object? postTokenBalances = freezed,
    Object? logMessages = freezed,
  }) {
    return _then(_Meta(
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      preBalances: preBalances == freezed
          ? _value.preBalances
          : preBalances // ignore: cast_nullable_to_non_nullable
              as List<int>,
      postBalances: postBalances == freezed
          ? _value.postBalances
          : postBalances // ignore: cast_nullable_to_non_nullable
              as List<int>,
      innerInstructions: innerInstructions == freezed
          ? _value.innerInstructions
          : innerInstructions // ignore: cast_nullable_to_non_nullable
              as List<InnerInstruction>,
      preTokenBalances: preTokenBalances == freezed
          ? _value.preTokenBalances
          : preTokenBalances // ignore: cast_nullable_to_non_nullable
              as List<TokenBalance>,
      postTokenBalances: postTokenBalances == freezed
          ? _value.postTokenBalances
          : postTokenBalances // ignore: cast_nullable_to_non_nullable
              as List<TokenBalance>,
      logMessages: logMessages == freezed
          ? _value.logMessages
          : logMessages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Meta implements _Meta {
  const _$_Meta(
      {required this.err,
      required this.fee,
      required this.preBalances,
      required this.postBalances,
      required this.innerInstructions,
      required this.preTokenBalances,
      required this.postTokenBalances,
      required this.logMessages});

  factory _$_Meta.fromJson(Map<String, dynamic> json) => _$$_MetaFromJson(json);

  @override
  final Map<String, dynamic>? err;
  @override
  final int fee;
  @override
  final List<int> preBalances;
  @override
  final List<int> postBalances;
  @override
  final List<InnerInstruction> innerInstructions;
  @override
  final List<TokenBalance> preTokenBalances;
  @override
  final List<TokenBalance> postTokenBalances;
  @override
  final List<String> logMessages;

  @override
  String toString() {
    return 'Meta(err: $err, fee: $fee, preBalances: $preBalances, postBalances: $postBalances, innerInstructions: $innerInstructions, preTokenBalances: $preTokenBalances, postTokenBalances: $postTokenBalances, logMessages: $logMessages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Meta &&
            (identical(other.err, err) ||
                const DeepCollectionEquality().equals(other.err, err)) &&
            (identical(other.fee, fee) ||
                const DeepCollectionEquality().equals(other.fee, fee)) &&
            (identical(other.preBalances, preBalances) ||
                const DeepCollectionEquality()
                    .equals(other.preBalances, preBalances)) &&
            (identical(other.postBalances, postBalances) ||
                const DeepCollectionEquality()
                    .equals(other.postBalances, postBalances)) &&
            (identical(other.innerInstructions, innerInstructions) ||
                const DeepCollectionEquality()
                    .equals(other.innerInstructions, innerInstructions)) &&
            (identical(other.preTokenBalances, preTokenBalances) ||
                const DeepCollectionEquality()
                    .equals(other.preTokenBalances, preTokenBalances)) &&
            (identical(other.postTokenBalances, postTokenBalances) ||
                const DeepCollectionEquality()
                    .equals(other.postTokenBalances, postTokenBalances)) &&
            (identical(other.logMessages, logMessages) ||
                const DeepCollectionEquality()
                    .equals(other.logMessages, logMessages)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(err) ^
      const DeepCollectionEquality().hash(fee) ^
      const DeepCollectionEquality().hash(preBalances) ^
      const DeepCollectionEquality().hash(postBalances) ^
      const DeepCollectionEquality().hash(innerInstructions) ^
      const DeepCollectionEquality().hash(preTokenBalances) ^
      const DeepCollectionEquality().hash(postTokenBalances) ^
      const DeepCollectionEquality().hash(logMessages);

  @JsonKey(ignore: true)
  @override
  _$MetaCopyWith<_Meta> get copyWith =>
      __$MetaCopyWithImpl<_Meta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MetaToJson(this);
  }
}

abstract class _Meta implements Meta {
  const factory _Meta(
      {required Map<String, dynamic>? err,
      required int fee,
      required List<int> preBalances,
      required List<int> postBalances,
      required List<InnerInstruction> innerInstructions,
      required List<TokenBalance> preTokenBalances,
      required List<TokenBalance> postTokenBalances,
      required List<String> logMessages}) = _$_Meta;

  factory _Meta.fromJson(Map<String, dynamic> json) = _$_Meta.fromJson;

  @override
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  @override
  int get fee => throw _privateConstructorUsedError;
  @override
  List<int> get preBalances => throw _privateConstructorUsedError;
  @override
  List<int> get postBalances => throw _privateConstructorUsedError;
  @override
  List<InnerInstruction> get innerInstructions =>
      throw _privateConstructorUsedError;
  @override
  List<TokenBalance> get preTokenBalances => throw _privateConstructorUsedError;
  @override
  List<TokenBalance> get postTokenBalances =>
      throw _privateConstructorUsedError;
  @override
  List<String> get logMessages => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MetaCopyWith<_Meta> get copyWith => throw _privateConstructorUsedError;
}

Reward _$RewardFromJson(Map<String, dynamic> json) {
  return _Reward.fromJson(json);
}

/// @nodoc
class _$RewardTearOff {
  const _$RewardTearOff();

  _Reward call(
      {required String pubkey,
      required int lamports,
      required int postBalance,
      required RewardType rewardType,
      required int commission}) {
    return _Reward(
      pubkey: pubkey,
      lamports: lamports,
      postBalance: postBalance,
      rewardType: rewardType,
      commission: commission,
    );
  }

  Reward fromJson(Map<String, Object> json) {
    return Reward.fromJson(json);
  }
}

/// @nodoc
const $Reward = _$RewardTearOff();

/// @nodoc
mixin _$Reward {
  String get pubkey => throw _privateConstructorUsedError;
  int get lamports => throw _privateConstructorUsedError;
  int get postBalance => throw _privateConstructorUsedError;
  RewardType get rewardType => throw _privateConstructorUsedError;
  int get commission => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardCopyWith<Reward> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardCopyWith<$Res> {
  factory $RewardCopyWith(Reward value, $Res Function(Reward) then) =
      _$RewardCopyWithImpl<$Res>;
  $Res call(
      {String pubkey,
      int lamports,
      int postBalance,
      RewardType rewardType,
      int commission});
}

/// @nodoc
class _$RewardCopyWithImpl<$Res> implements $RewardCopyWith<$Res> {
  _$RewardCopyWithImpl(this._value, this._then);

  final Reward _value;
  // ignore: unused_field
  final $Res Function(Reward) _then;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? lamports = freezed,
    Object? postBalance = freezed,
    Object? rewardType = freezed,
    Object? commission = freezed,
  }) {
    return _then(_value.copyWith(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      postBalance: postBalance == freezed
          ? _value.postBalance
          : postBalance // ignore: cast_nullable_to_non_nullable
              as int,
      rewardType: rewardType == freezed
          ? _value.rewardType
          : rewardType // ignore: cast_nullable_to_non_nullable
              as RewardType,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$RewardCopyWith<$Res> implements $RewardCopyWith<$Res> {
  factory _$RewardCopyWith(_Reward value, $Res Function(_Reward) then) =
      __$RewardCopyWithImpl<$Res>;
  @override
  $Res call(
      {String pubkey,
      int lamports,
      int postBalance,
      RewardType rewardType,
      int commission});
}

/// @nodoc
class __$RewardCopyWithImpl<$Res> extends _$RewardCopyWithImpl<$Res>
    implements _$RewardCopyWith<$Res> {
  __$RewardCopyWithImpl(_Reward _value, $Res Function(_Reward) _then)
      : super(_value, (v) => _then(v as _Reward));

  @override
  _Reward get _value => super._value as _Reward;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? lamports = freezed,
    Object? postBalance = freezed,
    Object? rewardType = freezed,
    Object? commission = freezed,
  }) {
    return _then(_Reward(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
      postBalance: postBalance == freezed
          ? _value.postBalance
          : postBalance // ignore: cast_nullable_to_non_nullable
              as int,
      rewardType: rewardType == freezed
          ? _value.rewardType
          : rewardType // ignore: cast_nullable_to_non_nullable
              as RewardType,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reward implements _Reward {
  const _$_Reward(
      {required this.pubkey,
      required this.lamports,
      required this.postBalance,
      required this.rewardType,
      required this.commission});

  factory _$_Reward.fromJson(Map<String, dynamic> json) =>
      _$$_RewardFromJson(json);

  @override
  final String pubkey;
  @override
  final int lamports;
  @override
  final int postBalance;
  @override
  final RewardType rewardType;
  @override
  final int commission;

  @override
  String toString() {
    return 'Reward(pubkey: $pubkey, lamports: $lamports, postBalance: $postBalance, rewardType: $rewardType, commission: $commission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reward &&
            (identical(other.pubkey, pubkey) ||
                const DeepCollectionEquality().equals(other.pubkey, pubkey)) &&
            (identical(other.lamports, lamports) ||
                const DeepCollectionEquality()
                    .equals(other.lamports, lamports)) &&
            (identical(other.postBalance, postBalance) ||
                const DeepCollectionEquality()
                    .equals(other.postBalance, postBalance)) &&
            (identical(other.rewardType, rewardType) ||
                const DeepCollectionEquality()
                    .equals(other.rewardType, rewardType)) &&
            (identical(other.commission, commission) ||
                const DeepCollectionEquality()
                    .equals(other.commission, commission)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pubkey) ^
      const DeepCollectionEquality().hash(lamports) ^
      const DeepCollectionEquality().hash(postBalance) ^
      const DeepCollectionEquality().hash(rewardType) ^
      const DeepCollectionEquality().hash(commission);

  @JsonKey(ignore: true)
  @override
  _$RewardCopyWith<_Reward> get copyWith =>
      __$RewardCopyWithImpl<_Reward>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RewardToJson(this);
  }
}

abstract class _Reward implements Reward {
  const factory _Reward(
      {required String pubkey,
      required int lamports,
      required int postBalance,
      required RewardType rewardType,
      required int commission}) = _$_Reward;

  factory _Reward.fromJson(Map<String, dynamic> json) = _$_Reward.fromJson;

  @override
  String get pubkey => throw _privateConstructorUsedError;
  @override
  int get lamports => throw _privateConstructorUsedError;
  @override
  int get postBalance => throw _privateConstructorUsedError;
  @override
  RewardType get rewardType => throw _privateConstructorUsedError;
  @override
  int get commission => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RewardCopyWith<_Reward> get copyWith => throw _privateConstructorUsedError;
}

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  _Transaction call(
      {required List<String> signatures,
      required Map<String, dynamic> message}) {
    return _Transaction(
      signatures: signatures,
      message: message,
    );
  }

  Transaction fromJson(Map<String, Object> json) {
    return Transaction.fromJson(json);
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  List<String> get signatures => throw _privateConstructorUsedError;
  Map<String, dynamic> get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call({List<String> signatures, Map<String, dynamic> message});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? signatures = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      signatures: signatures == freezed
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) then) =
      __$TransactionCopyWithImpl<$Res>;
  @override
  $Res call({List<String> signatures, Map<String, dynamic> message});
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(
      _Transaction _value, $Res Function(_Transaction) _then)
      : super(_value, (v) => _then(v as _Transaction));

  @override
  _Transaction get _value => super._value as _Transaction;

  @override
  $Res call({
    Object? signatures = freezed,
    Object? message = freezed,
  }) {
    return _then(_Transaction(
      signatures: signatures == freezed
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaction implements _Transaction {
  const _$_Transaction({required this.signatures, required this.message});

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  @override
  final List<String> signatures;
  @override
  final Map<String, dynamic> message;

  @override
  String toString() {
    return 'Transaction(signatures: $signatures, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Transaction &&
            (identical(other.signatures, signatures) ||
                const DeepCollectionEquality()
                    .equals(other.signatures, signatures)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(signatures) ^
      const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(this);
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
      {required List<String> signatures,
      required Map<String, dynamic> message}) = _$_Transaction;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override
  List<String> get signatures => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic> get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionCopyWith<_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) {
  return _TransactionDetails.fromJson(json);
}

/// @nodoc
class _$TransactionDetailsTearOff {
  const _$TransactionDetailsTearOff();

  _TransactionDetails call(
      {required int slot,
      required Transaction transaction,
      required int? blockTime,
      required Meta meta}) {
    return _TransactionDetails(
      slot: slot,
      transaction: transaction,
      blockTime: blockTime,
      meta: meta,
    );
  }

  TransactionDetails fromJson(Map<String, Object> json) {
    return TransactionDetails.fromJson(json);
  }
}

/// @nodoc
const $TransactionDetails = _$TransactionDetailsTearOff();

/// @nodoc
mixin _$TransactionDetails {
  int get slot => throw _privateConstructorUsedError;
  Transaction get transaction => throw _privateConstructorUsedError;
  int? get blockTime => throw _privateConstructorUsedError;
  Meta get meta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionDetailsCopyWith<TransactionDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDetailsCopyWith<$Res> {
  factory $TransactionDetailsCopyWith(
          TransactionDetails value, $Res Function(TransactionDetails) then) =
      _$TransactionDetailsCopyWithImpl<$Res>;
  $Res call({int slot, Transaction transaction, int? blockTime, Meta meta});

  $TransactionCopyWith<$Res> get transaction;
  $MetaCopyWith<$Res> get meta;
}

/// @nodoc
class _$TransactionDetailsCopyWithImpl<$Res>
    implements $TransactionDetailsCopyWith<$Res> {
  _$TransactionDetailsCopyWithImpl(this._value, this._then);

  final TransactionDetails _value;
  // ignore: unused_field
  final $Res Function(TransactionDetails) _then;

  @override
  $Res call({
    Object? slot = freezed,
    Object? transaction = freezed,
    Object? blockTime = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta,
    ));
  }

  @override
  $TransactionCopyWith<$Res> get transaction {
    return $TransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }

  @override
  $MetaCopyWith<$Res> get meta {
    return $MetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value));
    });
  }
}

/// @nodoc
abstract class _$TransactionDetailsCopyWith<$Res>
    implements $TransactionDetailsCopyWith<$Res> {
  factory _$TransactionDetailsCopyWith(
          _TransactionDetails value, $Res Function(_TransactionDetails) then) =
      __$TransactionDetailsCopyWithImpl<$Res>;
  @override
  $Res call({int slot, Transaction transaction, int? blockTime, Meta meta});

  @override
  $TransactionCopyWith<$Res> get transaction;
  @override
  $MetaCopyWith<$Res> get meta;
}

/// @nodoc
class __$TransactionDetailsCopyWithImpl<$Res>
    extends _$TransactionDetailsCopyWithImpl<$Res>
    implements _$TransactionDetailsCopyWith<$Res> {
  __$TransactionDetailsCopyWithImpl(
      _TransactionDetails _value, $Res Function(_TransactionDetails) _then)
      : super(_value, (v) => _then(v as _TransactionDetails));

  @override
  _TransactionDetails get _value => super._value as _TransactionDetails;

  @override
  $Res call({
    Object? slot = freezed,
    Object? transaction = freezed,
    Object? blockTime = freezed,
    Object? meta = freezed,
  }) {
    return _then(_TransactionDetails(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionDetails implements _TransactionDetails {
  const _$_TransactionDetails(
      {required this.slot,
      required this.transaction,
      required this.blockTime,
      required this.meta});

  factory _$_TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionDetailsFromJson(json);

  @override
  final int slot;
  @override
  final Transaction transaction;
  @override
  final int? blockTime;
  @override
  final Meta meta;

  @override
  String toString() {
    return 'TransactionDetails(slot: $slot, transaction: $transaction, blockTime: $blockTime, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransactionDetails &&
            (identical(other.slot, slot) ||
                const DeepCollectionEquality().equals(other.slot, slot)) &&
            (identical(other.transaction, transaction) ||
                const DeepCollectionEquality()
                    .equals(other.transaction, transaction)) &&
            (identical(other.blockTime, blockTime) ||
                const DeepCollectionEquality()
                    .equals(other.blockTime, blockTime)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(slot) ^
      const DeepCollectionEquality().hash(transaction) ^
      const DeepCollectionEquality().hash(blockTime) ^
      const DeepCollectionEquality().hash(meta);

  @JsonKey(ignore: true)
  @override
  _$TransactionDetailsCopyWith<_TransactionDetails> get copyWith =>
      __$TransactionDetailsCopyWithImpl<_TransactionDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionDetailsToJson(this);
  }
}

abstract class _TransactionDetails implements TransactionDetails {
  const factory _TransactionDetails(
      {required int slot,
      required Transaction transaction,
      required int? blockTime,
      required Meta meta}) = _$_TransactionDetails;

  factory _TransactionDetails.fromJson(Map<String, dynamic> json) =
      _$_TransactionDetails.fromJson;

  @override
  int get slot => throw _privateConstructorUsedError;
  @override
  Transaction get transaction => throw _privateConstructorUsedError;
  @override
  int? get blockTime => throw _privateConstructorUsedError;
  @override
  Meta get meta => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionDetailsCopyWith<_TransactionDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

InnerInstruction _$InnerInstructionFromJson(Map<String, dynamic> json) {
  return _InnerInstruction.fromJson(json);
}

/// @nodoc
class _$InnerInstructionTearOff {
  const _$InnerInstructionTearOff();

  _InnerInstruction call(
      {required int index, required List<Instruction> instruction}) {
    return _InnerInstruction(
      index: index,
      instruction: instruction,
    );
  }

  InnerInstruction fromJson(Map<String, Object> json) {
    return InnerInstruction.fromJson(json);
  }
}

/// @nodoc
const $InnerInstruction = _$InnerInstructionTearOff();

/// @nodoc
mixin _$InnerInstruction {
  int get index => throw _privateConstructorUsedError;
  List<Instruction> get instruction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InnerInstructionCopyWith<InnerInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InnerInstructionCopyWith<$Res> {
  factory $InnerInstructionCopyWith(
          InnerInstruction value, $Res Function(InnerInstruction) then) =
      _$InnerInstructionCopyWithImpl<$Res>;
  $Res call({int index, List<Instruction> instruction});
}

/// @nodoc
class _$InnerInstructionCopyWithImpl<$Res>
    implements $InnerInstructionCopyWith<$Res> {
  _$InnerInstructionCopyWithImpl(this._value, this._then);

  final InnerInstruction _value;
  // ignore: unused_field
  final $Res Function(InnerInstruction) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? instruction = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      instruction: instruction == freezed
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as List<Instruction>,
    ));
  }
}

/// @nodoc
abstract class _$InnerInstructionCopyWith<$Res>
    implements $InnerInstructionCopyWith<$Res> {
  factory _$InnerInstructionCopyWith(
          _InnerInstruction value, $Res Function(_InnerInstruction) then) =
      __$InnerInstructionCopyWithImpl<$Res>;
  @override
  $Res call({int index, List<Instruction> instruction});
}

/// @nodoc
class __$InnerInstructionCopyWithImpl<$Res>
    extends _$InnerInstructionCopyWithImpl<$Res>
    implements _$InnerInstructionCopyWith<$Res> {
  __$InnerInstructionCopyWithImpl(
      _InnerInstruction _value, $Res Function(_InnerInstruction) _then)
      : super(_value, (v) => _then(v as _InnerInstruction));

  @override
  _InnerInstruction get _value => super._value as _InnerInstruction;

  @override
  $Res call({
    Object? index = freezed,
    Object? instruction = freezed,
  }) {
    return _then(_InnerInstruction(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      instruction: instruction == freezed
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as List<Instruction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InnerInstruction implements _InnerInstruction {
  const _$_InnerInstruction({required this.index, required this.instruction});

  factory _$_InnerInstruction.fromJson(Map<String, dynamic> json) =>
      _$$_InnerInstructionFromJson(json);

  @override
  final int index;
  @override
  final List<Instruction> instruction;

  @override
  String toString() {
    return 'InnerInstruction(index: $index, instruction: $instruction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InnerInstruction &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)) &&
            (identical(other.instruction, instruction) ||
                const DeepCollectionEquality()
                    .equals(other.instruction, instruction)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(index) ^
      const DeepCollectionEquality().hash(instruction);

  @JsonKey(ignore: true)
  @override
  _$InnerInstructionCopyWith<_InnerInstruction> get copyWith =>
      __$InnerInstructionCopyWithImpl<_InnerInstruction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InnerInstructionToJson(this);
  }
}

abstract class _InnerInstruction implements InnerInstruction {
  const factory _InnerInstruction(
      {required int index,
      required List<Instruction> instruction}) = _$_InnerInstruction;

  factory _InnerInstruction.fromJson(Map<String, dynamic> json) =
      _$_InnerInstruction.fromJson;

  @override
  int get index => throw _privateConstructorUsedError;
  @override
  List<Instruction> get instruction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InnerInstructionCopyWith<_InnerInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

Instruction _$InstructionFromJson(Map<String, dynamic> json) {
  return _Instruction.fromJson(json);
}

/// @nodoc
class _$InstructionTearOff {
  const _$InstructionTearOff();

  _Instruction call(
      {required int programIdIndex,
      required List<int> accounts,
      required String data}) {
    return _Instruction(
      programIdIndex: programIdIndex,
      accounts: accounts,
      data: data,
    );
  }

  Instruction fromJson(Map<String, Object> json) {
    return Instruction.fromJson(json);
  }
}

/// @nodoc
const $Instruction = _$InstructionTearOff();

/// @nodoc
mixin _$Instruction {
  int get programIdIndex => throw _privateConstructorUsedError;
  List<int> get accounts => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InstructionCopyWith<Instruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstructionCopyWith<$Res> {
  factory $InstructionCopyWith(
          Instruction value, $Res Function(Instruction) then) =
      _$InstructionCopyWithImpl<$Res>;
  $Res call({int programIdIndex, List<int> accounts, String data});
}

/// @nodoc
class _$InstructionCopyWithImpl<$Res> implements $InstructionCopyWith<$Res> {
  _$InstructionCopyWithImpl(this._value, this._then);

  final Instruction _value;
  // ignore: unused_field
  final $Res Function(Instruction) _then;

  @override
  $Res call({
    Object? programIdIndex = freezed,
    Object? accounts = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      programIdIndex: programIdIndex == freezed
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$InstructionCopyWith<$Res>
    implements $InstructionCopyWith<$Res> {
  factory _$InstructionCopyWith(
          _Instruction value, $Res Function(_Instruction) then) =
      __$InstructionCopyWithImpl<$Res>;
  @override
  $Res call({int programIdIndex, List<int> accounts, String data});
}

/// @nodoc
class __$InstructionCopyWithImpl<$Res> extends _$InstructionCopyWithImpl<$Res>
    implements _$InstructionCopyWith<$Res> {
  __$InstructionCopyWithImpl(
      _Instruction _value, $Res Function(_Instruction) _then)
      : super(_value, (v) => _then(v as _Instruction));

  @override
  _Instruction get _value => super._value as _Instruction;

  @override
  $Res call({
    Object? programIdIndex = freezed,
    Object? accounts = freezed,
    Object? data = freezed,
  }) {
    return _then(_Instruction(
      programIdIndex: programIdIndex == freezed
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Instruction implements _Instruction {
  const _$_Instruction(
      {required this.programIdIndex,
      required this.accounts,
      required this.data});

  factory _$_Instruction.fromJson(Map<String, dynamic> json) =>
      _$$_InstructionFromJson(json);

  @override
  final int programIdIndex;
  @override
  final List<int> accounts;
  @override
  final String data;

  @override
  String toString() {
    return 'Instruction(programIdIndex: $programIdIndex, accounts: $accounts, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Instruction &&
            (identical(other.programIdIndex, programIdIndex) ||
                const DeepCollectionEquality()
                    .equals(other.programIdIndex, programIdIndex)) &&
            (identical(other.accounts, accounts) ||
                const DeepCollectionEquality()
                    .equals(other.accounts, accounts)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(programIdIndex) ^
      const DeepCollectionEquality().hash(accounts) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$InstructionCopyWith<_Instruction> get copyWith =>
      __$InstructionCopyWithImpl<_Instruction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InstructionToJson(this);
  }
}

abstract class _Instruction implements Instruction {
  const factory _Instruction(
      {required int programIdIndex,
      required List<int> accounts,
      required String data}) = _$_Instruction;

  factory _Instruction.fromJson(Map<String, dynamic> json) =
      _$_Instruction.fromJson;

  @override
  int get programIdIndex => throw _privateConstructorUsedError;
  @override
  List<int> get accounts => throw _privateConstructorUsedError;
  @override
  String get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InstructionCopyWith<_Instruction> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) {
  return _TokenAmount.fromJson(json);
}

/// @nodoc
class _$TokenAmountTearOff {
  const _$TokenAmountTearOff();

  _TokenAmount call(
      {required String amount,
      required int decimals,
      required String? uiAmountString}) {
    return _TokenAmount(
      amount: amount,
      decimals: decimals,
      uiAmountString: uiAmountString,
    );
  }

  TokenAmount fromJson(Map<String, Object> json) {
    return TokenAmount.fromJson(json);
  }
}

/// @nodoc
const $TokenAmount = _$TokenAmountTearOff();

/// @nodoc
mixin _$TokenAmount {
  String get amount => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  String? get uiAmountString => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenAmountCopyWith<TokenAmount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenAmountCopyWith<$Res> {
  factory $TokenAmountCopyWith(
          TokenAmount value, $Res Function(TokenAmount) then) =
      _$TokenAmountCopyWithImpl<$Res>;
  $Res call({String amount, int decimals, String? uiAmountString});
}

/// @nodoc
class _$TokenAmountCopyWithImpl<$Res> implements $TokenAmountCopyWith<$Res> {
  _$TokenAmountCopyWithImpl(this._value, this._then);

  final TokenAmount _value;
  // ignore: unused_field
  final $Res Function(TokenAmount) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? decimals = freezed,
    Object? uiAmountString = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      uiAmountString: uiAmountString == freezed
          ? _value.uiAmountString
          : uiAmountString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$TokenAmountCopyWith<$Res>
    implements $TokenAmountCopyWith<$Res> {
  factory _$TokenAmountCopyWith(
          _TokenAmount value, $Res Function(_TokenAmount) then) =
      __$TokenAmountCopyWithImpl<$Res>;
  @override
  $Res call({String amount, int decimals, String? uiAmountString});
}

/// @nodoc
class __$TokenAmountCopyWithImpl<$Res> extends _$TokenAmountCopyWithImpl<$Res>
    implements _$TokenAmountCopyWith<$Res> {
  __$TokenAmountCopyWithImpl(
      _TokenAmount _value, $Res Function(_TokenAmount) _then)
      : super(_value, (v) => _then(v as _TokenAmount));

  @override
  _TokenAmount get _value => super._value as _TokenAmount;

  @override
  $Res call({
    Object? amount = freezed,
    Object? decimals = freezed,
    Object? uiAmountString = freezed,
  }) {
    return _then(_TokenAmount(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      uiAmountString: uiAmountString == freezed
          ? _value.uiAmountString
          : uiAmountString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenAmount implements _TokenAmount {
  const _$_TokenAmount(
      {required this.amount,
      required this.decimals,
      required this.uiAmountString});

  factory _$_TokenAmount.fromJson(Map<String, dynamic> json) =>
      _$$_TokenAmountFromJson(json);

  @override
  final String amount;
  @override
  final int decimals;
  @override
  final String? uiAmountString;

  @override
  String toString() {
    return 'TokenAmount(amount: $amount, decimals: $decimals, uiAmountString: $uiAmountString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TokenAmount &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.decimals, decimals) ||
                const DeepCollectionEquality()
                    .equals(other.decimals, decimals)) &&
            (identical(other.uiAmountString, uiAmountString) ||
                const DeepCollectionEquality()
                    .equals(other.uiAmountString, uiAmountString)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(decimals) ^
      const DeepCollectionEquality().hash(uiAmountString);

  @JsonKey(ignore: true)
  @override
  _$TokenAmountCopyWith<_TokenAmount> get copyWith =>
      __$TokenAmountCopyWithImpl<_TokenAmount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenAmountToJson(this);
  }
}

abstract class _TokenAmount implements TokenAmount {
  const factory _TokenAmount(
      {required String amount,
      required int decimals,
      required String? uiAmountString}) = _$_TokenAmount;

  factory _TokenAmount.fromJson(Map<String, dynamic> json) =
      _$_TokenAmount.fromJson;

  @override
  String get amount => throw _privateConstructorUsedError;
  @override
  int get decimals => throw _privateConstructorUsedError;
  @override
  String? get uiAmountString => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TokenAmountCopyWith<_TokenAmount> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenBalance _$TokenBalanceFromJson(Map<String, dynamic> json) {
  return _TokenBalance.fromJson(json);
}

/// @nodoc
class _$TokenBalanceTearOff {
  const _$TokenBalanceTearOff();

  _TokenBalance call(
      {required int accountIndex,
      required String mint,
      required TokenAmount uiTokenAmount}) {
    return _TokenBalance(
      accountIndex: accountIndex,
      mint: mint,
      uiTokenAmount: uiTokenAmount,
    );
  }

  TokenBalance fromJson(Map<String, Object> json) {
    return TokenBalance.fromJson(json);
  }
}

/// @nodoc
const $TokenBalance = _$TokenBalanceTearOff();

/// @nodoc
mixin _$TokenBalance {
  int get accountIndex => throw _privateConstructorUsedError;
  String get mint => throw _privateConstructorUsedError;
  TokenAmount get uiTokenAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenBalanceCopyWith<TokenBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenBalanceCopyWith<$Res> {
  factory $TokenBalanceCopyWith(
          TokenBalance value, $Res Function(TokenBalance) then) =
      _$TokenBalanceCopyWithImpl<$Res>;
  $Res call({int accountIndex, String mint, TokenAmount uiTokenAmount});

  $TokenAmountCopyWith<$Res> get uiTokenAmount;
}

/// @nodoc
class _$TokenBalanceCopyWithImpl<$Res> implements $TokenBalanceCopyWith<$Res> {
  _$TokenBalanceCopyWithImpl(this._value, this._then);

  final TokenBalance _value;
  // ignore: unused_field
  final $Res Function(TokenBalance) _then;

  @override
  $Res call({
    Object? accountIndex = freezed,
    Object? mint = freezed,
    Object? uiTokenAmount = freezed,
  }) {
    return _then(_value.copyWith(
      accountIndex: accountIndex == freezed
          ? _value.accountIndex
          : accountIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String,
      uiTokenAmount: uiTokenAmount == freezed
          ? _value.uiTokenAmount
          : uiTokenAmount // ignore: cast_nullable_to_non_nullable
              as TokenAmount,
    ));
  }

  @override
  $TokenAmountCopyWith<$Res> get uiTokenAmount {
    return $TokenAmountCopyWith<$Res>(_value.uiTokenAmount, (value) {
      return _then(_value.copyWith(uiTokenAmount: value));
    });
  }
}

/// @nodoc
abstract class _$TokenBalanceCopyWith<$Res>
    implements $TokenBalanceCopyWith<$Res> {
  factory _$TokenBalanceCopyWith(
          _TokenBalance value, $Res Function(_TokenBalance) then) =
      __$TokenBalanceCopyWithImpl<$Res>;
  @override
  $Res call({int accountIndex, String mint, TokenAmount uiTokenAmount});

  @override
  $TokenAmountCopyWith<$Res> get uiTokenAmount;
}

/// @nodoc
class __$TokenBalanceCopyWithImpl<$Res> extends _$TokenBalanceCopyWithImpl<$Res>
    implements _$TokenBalanceCopyWith<$Res> {
  __$TokenBalanceCopyWithImpl(
      _TokenBalance _value, $Res Function(_TokenBalance) _then)
      : super(_value, (v) => _then(v as _TokenBalance));

  @override
  _TokenBalance get _value => super._value as _TokenBalance;

  @override
  $Res call({
    Object? accountIndex = freezed,
    Object? mint = freezed,
    Object? uiTokenAmount = freezed,
  }) {
    return _then(_TokenBalance(
      accountIndex: accountIndex == freezed
          ? _value.accountIndex
          : accountIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String,
      uiTokenAmount: uiTokenAmount == freezed
          ? _value.uiTokenAmount
          : uiTokenAmount // ignore: cast_nullable_to_non_nullable
              as TokenAmount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenBalance implements _TokenBalance {
  const _$_TokenBalance(
      {required this.accountIndex,
      required this.mint,
      required this.uiTokenAmount});

  factory _$_TokenBalance.fromJson(Map<String, dynamic> json) =>
      _$$_TokenBalanceFromJson(json);

  @override
  final int accountIndex;
  @override
  final String mint;
  @override
  final TokenAmount uiTokenAmount;

  @override
  String toString() {
    return 'TokenBalance(accountIndex: $accountIndex, mint: $mint, uiTokenAmount: $uiTokenAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TokenBalance &&
            (identical(other.accountIndex, accountIndex) ||
                const DeepCollectionEquality()
                    .equals(other.accountIndex, accountIndex)) &&
            (identical(other.mint, mint) ||
                const DeepCollectionEquality().equals(other.mint, mint)) &&
            (identical(other.uiTokenAmount, uiTokenAmount) ||
                const DeepCollectionEquality()
                    .equals(other.uiTokenAmount, uiTokenAmount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(accountIndex) ^
      const DeepCollectionEquality().hash(mint) ^
      const DeepCollectionEquality().hash(uiTokenAmount);

  @JsonKey(ignore: true)
  @override
  _$TokenBalanceCopyWith<_TokenBalance> get copyWith =>
      __$TokenBalanceCopyWithImpl<_TokenBalance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenBalanceToJson(this);
  }
}

abstract class _TokenBalance implements TokenBalance {
  const factory _TokenBalance(
      {required int accountIndex,
      required String mint,
      required TokenAmount uiTokenAmount}) = _$_TokenBalance;

  factory _TokenBalance.fromJson(Map<String, dynamic> json) =
      _$_TokenBalance.fromJson;

  @override
  int get accountIndex => throw _privateConstructorUsedError;
  @override
  String get mint => throw _privateConstructorUsedError;
  @override
  TokenAmount get uiTokenAmount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TokenBalanceCopyWith<_TokenBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

ClusterNode _$ClusterNodeFromJson(Map<String, dynamic> json) {
  return _ClusterNode.fromJson(json);
}

/// @nodoc
class _$ClusterNodeTearOff {
  const _$ClusterNodeTearOff();

  _ClusterNode call(
      {required String pubkey,
      required String gossip,
      required String tpu,
      required String? rpc,
      required String? version,
      required int? featureSet,
      required int? shredVersion}) {
    return _ClusterNode(
      pubkey: pubkey,
      gossip: gossip,
      tpu: tpu,
      rpc: rpc,
      version: version,
      featureSet: featureSet,
      shredVersion: shredVersion,
    );
  }

  ClusterNode fromJson(Map<String, Object> json) {
    return ClusterNode.fromJson(json);
  }
}

/// @nodoc
const $ClusterNode = _$ClusterNodeTearOff();

/// @nodoc
mixin _$ClusterNode {
  String get pubkey => throw _privateConstructorUsedError;
  String get gossip => throw _privateConstructorUsedError;
  String get tpu => throw _privateConstructorUsedError;
  String? get rpc => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  int? get featureSet => throw _privateConstructorUsedError;
  int? get shredVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClusterNodeCopyWith<ClusterNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClusterNodeCopyWith<$Res> {
  factory $ClusterNodeCopyWith(
          ClusterNode value, $Res Function(ClusterNode) then) =
      _$ClusterNodeCopyWithImpl<$Res>;
  $Res call(
      {String pubkey,
      String gossip,
      String tpu,
      String? rpc,
      String? version,
      int? featureSet,
      int? shredVersion});
}

/// @nodoc
class _$ClusterNodeCopyWithImpl<$Res> implements $ClusterNodeCopyWith<$Res> {
  _$ClusterNodeCopyWithImpl(this._value, this._then);

  final ClusterNode _value;
  // ignore: unused_field
  final $Res Function(ClusterNode) _then;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? gossip = freezed,
    Object? tpu = freezed,
    Object? rpc = freezed,
    Object? version = freezed,
    Object? featureSet = freezed,
    Object? shredVersion = freezed,
  }) {
    return _then(_value.copyWith(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      gossip: gossip == freezed
          ? _value.gossip
          : gossip // ignore: cast_nullable_to_non_nullable
              as String,
      tpu: tpu == freezed
          ? _value.tpu
          : tpu // ignore: cast_nullable_to_non_nullable
              as String,
      rpc: rpc == freezed
          ? _value.rpc
          : rpc // ignore: cast_nullable_to_non_nullable
              as String?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      featureSet: featureSet == freezed
          ? _value.featureSet
          : featureSet // ignore: cast_nullable_to_non_nullable
              as int?,
      shredVersion: shredVersion == freezed
          ? _value.shredVersion
          : shredVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$ClusterNodeCopyWith<$Res>
    implements $ClusterNodeCopyWith<$Res> {
  factory _$ClusterNodeCopyWith(
          _ClusterNode value, $Res Function(_ClusterNode) then) =
      __$ClusterNodeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String pubkey,
      String gossip,
      String tpu,
      String? rpc,
      String? version,
      int? featureSet,
      int? shredVersion});
}

/// @nodoc
class __$ClusterNodeCopyWithImpl<$Res> extends _$ClusterNodeCopyWithImpl<$Res>
    implements _$ClusterNodeCopyWith<$Res> {
  __$ClusterNodeCopyWithImpl(
      _ClusterNode _value, $Res Function(_ClusterNode) _then)
      : super(_value, (v) => _then(v as _ClusterNode));

  @override
  _ClusterNode get _value => super._value as _ClusterNode;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? gossip = freezed,
    Object? tpu = freezed,
    Object? rpc = freezed,
    Object? version = freezed,
    Object? featureSet = freezed,
    Object? shredVersion = freezed,
  }) {
    return _then(_ClusterNode(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      gossip: gossip == freezed
          ? _value.gossip
          : gossip // ignore: cast_nullable_to_non_nullable
              as String,
      tpu: tpu == freezed
          ? _value.tpu
          : tpu // ignore: cast_nullable_to_non_nullable
              as String,
      rpc: rpc == freezed
          ? _value.rpc
          : rpc // ignore: cast_nullable_to_non_nullable
              as String?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      featureSet: featureSet == freezed
          ? _value.featureSet
          : featureSet // ignore: cast_nullable_to_non_nullable
              as int?,
      shredVersion: shredVersion == freezed
          ? _value.shredVersion
          : shredVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClusterNode implements _ClusterNode {
  const _$_ClusterNode(
      {required this.pubkey,
      required this.gossip,
      required this.tpu,
      required this.rpc,
      required this.version,
      required this.featureSet,
      required this.shredVersion});

  factory _$_ClusterNode.fromJson(Map<String, dynamic> json) =>
      _$$_ClusterNodeFromJson(json);

  @override
  final String pubkey;
  @override
  final String gossip;
  @override
  final String tpu;
  @override
  final String? rpc;
  @override
  final String? version;
  @override
  final int? featureSet;
  @override
  final int? shredVersion;

  @override
  String toString() {
    return 'ClusterNode(pubkey: $pubkey, gossip: $gossip, tpu: $tpu, rpc: $rpc, version: $version, featureSet: $featureSet, shredVersion: $shredVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClusterNode &&
            (identical(other.pubkey, pubkey) ||
                const DeepCollectionEquality().equals(other.pubkey, pubkey)) &&
            (identical(other.gossip, gossip) ||
                const DeepCollectionEquality().equals(other.gossip, gossip)) &&
            (identical(other.tpu, tpu) ||
                const DeepCollectionEquality().equals(other.tpu, tpu)) &&
            (identical(other.rpc, rpc) ||
                const DeepCollectionEquality().equals(other.rpc, rpc)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.featureSet, featureSet) ||
                const DeepCollectionEquality()
                    .equals(other.featureSet, featureSet)) &&
            (identical(other.shredVersion, shredVersion) ||
                const DeepCollectionEquality()
                    .equals(other.shredVersion, shredVersion)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pubkey) ^
      const DeepCollectionEquality().hash(gossip) ^
      const DeepCollectionEquality().hash(tpu) ^
      const DeepCollectionEquality().hash(rpc) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(featureSet) ^
      const DeepCollectionEquality().hash(shredVersion);

  @JsonKey(ignore: true)
  @override
  _$ClusterNodeCopyWith<_ClusterNode> get copyWith =>
      __$ClusterNodeCopyWithImpl<_ClusterNode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClusterNodeToJson(this);
  }
}

abstract class _ClusterNode implements ClusterNode {
  const factory _ClusterNode(
      {required String pubkey,
      required String gossip,
      required String tpu,
      required String? rpc,
      required String? version,
      required int? featureSet,
      required int? shredVersion}) = _$_ClusterNode;

  factory _ClusterNode.fromJson(Map<String, dynamic> json) =
      _$_ClusterNode.fromJson;

  @override
  String get pubkey => throw _privateConstructorUsedError;
  @override
  String get gossip => throw _privateConstructorUsedError;
  @override
  String get tpu => throw _privateConstructorUsedError;
  @override
  String? get rpc => throw _privateConstructorUsedError;
  @override
  String? get version => throw _privateConstructorUsedError;
  @override
  int? get featureSet => throw _privateConstructorUsedError;
  @override
  int? get shredVersion => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ClusterNodeCopyWith<_ClusterNode> get copyWith =>
      throw _privateConstructorUsedError;
}

EpochInfo _$EpochInfoFromJson(Map<String, dynamic> json) {
  return _EpochInfo.fromJson(json);
}

/// @nodoc
class _$EpochInfoTearOff {
  const _$EpochInfoTearOff();

  _EpochInfo call(
      {required int absoluteSlot,
      required int blockHeight,
      required int epoch,
      required int slotIndex,
      required int slotsInEpoch}) {
    return _EpochInfo(
      absoluteSlot: absoluteSlot,
      blockHeight: blockHeight,
      epoch: epoch,
      slotIndex: slotIndex,
      slotsInEpoch: slotsInEpoch,
    );
  }

  EpochInfo fromJson(Map<String, Object> json) {
    return EpochInfo.fromJson(json);
  }
}

/// @nodoc
const $EpochInfo = _$EpochInfoTearOff();

/// @nodoc
mixin _$EpochInfo {
  int get absoluteSlot => throw _privateConstructorUsedError;
  int get blockHeight => throw _privateConstructorUsedError;
  int get epoch => throw _privateConstructorUsedError;
  int get slotIndex => throw _privateConstructorUsedError;
  int get slotsInEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EpochInfoCopyWith<EpochInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpochInfoCopyWith<$Res> {
  factory $EpochInfoCopyWith(EpochInfo value, $Res Function(EpochInfo) then) =
      _$EpochInfoCopyWithImpl<$Res>;
  $Res call(
      {int absoluteSlot,
      int blockHeight,
      int epoch,
      int slotIndex,
      int slotsInEpoch});
}

/// @nodoc
class _$EpochInfoCopyWithImpl<$Res> implements $EpochInfoCopyWith<$Res> {
  _$EpochInfoCopyWithImpl(this._value, this._then);

  final EpochInfo _value;
  // ignore: unused_field
  final $Res Function(EpochInfo) _then;

  @override
  $Res call({
    Object? absoluteSlot = freezed,
    Object? blockHeight = freezed,
    Object? epoch = freezed,
    Object? slotIndex = freezed,
    Object? slotsInEpoch = freezed,
  }) {
    return _then(_value.copyWith(
      absoluteSlot: absoluteSlot == freezed
          ? _value.absoluteSlot
          : absoluteSlot // ignore: cast_nullable_to_non_nullable
              as int,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int,
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as int,
      slotIndex: slotIndex == freezed
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
      slotsInEpoch: slotsInEpoch == freezed
          ? _value.slotsInEpoch
          : slotsInEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$EpochInfoCopyWith<$Res> implements $EpochInfoCopyWith<$Res> {
  factory _$EpochInfoCopyWith(
          _EpochInfo value, $Res Function(_EpochInfo) then) =
      __$EpochInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {int absoluteSlot,
      int blockHeight,
      int epoch,
      int slotIndex,
      int slotsInEpoch});
}

/// @nodoc
class __$EpochInfoCopyWithImpl<$Res> extends _$EpochInfoCopyWithImpl<$Res>
    implements _$EpochInfoCopyWith<$Res> {
  __$EpochInfoCopyWithImpl(_EpochInfo _value, $Res Function(_EpochInfo) _then)
      : super(_value, (v) => _then(v as _EpochInfo));

  @override
  _EpochInfo get _value => super._value as _EpochInfo;

  @override
  $Res call({
    Object? absoluteSlot = freezed,
    Object? blockHeight = freezed,
    Object? epoch = freezed,
    Object? slotIndex = freezed,
    Object? slotsInEpoch = freezed,
  }) {
    return _then(_EpochInfo(
      absoluteSlot: absoluteSlot == freezed
          ? _value.absoluteSlot
          : absoluteSlot // ignore: cast_nullable_to_non_nullable
              as int,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int,
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as int,
      slotIndex: slotIndex == freezed
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
      slotsInEpoch: slotsInEpoch == freezed
          ? _value.slotsInEpoch
          : slotsInEpoch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EpochInfo implements _EpochInfo {
  const _$_EpochInfo(
      {required this.absoluteSlot,
      required this.blockHeight,
      required this.epoch,
      required this.slotIndex,
      required this.slotsInEpoch});

  factory _$_EpochInfo.fromJson(Map<String, dynamic> json) =>
      _$$_EpochInfoFromJson(json);

  @override
  final int absoluteSlot;
  @override
  final int blockHeight;
  @override
  final int epoch;
  @override
  final int slotIndex;
  @override
  final int slotsInEpoch;

  @override
  String toString() {
    return 'EpochInfo(absoluteSlot: $absoluteSlot, blockHeight: $blockHeight, epoch: $epoch, slotIndex: $slotIndex, slotsInEpoch: $slotsInEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EpochInfo &&
            (identical(other.absoluteSlot, absoluteSlot) ||
                const DeepCollectionEquality()
                    .equals(other.absoluteSlot, absoluteSlot)) &&
            (identical(other.blockHeight, blockHeight) ||
                const DeepCollectionEquality()
                    .equals(other.blockHeight, blockHeight)) &&
            (identical(other.epoch, epoch) ||
                const DeepCollectionEquality().equals(other.epoch, epoch)) &&
            (identical(other.slotIndex, slotIndex) ||
                const DeepCollectionEquality()
                    .equals(other.slotIndex, slotIndex)) &&
            (identical(other.slotsInEpoch, slotsInEpoch) ||
                const DeepCollectionEquality()
                    .equals(other.slotsInEpoch, slotsInEpoch)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(absoluteSlot) ^
      const DeepCollectionEquality().hash(blockHeight) ^
      const DeepCollectionEquality().hash(epoch) ^
      const DeepCollectionEquality().hash(slotIndex) ^
      const DeepCollectionEquality().hash(slotsInEpoch);

  @JsonKey(ignore: true)
  @override
  _$EpochInfoCopyWith<_EpochInfo> get copyWith =>
      __$EpochInfoCopyWithImpl<_EpochInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EpochInfoToJson(this);
  }
}

abstract class _EpochInfo implements EpochInfo {
  const factory _EpochInfo(
      {required int absoluteSlot,
      required int blockHeight,
      required int epoch,
      required int slotIndex,
      required int slotsInEpoch}) = _$_EpochInfo;

  factory _EpochInfo.fromJson(Map<String, dynamic> json) =
      _$_EpochInfo.fromJson;

  @override
  int get absoluteSlot => throw _privateConstructorUsedError;
  @override
  int get blockHeight => throw _privateConstructorUsedError;
  @override
  int get epoch => throw _privateConstructorUsedError;
  @override
  int get slotIndex => throw _privateConstructorUsedError;
  @override
  int get slotsInEpoch => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EpochInfoCopyWith<_EpochInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

FeeCalculator _$FeeCalculatorFromJson(Map<String, dynamic> json) {
  return _FeeCalculator.fromJson(json);
}

/// @nodoc
class _$FeeCalculatorTearOff {
  const _$FeeCalculatorTearOff();

  _FeeCalculator call({required Map<String, dynamic> feeCalculator}) {
    return _FeeCalculator(
      feeCalculator: feeCalculator,
    );
  }

  FeeCalculator fromJson(Map<String, Object> json) {
    return FeeCalculator.fromJson(json);
  }
}

/// @nodoc
const $FeeCalculator = _$FeeCalculatorTearOff();

/// @nodoc
mixin _$FeeCalculator {
  Map<String, dynamic> get feeCalculator => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeeCalculatorCopyWith<FeeCalculator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeCalculatorCopyWith<$Res> {
  factory $FeeCalculatorCopyWith(
          FeeCalculator value, $Res Function(FeeCalculator) then) =
      _$FeeCalculatorCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> feeCalculator});
}

/// @nodoc
class _$FeeCalculatorCopyWithImpl<$Res>
    implements $FeeCalculatorCopyWith<$Res> {
  _$FeeCalculatorCopyWithImpl(this._value, this._then);

  final FeeCalculator _value;
  // ignore: unused_field
  final $Res Function(FeeCalculator) _then;

  @override
  $Res call({
    Object? feeCalculator = freezed,
  }) {
    return _then(_value.copyWith(
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$FeeCalculatorCopyWith<$Res>
    implements $FeeCalculatorCopyWith<$Res> {
  factory _$FeeCalculatorCopyWith(
          _FeeCalculator value, $Res Function(_FeeCalculator) then) =
      __$FeeCalculatorCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> feeCalculator});
}

/// @nodoc
class __$FeeCalculatorCopyWithImpl<$Res>
    extends _$FeeCalculatorCopyWithImpl<$Res>
    implements _$FeeCalculatorCopyWith<$Res> {
  __$FeeCalculatorCopyWithImpl(
      _FeeCalculator _value, $Res Function(_FeeCalculator) _then)
      : super(_value, (v) => _then(v as _FeeCalculator));

  @override
  _FeeCalculator get _value => super._value as _FeeCalculator;

  @override
  $Res call({
    Object? feeCalculator = freezed,
  }) {
    return _then(_FeeCalculator(
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeeCalculator implements _FeeCalculator {
  const _$_FeeCalculator({required this.feeCalculator});

  factory _$_FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$$_FeeCalculatorFromJson(json);

  @override
  final Map<String, dynamic> feeCalculator;

  @override
  String toString() {
    return 'FeeCalculator(feeCalculator: $feeCalculator)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FeeCalculator &&
            (identical(other.feeCalculator, feeCalculator) ||
                const DeepCollectionEquality()
                    .equals(other.feeCalculator, feeCalculator)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(feeCalculator);

  @JsonKey(ignore: true)
  @override
  _$FeeCalculatorCopyWith<_FeeCalculator> get copyWith =>
      __$FeeCalculatorCopyWithImpl<_FeeCalculator>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeeCalculatorToJson(this);
  }
}

abstract class _FeeCalculator implements FeeCalculator {
  const factory _FeeCalculator({required Map<String, dynamic> feeCalculator}) =
      _$_FeeCalculator;

  factory _FeeCalculator.fromJson(Map<String, dynamic> json) =
      _$_FeeCalculator.fromJson;

  @override
  Map<String, dynamic> get feeCalculator => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FeeCalculatorCopyWith<_FeeCalculator> get copyWith =>
      throw _privateConstructorUsedError;
}

BlockProduction _$BlockProductionFromJson(Map<String, dynamic> json) {
  return _BlockProduction.fromJson(json);
}

/// @nodoc
class _$BlockProductionTearOff {
  const _$BlockProductionTearOff();

  _BlockProduction call(
      {required Map<String, List<int>> byIdentity,
      required Map<String, dynamic> range}) {
    return _BlockProduction(
      byIdentity: byIdentity,
      range: range,
    );
  }

  BlockProduction fromJson(Map<String, Object> json) {
    return BlockProduction.fromJson(json);
  }
}

/// @nodoc
const $BlockProduction = _$BlockProductionTearOff();

/// @nodoc
mixin _$BlockProduction {
  Map<String, List<int>> get byIdentity => throw _privateConstructorUsedError;
  Map<String, dynamic> get range => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockProductionCopyWith<BlockProduction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockProductionCopyWith<$Res> {
  factory $BlockProductionCopyWith(
          BlockProduction value, $Res Function(BlockProduction) then) =
      _$BlockProductionCopyWithImpl<$Res>;
  $Res call({Map<String, List<int>> byIdentity, Map<String, dynamic> range});
}

/// @nodoc
class _$BlockProductionCopyWithImpl<$Res>
    implements $BlockProductionCopyWith<$Res> {
  _$BlockProductionCopyWithImpl(this._value, this._then);

  final BlockProduction _value;
  // ignore: unused_field
  final $Res Function(BlockProduction) _then;

  @override
  $Res call({
    Object? byIdentity = freezed,
    Object? range = freezed,
  }) {
    return _then(_value.copyWith(
      byIdentity: byIdentity == freezed
          ? _value.byIdentity
          : byIdentity // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      range: range == freezed
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$BlockProductionCopyWith<$Res>
    implements $BlockProductionCopyWith<$Res> {
  factory _$BlockProductionCopyWith(
          _BlockProduction value, $Res Function(_BlockProduction) then) =
      __$BlockProductionCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, List<int>> byIdentity, Map<String, dynamic> range});
}

/// @nodoc
class __$BlockProductionCopyWithImpl<$Res>
    extends _$BlockProductionCopyWithImpl<$Res>
    implements _$BlockProductionCopyWith<$Res> {
  __$BlockProductionCopyWithImpl(
      _BlockProduction _value, $Res Function(_BlockProduction) _then)
      : super(_value, (v) => _then(v as _BlockProduction));

  @override
  _BlockProduction get _value => super._value as _BlockProduction;

  @override
  $Res call({
    Object? byIdentity = freezed,
    Object? range = freezed,
  }) {
    return _then(_BlockProduction(
      byIdentity: byIdentity == freezed
          ? _value.byIdentity
          : byIdentity // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      range: range == freezed
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BlockProduction implements _BlockProduction {
  const _$_BlockProduction({required this.byIdentity, required this.range});

  factory _$_BlockProduction.fromJson(Map<String, dynamic> json) =>
      _$$_BlockProductionFromJson(json);

  @override
  final Map<String, List<int>> byIdentity;
  @override
  final Map<String, dynamic> range;

  @override
  String toString() {
    return 'BlockProduction(byIdentity: $byIdentity, range: $range)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlockProduction &&
            (identical(other.byIdentity, byIdentity) ||
                const DeepCollectionEquality()
                    .equals(other.byIdentity, byIdentity)) &&
            (identical(other.range, range) ||
                const DeepCollectionEquality().equals(other.range, range)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(byIdentity) ^
      const DeepCollectionEquality().hash(range);

  @JsonKey(ignore: true)
  @override
  _$BlockProductionCopyWith<_BlockProduction> get copyWith =>
      __$BlockProductionCopyWithImpl<_BlockProduction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlockProductionToJson(this);
  }
}

abstract class _BlockProduction implements BlockProduction {
  const factory _BlockProduction(
      {required Map<String, List<int>> byIdentity,
      required Map<String, dynamic> range}) = _$_BlockProduction;

  factory _BlockProduction.fromJson(Map<String, dynamic> json) =
      _$_BlockProduction.fromJson;

  @override
  Map<String, List<int>> get byIdentity => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic> get range => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlockProductionCopyWith<_BlockProduction> get copyWith =>
      throw _privateConstructorUsedError;
}

BlockCommitment _$BlockCommitmentFromJson(Map<String, dynamic> json) {
  return _BlockCommitment.fromJson(json);
}

/// @nodoc
class _$BlockCommitmentTearOff {
  const _$BlockCommitmentTearOff();

  _BlockCommitment call(
      {required List<int>? commitment, required int totalStake}) {
    return _BlockCommitment(
      commitment: commitment,
      totalStake: totalStake,
    );
  }

  BlockCommitment fromJson(Map<String, Object> json) {
    return BlockCommitment.fromJson(json);
  }
}

/// @nodoc
const $BlockCommitment = _$BlockCommitmentTearOff();

/// @nodoc
mixin _$BlockCommitment {
  List<int>? get commitment => throw _privateConstructorUsedError;
  int get totalStake => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockCommitmentCopyWith<BlockCommitment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockCommitmentCopyWith<$Res> {
  factory $BlockCommitmentCopyWith(
          BlockCommitment value, $Res Function(BlockCommitment) then) =
      _$BlockCommitmentCopyWithImpl<$Res>;
  $Res call({List<int>? commitment, int totalStake});
}

/// @nodoc
class _$BlockCommitmentCopyWithImpl<$Res>
    implements $BlockCommitmentCopyWith<$Res> {
  _$BlockCommitmentCopyWithImpl(this._value, this._then);

  final BlockCommitment _value;
  // ignore: unused_field
  final $Res Function(BlockCommitment) _then;

  @override
  $Res call({
    Object? commitment = freezed,
    Object? totalStake = freezed,
  }) {
    return _then(_value.copyWith(
      commitment: commitment == freezed
          ? _value.commitment
          : commitment // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      totalStake: totalStake == freezed
          ? _value.totalStake
          : totalStake // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$BlockCommitmentCopyWith<$Res>
    implements $BlockCommitmentCopyWith<$Res> {
  factory _$BlockCommitmentCopyWith(
          _BlockCommitment value, $Res Function(_BlockCommitment) then) =
      __$BlockCommitmentCopyWithImpl<$Res>;
  @override
  $Res call({List<int>? commitment, int totalStake});
}

/// @nodoc
class __$BlockCommitmentCopyWithImpl<$Res>
    extends _$BlockCommitmentCopyWithImpl<$Res>
    implements _$BlockCommitmentCopyWith<$Res> {
  __$BlockCommitmentCopyWithImpl(
      _BlockCommitment _value, $Res Function(_BlockCommitment) _then)
      : super(_value, (v) => _then(v as _BlockCommitment));

  @override
  _BlockCommitment get _value => super._value as _BlockCommitment;

  @override
  $Res call({
    Object? commitment = freezed,
    Object? totalStake = freezed,
  }) {
    return _then(_BlockCommitment(
      commitment: commitment == freezed
          ? _value.commitment
          : commitment // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      totalStake: totalStake == freezed
          ? _value.totalStake
          : totalStake // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BlockCommitment implements _BlockCommitment {
  const _$_BlockCommitment(
      {required this.commitment, required this.totalStake});

  factory _$_BlockCommitment.fromJson(Map<String, dynamic> json) =>
      _$$_BlockCommitmentFromJson(json);

  @override
  final List<int>? commitment;
  @override
  final int totalStake;

  @override
  String toString() {
    return 'BlockCommitment(commitment: $commitment, totalStake: $totalStake)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlockCommitment &&
            (identical(other.commitment, commitment) ||
                const DeepCollectionEquality()
                    .equals(other.commitment, commitment)) &&
            (identical(other.totalStake, totalStake) ||
                const DeepCollectionEquality()
                    .equals(other.totalStake, totalStake)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(commitment) ^
      const DeepCollectionEquality().hash(totalStake);

  @JsonKey(ignore: true)
  @override
  _$BlockCommitmentCopyWith<_BlockCommitment> get copyWith =>
      __$BlockCommitmentCopyWithImpl<_BlockCommitment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlockCommitmentToJson(this);
  }
}

abstract class _BlockCommitment implements BlockCommitment {
  const factory _BlockCommitment(
      {required List<int>? commitment,
      required int totalStake}) = _$_BlockCommitment;

  factory _BlockCommitment.fromJson(Map<String, dynamic> json) =
      _$_BlockCommitment.fromJson;

  @override
  List<int>? get commitment => throw _privateConstructorUsedError;
  @override
  int get totalStake => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlockCommitmentCopyWith<_BlockCommitment> get copyWith =>
      throw _privateConstructorUsedError;
}

EpochSchedule _$EpochScheduleFromJson(Map<String, dynamic> json) {
  return _EpochSchedule.fromJson(json);
}

/// @nodoc
class _$EpochScheduleTearOff {
  const _$EpochScheduleTearOff();

  _EpochSchedule call(
      {required int slotsPerEpoch,
      required int leaderScheduleSlotOffset,
      required bool warmup,
      required int firstNormalEpoch,
      required int firstNormalSlot}) {
    return _EpochSchedule(
      slotsPerEpoch: slotsPerEpoch,
      leaderScheduleSlotOffset: leaderScheduleSlotOffset,
      warmup: warmup,
      firstNormalEpoch: firstNormalEpoch,
      firstNormalSlot: firstNormalSlot,
    );
  }

  EpochSchedule fromJson(Map<String, Object> json) {
    return EpochSchedule.fromJson(json);
  }
}

/// @nodoc
const $EpochSchedule = _$EpochScheduleTearOff();

/// @nodoc
mixin _$EpochSchedule {
  int get slotsPerEpoch => throw _privateConstructorUsedError;
  int get leaderScheduleSlotOffset => throw _privateConstructorUsedError;
  bool get warmup => throw _privateConstructorUsedError;
  int get firstNormalEpoch => throw _privateConstructorUsedError;
  int get firstNormalSlot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EpochScheduleCopyWith<EpochSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpochScheduleCopyWith<$Res> {
  factory $EpochScheduleCopyWith(
          EpochSchedule value, $Res Function(EpochSchedule) then) =
      _$EpochScheduleCopyWithImpl<$Res>;
  $Res call(
      {int slotsPerEpoch,
      int leaderScheduleSlotOffset,
      bool warmup,
      int firstNormalEpoch,
      int firstNormalSlot});
}

/// @nodoc
class _$EpochScheduleCopyWithImpl<$Res>
    implements $EpochScheduleCopyWith<$Res> {
  _$EpochScheduleCopyWithImpl(this._value, this._then);

  final EpochSchedule _value;
  // ignore: unused_field
  final $Res Function(EpochSchedule) _then;

  @override
  $Res call({
    Object? slotsPerEpoch = freezed,
    Object? leaderScheduleSlotOffset = freezed,
    Object? warmup = freezed,
    Object? firstNormalEpoch = freezed,
    Object? firstNormalSlot = freezed,
  }) {
    return _then(_value.copyWith(
      slotsPerEpoch: slotsPerEpoch == freezed
          ? _value.slotsPerEpoch
          : slotsPerEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      leaderScheduleSlotOffset: leaderScheduleSlotOffset == freezed
          ? _value.leaderScheduleSlotOffset
          : leaderScheduleSlotOffset // ignore: cast_nullable_to_non_nullable
              as int,
      warmup: warmup == freezed
          ? _value.warmup
          : warmup // ignore: cast_nullable_to_non_nullable
              as bool,
      firstNormalEpoch: firstNormalEpoch == freezed
          ? _value.firstNormalEpoch
          : firstNormalEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      firstNormalSlot: firstNormalSlot == freezed
          ? _value.firstNormalSlot
          : firstNormalSlot // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$EpochScheduleCopyWith<$Res>
    implements $EpochScheduleCopyWith<$Res> {
  factory _$EpochScheduleCopyWith(
          _EpochSchedule value, $Res Function(_EpochSchedule) then) =
      __$EpochScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {int slotsPerEpoch,
      int leaderScheduleSlotOffset,
      bool warmup,
      int firstNormalEpoch,
      int firstNormalSlot});
}

/// @nodoc
class __$EpochScheduleCopyWithImpl<$Res>
    extends _$EpochScheduleCopyWithImpl<$Res>
    implements _$EpochScheduleCopyWith<$Res> {
  __$EpochScheduleCopyWithImpl(
      _EpochSchedule _value, $Res Function(_EpochSchedule) _then)
      : super(_value, (v) => _then(v as _EpochSchedule));

  @override
  _EpochSchedule get _value => super._value as _EpochSchedule;

  @override
  $Res call({
    Object? slotsPerEpoch = freezed,
    Object? leaderScheduleSlotOffset = freezed,
    Object? warmup = freezed,
    Object? firstNormalEpoch = freezed,
    Object? firstNormalSlot = freezed,
  }) {
    return _then(_EpochSchedule(
      slotsPerEpoch: slotsPerEpoch == freezed
          ? _value.slotsPerEpoch
          : slotsPerEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      leaderScheduleSlotOffset: leaderScheduleSlotOffset == freezed
          ? _value.leaderScheduleSlotOffset
          : leaderScheduleSlotOffset // ignore: cast_nullable_to_non_nullable
              as int,
      warmup: warmup == freezed
          ? _value.warmup
          : warmup // ignore: cast_nullable_to_non_nullable
              as bool,
      firstNormalEpoch: firstNormalEpoch == freezed
          ? _value.firstNormalEpoch
          : firstNormalEpoch // ignore: cast_nullable_to_non_nullable
              as int,
      firstNormalSlot: firstNormalSlot == freezed
          ? _value.firstNormalSlot
          : firstNormalSlot // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EpochSchedule implements _EpochSchedule {
  const _$_EpochSchedule(
      {required this.slotsPerEpoch,
      required this.leaderScheduleSlotOffset,
      required this.warmup,
      required this.firstNormalEpoch,
      required this.firstNormalSlot});

  factory _$_EpochSchedule.fromJson(Map<String, dynamic> json) =>
      _$$_EpochScheduleFromJson(json);

  @override
  final int slotsPerEpoch;
  @override
  final int leaderScheduleSlotOffset;
  @override
  final bool warmup;
  @override
  final int firstNormalEpoch;
  @override
  final int firstNormalSlot;

  @override
  String toString() {
    return 'EpochSchedule(slotsPerEpoch: $slotsPerEpoch, leaderScheduleSlotOffset: $leaderScheduleSlotOffset, warmup: $warmup, firstNormalEpoch: $firstNormalEpoch, firstNormalSlot: $firstNormalSlot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EpochSchedule &&
            (identical(other.slotsPerEpoch, slotsPerEpoch) ||
                const DeepCollectionEquality()
                    .equals(other.slotsPerEpoch, slotsPerEpoch)) &&
            (identical(
                    other.leaderScheduleSlotOffset, leaderScheduleSlotOffset) ||
                const DeepCollectionEquality().equals(
                    other.leaderScheduleSlotOffset,
                    leaderScheduleSlotOffset)) &&
            (identical(other.warmup, warmup) ||
                const DeepCollectionEquality().equals(other.warmup, warmup)) &&
            (identical(other.firstNormalEpoch, firstNormalEpoch) ||
                const DeepCollectionEquality()
                    .equals(other.firstNormalEpoch, firstNormalEpoch)) &&
            (identical(other.firstNormalSlot, firstNormalSlot) ||
                const DeepCollectionEquality()
                    .equals(other.firstNormalSlot, firstNormalSlot)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(slotsPerEpoch) ^
      const DeepCollectionEquality().hash(leaderScheduleSlotOffset) ^
      const DeepCollectionEquality().hash(warmup) ^
      const DeepCollectionEquality().hash(firstNormalEpoch) ^
      const DeepCollectionEquality().hash(firstNormalSlot);

  @JsonKey(ignore: true)
  @override
  _$EpochScheduleCopyWith<_EpochSchedule> get copyWith =>
      __$EpochScheduleCopyWithImpl<_EpochSchedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EpochScheduleToJson(this);
  }
}

abstract class _EpochSchedule implements EpochSchedule {
  const factory _EpochSchedule(
      {required int slotsPerEpoch,
      required int leaderScheduleSlotOffset,
      required bool warmup,
      required int firstNormalEpoch,
      required int firstNormalSlot}) = _$_EpochSchedule;

  factory _EpochSchedule.fromJson(Map<String, dynamic> json) =
      _$_EpochSchedule.fromJson;

  @override
  int get slotsPerEpoch => throw _privateConstructorUsedError;
  @override
  int get leaderScheduleSlotOffset => throw _privateConstructorUsedError;
  @override
  bool get warmup => throw _privateConstructorUsedError;
  @override
  int get firstNormalEpoch => throw _privateConstructorUsedError;
  @override
  int get firstNormalSlot => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EpochScheduleCopyWith<_EpochSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

FeeRateGovernor _$FeeRateGovernorFromJson(Map<String, dynamic> json) {
  return _FeeRateGovernor.fromJson(json);
}

/// @nodoc
class _$FeeRateGovernorTearOff {
  const _$FeeRateGovernorTearOff();

  _FeeRateGovernor call({required Map<String, dynamic> feeRateGovernor}) {
    return _FeeRateGovernor(
      feeRateGovernor: feeRateGovernor,
    );
  }

  FeeRateGovernor fromJson(Map<String, Object> json) {
    return FeeRateGovernor.fromJson(json);
  }
}

/// @nodoc
const $FeeRateGovernor = _$FeeRateGovernorTearOff();

/// @nodoc
mixin _$FeeRateGovernor {
  Map<String, dynamic> get feeRateGovernor =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeeRateGovernorCopyWith<FeeRateGovernor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeRateGovernorCopyWith<$Res> {
  factory $FeeRateGovernorCopyWith(
          FeeRateGovernor value, $Res Function(FeeRateGovernor) then) =
      _$FeeRateGovernorCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> feeRateGovernor});
}

/// @nodoc
class _$FeeRateGovernorCopyWithImpl<$Res>
    implements $FeeRateGovernorCopyWith<$Res> {
  _$FeeRateGovernorCopyWithImpl(this._value, this._then);

  final FeeRateGovernor _value;
  // ignore: unused_field
  final $Res Function(FeeRateGovernor) _then;

  @override
  $Res call({
    Object? feeRateGovernor = freezed,
  }) {
    return _then(_value.copyWith(
      feeRateGovernor: feeRateGovernor == freezed
          ? _value.feeRateGovernor
          : feeRateGovernor // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$FeeRateGovernorCopyWith<$Res>
    implements $FeeRateGovernorCopyWith<$Res> {
  factory _$FeeRateGovernorCopyWith(
          _FeeRateGovernor value, $Res Function(_FeeRateGovernor) then) =
      __$FeeRateGovernorCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> feeRateGovernor});
}

/// @nodoc
class __$FeeRateGovernorCopyWithImpl<$Res>
    extends _$FeeRateGovernorCopyWithImpl<$Res>
    implements _$FeeRateGovernorCopyWith<$Res> {
  __$FeeRateGovernorCopyWithImpl(
      _FeeRateGovernor _value, $Res Function(_FeeRateGovernor) _then)
      : super(_value, (v) => _then(v as _FeeRateGovernor));

  @override
  _FeeRateGovernor get _value => super._value as _FeeRateGovernor;

  @override
  $Res call({
    Object? feeRateGovernor = freezed,
  }) {
    return _then(_FeeRateGovernor(
      feeRateGovernor: feeRateGovernor == freezed
          ? _value.feeRateGovernor
          : feeRateGovernor // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeeRateGovernor implements _FeeRateGovernor {
  const _$_FeeRateGovernor({required this.feeRateGovernor});

  factory _$_FeeRateGovernor.fromJson(Map<String, dynamic> json) =>
      _$$_FeeRateGovernorFromJson(json);

  @override
  final Map<String, dynamic> feeRateGovernor;

  @override
  String toString() {
    return 'FeeRateGovernor(feeRateGovernor: $feeRateGovernor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FeeRateGovernor &&
            (identical(other.feeRateGovernor, feeRateGovernor) ||
                const DeepCollectionEquality()
                    .equals(other.feeRateGovernor, feeRateGovernor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(feeRateGovernor);

  @JsonKey(ignore: true)
  @override
  _$FeeRateGovernorCopyWith<_FeeRateGovernor> get copyWith =>
      __$FeeRateGovernorCopyWithImpl<_FeeRateGovernor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeeRateGovernorToJson(this);
  }
}

abstract class _FeeRateGovernor implements FeeRateGovernor {
  const factory _FeeRateGovernor(
      {required Map<String, dynamic> feeRateGovernor}) = _$_FeeRateGovernor;

  factory _FeeRateGovernor.fromJson(Map<String, dynamic> json) =
      _$_FeeRateGovernor.fromJson;

  @override
  Map<String, dynamic> get feeRateGovernor =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FeeRateGovernorCopyWith<_FeeRateGovernor> get copyWith =>
      throw _privateConstructorUsedError;
}

Fees _$FeesFromJson(Map<String, dynamic> json) {
  return _Fees.fromJson(json);
}

/// @nodoc
class _$FeesTearOff {
  const _$FeesTearOff();

  _Fees call(
      {required String blockhash,
      required FeeCalculator feeCalculator,
      required int lastValidBlockHeight}) {
    return _Fees(
      blockhash: blockhash,
      feeCalculator: feeCalculator,
      lastValidBlockHeight: lastValidBlockHeight,
    );
  }

  Fees fromJson(Map<String, Object> json) {
    return Fees.fromJson(json);
  }
}

/// @nodoc
const $Fees = _$FeesTearOff();

/// @nodoc
mixin _$Fees {
  String get blockhash => throw _privateConstructorUsedError;
  FeeCalculator get feeCalculator => throw _privateConstructorUsedError;
  int get lastValidBlockHeight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeesCopyWith<Fees> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeesCopyWith<$Res> {
  factory $FeesCopyWith(Fees value, $Res Function(Fees) then) =
      _$FeesCopyWithImpl<$Res>;
  $Res call(
      {String blockhash,
      FeeCalculator feeCalculator,
      int lastValidBlockHeight});

  $FeeCalculatorCopyWith<$Res> get feeCalculator;
}

/// @nodoc
class _$FeesCopyWithImpl<$Res> implements $FeesCopyWith<$Res> {
  _$FeesCopyWithImpl(this._value, this._then);

  final Fees _value;
  // ignore: unused_field
  final $Res Function(Fees) _then;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? feeCalculator = freezed,
    Object? lastValidBlockHeight = freezed,
  }) {
    return _then(_value.copyWith(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as FeeCalculator,
      lastValidBlockHeight: lastValidBlockHeight == freezed
          ? _value.lastValidBlockHeight
          : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $FeeCalculatorCopyWith<$Res> get feeCalculator {
    return $FeeCalculatorCopyWith<$Res>(_value.feeCalculator, (value) {
      return _then(_value.copyWith(feeCalculator: value));
    });
  }
}

/// @nodoc
abstract class _$FeesCopyWith<$Res> implements $FeesCopyWith<$Res> {
  factory _$FeesCopyWith(_Fees value, $Res Function(_Fees) then) =
      __$FeesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String blockhash,
      FeeCalculator feeCalculator,
      int lastValidBlockHeight});

  @override
  $FeeCalculatorCopyWith<$Res> get feeCalculator;
}

/// @nodoc
class __$FeesCopyWithImpl<$Res> extends _$FeesCopyWithImpl<$Res>
    implements _$FeesCopyWith<$Res> {
  __$FeesCopyWithImpl(_Fees _value, $Res Function(_Fees) _then)
      : super(_value, (v) => _then(v as _Fees));

  @override
  _Fees get _value => super._value as _Fees;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? feeCalculator = freezed,
    Object? lastValidBlockHeight = freezed,
  }) {
    return _then(_Fees(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as FeeCalculator,
      lastValidBlockHeight: lastValidBlockHeight == freezed
          ? _value.lastValidBlockHeight
          : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fees implements _Fees {
  const _$_Fees(
      {required this.blockhash,
      required this.feeCalculator,
      required this.lastValidBlockHeight});

  factory _$_Fees.fromJson(Map<String, dynamic> json) => _$$_FeesFromJson(json);

  @override
  final String blockhash;
  @override
  final FeeCalculator feeCalculator;
  @override
  final int lastValidBlockHeight;

  @override
  String toString() {
    return 'Fees(blockhash: $blockhash, feeCalculator: $feeCalculator, lastValidBlockHeight: $lastValidBlockHeight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Fees &&
            (identical(other.blockhash, blockhash) ||
                const DeepCollectionEquality()
                    .equals(other.blockhash, blockhash)) &&
            (identical(other.feeCalculator, feeCalculator) ||
                const DeepCollectionEquality()
                    .equals(other.feeCalculator, feeCalculator)) &&
            (identical(other.lastValidBlockHeight, lastValidBlockHeight) ||
                const DeepCollectionEquality()
                    .equals(other.lastValidBlockHeight, lastValidBlockHeight)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(blockhash) ^
      const DeepCollectionEquality().hash(feeCalculator) ^
      const DeepCollectionEquality().hash(lastValidBlockHeight);

  @JsonKey(ignore: true)
  @override
  _$FeesCopyWith<_Fees> get copyWith =>
      __$FeesCopyWithImpl<_Fees>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeesToJson(this);
  }
}

abstract class _Fees implements Fees {
  const factory _Fees(
      {required String blockhash,
      required FeeCalculator feeCalculator,
      required int lastValidBlockHeight}) = _$_Fees;

  factory _Fees.fromJson(Map<String, dynamic> json) = _$_Fees.fromJson;

  @override
  String get blockhash => throw _privateConstructorUsedError;
  @override
  FeeCalculator get feeCalculator => throw _privateConstructorUsedError;
  @override
  int get lastValidBlockHeight => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FeesCopyWith<_Fees> get copyWith => throw _privateConstructorUsedError;
}

Identity _$IdentityFromJson(Map<String, dynamic> json) {
  return _Identity.fromJson(json);
}

/// @nodoc
class _$IdentityTearOff {
  const _$IdentityTearOff();

  _Identity call({required String identity}) {
    return _Identity(
      identity: identity,
    );
  }

  Identity fromJson(Map<String, Object> json) {
    return Identity.fromJson(json);
  }
}

/// @nodoc
const $Identity = _$IdentityTearOff();

/// @nodoc
mixin _$Identity {
  String get identity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IdentityCopyWith<Identity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentityCopyWith<$Res> {
  factory $IdentityCopyWith(Identity value, $Res Function(Identity) then) =
      _$IdentityCopyWithImpl<$Res>;
  $Res call({String identity});
}

/// @nodoc
class _$IdentityCopyWithImpl<$Res> implements $IdentityCopyWith<$Res> {
  _$IdentityCopyWithImpl(this._value, this._then);

  final Identity _value;
  // ignore: unused_field
  final $Res Function(Identity) _then;

  @override
  $Res call({
    Object? identity = freezed,
  }) {
    return _then(_value.copyWith(
      identity: identity == freezed
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$IdentityCopyWith<$Res> implements $IdentityCopyWith<$Res> {
  factory _$IdentityCopyWith(_Identity value, $Res Function(_Identity) then) =
      __$IdentityCopyWithImpl<$Res>;
  @override
  $Res call({String identity});
}

/// @nodoc
class __$IdentityCopyWithImpl<$Res> extends _$IdentityCopyWithImpl<$Res>
    implements _$IdentityCopyWith<$Res> {
  __$IdentityCopyWithImpl(_Identity _value, $Res Function(_Identity) _then)
      : super(_value, (v) => _then(v as _Identity));

  @override
  _Identity get _value => super._value as _Identity;

  @override
  $Res call({
    Object? identity = freezed,
  }) {
    return _then(_Identity(
      identity: identity == freezed
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Identity implements _Identity {
  const _$_Identity({required this.identity});

  factory _$_Identity.fromJson(Map<String, dynamic> json) =>
      _$$_IdentityFromJson(json);

  @override
  final String identity;

  @override
  String toString() {
    return 'Identity(identity: $identity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Identity &&
            (identical(other.identity, identity) ||
                const DeepCollectionEquality()
                    .equals(other.identity, identity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(identity);

  @JsonKey(ignore: true)
  @override
  _$IdentityCopyWith<_Identity> get copyWith =>
      __$IdentityCopyWithImpl<_Identity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IdentityToJson(this);
  }
}

abstract class _Identity implements Identity {
  const factory _Identity({required String identity}) = _$_Identity;

  factory _Identity.fromJson(Map<String, dynamic> json) = _$_Identity.fromJson;

  @override
  String get identity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IdentityCopyWith<_Identity> get copyWith =>
      throw _privateConstructorUsedError;
}

InflationGovernor _$InflationGovernorFromJson(Map<String, dynamic> json) {
  return _InflationGovernor.fromJson(json);
}

/// @nodoc
class _$InflationGovernorTearOff {
  const _$InflationGovernorTearOff();

  _InflationGovernor call(
      {required double initial,
      required double terminal,
      required double taper,
      required double foundation,
      required double foundationTerm}) {
    return _InflationGovernor(
      initial: initial,
      terminal: terminal,
      taper: taper,
      foundation: foundation,
      foundationTerm: foundationTerm,
    );
  }

  InflationGovernor fromJson(Map<String, Object> json) {
    return InflationGovernor.fromJson(json);
  }
}

/// @nodoc
const $InflationGovernor = _$InflationGovernorTearOff();

/// @nodoc
mixin _$InflationGovernor {
  double get initial => throw _privateConstructorUsedError;
  double get terminal => throw _privateConstructorUsedError;
  double get taper => throw _privateConstructorUsedError;
  double get foundation => throw _privateConstructorUsedError;
  double get foundationTerm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InflationGovernorCopyWith<InflationGovernor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InflationGovernorCopyWith<$Res> {
  factory $InflationGovernorCopyWith(
          InflationGovernor value, $Res Function(InflationGovernor) then) =
      _$InflationGovernorCopyWithImpl<$Res>;
  $Res call(
      {double initial,
      double terminal,
      double taper,
      double foundation,
      double foundationTerm});
}

/// @nodoc
class _$InflationGovernorCopyWithImpl<$Res>
    implements $InflationGovernorCopyWith<$Res> {
  _$InflationGovernorCopyWithImpl(this._value, this._then);

  final InflationGovernor _value;
  // ignore: unused_field
  final $Res Function(InflationGovernor) _then;

  @override
  $Res call({
    Object? initial = freezed,
    Object? terminal = freezed,
    Object? taper = freezed,
    Object? foundation = freezed,
    Object? foundationTerm = freezed,
  }) {
    return _then(_value.copyWith(
      initial: initial == freezed
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as double,
      terminal: terminal == freezed
          ? _value.terminal
          : terminal // ignore: cast_nullable_to_non_nullable
              as double,
      taper: taper == freezed
          ? _value.taper
          : taper // ignore: cast_nullable_to_non_nullable
              as double,
      foundation: foundation == freezed
          ? _value.foundation
          : foundation // ignore: cast_nullable_to_non_nullable
              as double,
      foundationTerm: foundationTerm == freezed
          ? _value.foundationTerm
          : foundationTerm // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$InflationGovernorCopyWith<$Res>
    implements $InflationGovernorCopyWith<$Res> {
  factory _$InflationGovernorCopyWith(
          _InflationGovernor value, $Res Function(_InflationGovernor) then) =
      __$InflationGovernorCopyWithImpl<$Res>;
  @override
  $Res call(
      {double initial,
      double terminal,
      double taper,
      double foundation,
      double foundationTerm});
}

/// @nodoc
class __$InflationGovernorCopyWithImpl<$Res>
    extends _$InflationGovernorCopyWithImpl<$Res>
    implements _$InflationGovernorCopyWith<$Res> {
  __$InflationGovernorCopyWithImpl(
      _InflationGovernor _value, $Res Function(_InflationGovernor) _then)
      : super(_value, (v) => _then(v as _InflationGovernor));

  @override
  _InflationGovernor get _value => super._value as _InflationGovernor;

  @override
  $Res call({
    Object? initial = freezed,
    Object? terminal = freezed,
    Object? taper = freezed,
    Object? foundation = freezed,
    Object? foundationTerm = freezed,
  }) {
    return _then(_InflationGovernor(
      initial: initial == freezed
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as double,
      terminal: terminal == freezed
          ? _value.terminal
          : terminal // ignore: cast_nullable_to_non_nullable
              as double,
      taper: taper == freezed
          ? _value.taper
          : taper // ignore: cast_nullable_to_non_nullable
              as double,
      foundation: foundation == freezed
          ? _value.foundation
          : foundation // ignore: cast_nullable_to_non_nullable
              as double,
      foundationTerm: foundationTerm == freezed
          ? _value.foundationTerm
          : foundationTerm // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InflationGovernor implements _InflationGovernor {
  const _$_InflationGovernor(
      {required this.initial,
      required this.terminal,
      required this.taper,
      required this.foundation,
      required this.foundationTerm});

  factory _$_InflationGovernor.fromJson(Map<String, dynamic> json) =>
      _$$_InflationGovernorFromJson(json);

  @override
  final double initial;
  @override
  final double terminal;
  @override
  final double taper;
  @override
  final double foundation;
  @override
  final double foundationTerm;

  @override
  String toString() {
    return 'InflationGovernor(initial: $initial, terminal: $terminal, taper: $taper, foundation: $foundation, foundationTerm: $foundationTerm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InflationGovernor &&
            (identical(other.initial, initial) ||
                const DeepCollectionEquality()
                    .equals(other.initial, initial)) &&
            (identical(other.terminal, terminal) ||
                const DeepCollectionEquality()
                    .equals(other.terminal, terminal)) &&
            (identical(other.taper, taper) ||
                const DeepCollectionEquality().equals(other.taper, taper)) &&
            (identical(other.foundation, foundation) ||
                const DeepCollectionEquality()
                    .equals(other.foundation, foundation)) &&
            (identical(other.foundationTerm, foundationTerm) ||
                const DeepCollectionEquality()
                    .equals(other.foundationTerm, foundationTerm)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(initial) ^
      const DeepCollectionEquality().hash(terminal) ^
      const DeepCollectionEquality().hash(taper) ^
      const DeepCollectionEquality().hash(foundation) ^
      const DeepCollectionEquality().hash(foundationTerm);

  @JsonKey(ignore: true)
  @override
  _$InflationGovernorCopyWith<_InflationGovernor> get copyWith =>
      __$InflationGovernorCopyWithImpl<_InflationGovernor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InflationGovernorToJson(this);
  }
}

abstract class _InflationGovernor implements InflationGovernor {
  const factory _InflationGovernor(
      {required double initial,
      required double terminal,
      required double taper,
      required double foundation,
      required double foundationTerm}) = _$_InflationGovernor;

  factory _InflationGovernor.fromJson(Map<String, dynamic> json) =
      _$_InflationGovernor.fromJson;

  @override
  double get initial => throw _privateConstructorUsedError;
  @override
  double get terminal => throw _privateConstructorUsedError;
  @override
  double get taper => throw _privateConstructorUsedError;
  @override
  double get foundation => throw _privateConstructorUsedError;
  @override
  double get foundationTerm => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InflationGovernorCopyWith<_InflationGovernor> get copyWith =>
      throw _privateConstructorUsedError;
}

InflationRate _$InflationRateFromJson(Map<String, dynamic> json) {
  return _InflationRate.fromJson(json);
}

/// @nodoc
class _$InflationRateTearOff {
  const _$InflationRateTearOff();

  _InflationRate call(
      {required double total,
      required double validator,
      required double foundation,
      required double epoch}) {
    return _InflationRate(
      total: total,
      validator: validator,
      foundation: foundation,
      epoch: epoch,
    );
  }

  InflationRate fromJson(Map<String, Object> json) {
    return InflationRate.fromJson(json);
  }
}

/// @nodoc
const $InflationRate = _$InflationRateTearOff();

/// @nodoc
mixin _$InflationRate {
  double get total => throw _privateConstructorUsedError;
  double get validator => throw _privateConstructorUsedError;
  double get foundation => throw _privateConstructorUsedError;
  double get epoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InflationRateCopyWith<InflationRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InflationRateCopyWith<$Res> {
  factory $InflationRateCopyWith(
          InflationRate value, $Res Function(InflationRate) then) =
      _$InflationRateCopyWithImpl<$Res>;
  $Res call({double total, double validator, double foundation, double epoch});
}

/// @nodoc
class _$InflationRateCopyWithImpl<$Res>
    implements $InflationRateCopyWith<$Res> {
  _$InflationRateCopyWithImpl(this._value, this._then);

  final InflationRate _value;
  // ignore: unused_field
  final $Res Function(InflationRate) _then;

  @override
  $Res call({
    Object? total = freezed,
    Object? validator = freezed,
    Object? foundation = freezed,
    Object? epoch = freezed,
  }) {
    return _then(_value.copyWith(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      validator: validator == freezed
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as double,
      foundation: foundation == freezed
          ? _value.foundation
          : foundation // ignore: cast_nullable_to_non_nullable
              as double,
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$InflationRateCopyWith<$Res>
    implements $InflationRateCopyWith<$Res> {
  factory _$InflationRateCopyWith(
          _InflationRate value, $Res Function(_InflationRate) then) =
      __$InflationRateCopyWithImpl<$Res>;
  @override
  $Res call({double total, double validator, double foundation, double epoch});
}

/// @nodoc
class __$InflationRateCopyWithImpl<$Res>
    extends _$InflationRateCopyWithImpl<$Res>
    implements _$InflationRateCopyWith<$Res> {
  __$InflationRateCopyWithImpl(
      _InflationRate _value, $Res Function(_InflationRate) _then)
      : super(_value, (v) => _then(v as _InflationRate));

  @override
  _InflationRate get _value => super._value as _InflationRate;

  @override
  $Res call({
    Object? total = freezed,
    Object? validator = freezed,
    Object? foundation = freezed,
    Object? epoch = freezed,
  }) {
    return _then(_InflationRate(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      validator: validator == freezed
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as double,
      foundation: foundation == freezed
          ? _value.foundation
          : foundation // ignore: cast_nullable_to_non_nullable
              as double,
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InflationRate implements _InflationRate {
  const _$_InflationRate(
      {required this.total,
      required this.validator,
      required this.foundation,
      required this.epoch});

  factory _$_InflationRate.fromJson(Map<String, dynamic> json) =>
      _$$_InflationRateFromJson(json);

  @override
  final double total;
  @override
  final double validator;
  @override
  final double foundation;
  @override
  final double epoch;

  @override
  String toString() {
    return 'InflationRate(total: $total, validator: $validator, foundation: $foundation, epoch: $epoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InflationRate &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.validator, validator) ||
                const DeepCollectionEquality()
                    .equals(other.validator, validator)) &&
            (identical(other.foundation, foundation) ||
                const DeepCollectionEquality()
                    .equals(other.foundation, foundation)) &&
            (identical(other.epoch, epoch) ||
                const DeepCollectionEquality().equals(other.epoch, epoch)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(validator) ^
      const DeepCollectionEquality().hash(foundation) ^
      const DeepCollectionEquality().hash(epoch);

  @JsonKey(ignore: true)
  @override
  _$InflationRateCopyWith<_InflationRate> get copyWith =>
      __$InflationRateCopyWithImpl<_InflationRate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InflationRateToJson(this);
  }
}

abstract class _InflationRate implements InflationRate {
  const factory _InflationRate(
      {required double total,
      required double validator,
      required double foundation,
      required double epoch}) = _$_InflationRate;

  factory _InflationRate.fromJson(Map<String, dynamic> json) =
      _$_InflationRate.fromJson;

  @override
  double get total => throw _privateConstructorUsedError;
  @override
  double get validator => throw _privateConstructorUsedError;
  @override
  double get foundation => throw _privateConstructorUsedError;
  @override
  double get epoch => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InflationRateCopyWith<_InflationRate> get copyWith =>
      throw _privateConstructorUsedError;
}

InflationReward _$InflationRewardFromJson(Map<String, dynamic> json) {
  return _InflationReward.fromJson(json);
}

/// @nodoc
class _$InflationRewardTearOff {
  const _$InflationRewardTearOff();

  _InflationReward call(
      {required int epoch,
      required int effectiveSlot,
      required int amount,
      required int postBalance,
      required int commission}) {
    return _InflationReward(
      epoch: epoch,
      effectiveSlot: effectiveSlot,
      amount: amount,
      postBalance: postBalance,
      commission: commission,
    );
  }

  InflationReward fromJson(Map<String, Object> json) {
    return InflationReward.fromJson(json);
  }
}

/// @nodoc
const $InflationReward = _$InflationRewardTearOff();

/// @nodoc
mixin _$InflationReward {
  int get epoch => throw _privateConstructorUsedError;
  int get effectiveSlot => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get postBalance => throw _privateConstructorUsedError;
  int get commission => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InflationRewardCopyWith<InflationReward> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InflationRewardCopyWith<$Res> {
  factory $InflationRewardCopyWith(
          InflationReward value, $Res Function(InflationReward) then) =
      _$InflationRewardCopyWithImpl<$Res>;
  $Res call(
      {int epoch,
      int effectiveSlot,
      int amount,
      int postBalance,
      int commission});
}

/// @nodoc
class _$InflationRewardCopyWithImpl<$Res>
    implements $InflationRewardCopyWith<$Res> {
  _$InflationRewardCopyWithImpl(this._value, this._then);

  final InflationReward _value;
  // ignore: unused_field
  final $Res Function(InflationReward) _then;

  @override
  $Res call({
    Object? epoch = freezed,
    Object? effectiveSlot = freezed,
    Object? amount = freezed,
    Object? postBalance = freezed,
    Object? commission = freezed,
  }) {
    return _then(_value.copyWith(
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as int,
      effectiveSlot: effectiveSlot == freezed
          ? _value.effectiveSlot
          : effectiveSlot // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      postBalance: postBalance == freezed
          ? _value.postBalance
          : postBalance // ignore: cast_nullable_to_non_nullable
              as int,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$InflationRewardCopyWith<$Res>
    implements $InflationRewardCopyWith<$Res> {
  factory _$InflationRewardCopyWith(
          _InflationReward value, $Res Function(_InflationReward) then) =
      __$InflationRewardCopyWithImpl<$Res>;
  @override
  $Res call(
      {int epoch,
      int effectiveSlot,
      int amount,
      int postBalance,
      int commission});
}

/// @nodoc
class __$InflationRewardCopyWithImpl<$Res>
    extends _$InflationRewardCopyWithImpl<$Res>
    implements _$InflationRewardCopyWith<$Res> {
  __$InflationRewardCopyWithImpl(
      _InflationReward _value, $Res Function(_InflationReward) _then)
      : super(_value, (v) => _then(v as _InflationReward));

  @override
  _InflationReward get _value => super._value as _InflationReward;

  @override
  $Res call({
    Object? epoch = freezed,
    Object? effectiveSlot = freezed,
    Object? amount = freezed,
    Object? postBalance = freezed,
    Object? commission = freezed,
  }) {
    return _then(_InflationReward(
      epoch: epoch == freezed
          ? _value.epoch
          : epoch // ignore: cast_nullable_to_non_nullable
              as int,
      effectiveSlot: effectiveSlot == freezed
          ? _value.effectiveSlot
          : effectiveSlot // ignore: cast_nullable_to_non_nullable
              as int,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      postBalance: postBalance == freezed
          ? _value.postBalance
          : postBalance // ignore: cast_nullable_to_non_nullable
              as int,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InflationReward implements _InflationReward {
  const _$_InflationReward(
      {required this.epoch,
      required this.effectiveSlot,
      required this.amount,
      required this.postBalance,
      required this.commission});

  factory _$_InflationReward.fromJson(Map<String, dynamic> json) =>
      _$$_InflationRewardFromJson(json);

  @override
  final int epoch;
  @override
  final int effectiveSlot;
  @override
  final int amount;
  @override
  final int postBalance;
  @override
  final int commission;

  @override
  String toString() {
    return 'InflationReward(epoch: $epoch, effectiveSlot: $effectiveSlot, amount: $amount, postBalance: $postBalance, commission: $commission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InflationReward &&
            (identical(other.epoch, epoch) ||
                const DeepCollectionEquality().equals(other.epoch, epoch)) &&
            (identical(other.effectiveSlot, effectiveSlot) ||
                const DeepCollectionEquality()
                    .equals(other.effectiveSlot, effectiveSlot)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.postBalance, postBalance) ||
                const DeepCollectionEquality()
                    .equals(other.postBalance, postBalance)) &&
            (identical(other.commission, commission) ||
                const DeepCollectionEquality()
                    .equals(other.commission, commission)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(epoch) ^
      const DeepCollectionEquality().hash(effectiveSlot) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(postBalance) ^
      const DeepCollectionEquality().hash(commission);

  @JsonKey(ignore: true)
  @override
  _$InflationRewardCopyWith<_InflationReward> get copyWith =>
      __$InflationRewardCopyWithImpl<_InflationReward>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InflationRewardToJson(this);
  }
}

abstract class _InflationReward implements InflationReward {
  const factory _InflationReward(
      {required int epoch,
      required int effectiveSlot,
      required int amount,
      required int postBalance,
      required int commission}) = _$_InflationReward;

  factory _InflationReward.fromJson(Map<String, dynamic> json) =
      _$_InflationReward.fromJson;

  @override
  int get epoch => throw _privateConstructorUsedError;
  @override
  int get effectiveSlot => throw _privateConstructorUsedError;
  @override
  int get amount => throw _privateConstructorUsedError;
  @override
  int get postBalance => throw _privateConstructorUsedError;
  @override
  int get commission => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InflationRewardCopyWith<_InflationReward> get copyWith =>
      throw _privateConstructorUsedError;
}

LargeAccount _$LargeAccountFromJson(Map<String, dynamic> json) {
  return _LargeAccount.fromJson(json);
}

/// @nodoc
class _$LargeAccountTearOff {
  const _$LargeAccountTearOff();

  _LargeAccount call({required String address, required int lamports}) {
    return _LargeAccount(
      address: address,
      lamports: lamports,
    );
  }

  LargeAccount fromJson(Map<String, Object> json) {
    return LargeAccount.fromJson(json);
  }
}

/// @nodoc
const $LargeAccount = _$LargeAccountTearOff();

/// @nodoc
mixin _$LargeAccount {
  String get address => throw _privateConstructorUsedError;
  int get lamports => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LargeAccountCopyWith<LargeAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LargeAccountCopyWith<$Res> {
  factory $LargeAccountCopyWith(
          LargeAccount value, $Res Function(LargeAccount) then) =
      _$LargeAccountCopyWithImpl<$Res>;
  $Res call({String address, int lamports});
}

/// @nodoc
class _$LargeAccountCopyWithImpl<$Res> implements $LargeAccountCopyWith<$Res> {
  _$LargeAccountCopyWithImpl(this._value, this._then);

  final LargeAccount _value;
  // ignore: unused_field
  final $Res Function(LargeAccount) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? lamports = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$LargeAccountCopyWith<$Res>
    implements $LargeAccountCopyWith<$Res> {
  factory _$LargeAccountCopyWith(
          _LargeAccount value, $Res Function(_LargeAccount) then) =
      __$LargeAccountCopyWithImpl<$Res>;
  @override
  $Res call({String address, int lamports});
}

/// @nodoc
class __$LargeAccountCopyWithImpl<$Res> extends _$LargeAccountCopyWithImpl<$Res>
    implements _$LargeAccountCopyWith<$Res> {
  __$LargeAccountCopyWithImpl(
      _LargeAccount _value, $Res Function(_LargeAccount) _then)
      : super(_value, (v) => _then(v as _LargeAccount));

  @override
  _LargeAccount get _value => super._value as _LargeAccount;

  @override
  $Res call({
    Object? address = freezed,
    Object? lamports = freezed,
  }) {
    return _then(_LargeAccount(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lamports: lamports == freezed
          ? _value.lamports
          : lamports // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LargeAccount implements _LargeAccount {
  const _$_LargeAccount({required this.address, required this.lamports});

  factory _$_LargeAccount.fromJson(Map<String, dynamic> json) =>
      _$$_LargeAccountFromJson(json);

  @override
  final String address;
  @override
  final int lamports;

  @override
  String toString() {
    return 'LargeAccount(address: $address, lamports: $lamports)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LargeAccount &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.lamports, lamports) ||
                const DeepCollectionEquality()
                    .equals(other.lamports, lamports)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(lamports);

  @JsonKey(ignore: true)
  @override
  _$LargeAccountCopyWith<_LargeAccount> get copyWith =>
      __$LargeAccountCopyWithImpl<_LargeAccount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LargeAccountToJson(this);
  }
}

abstract class _LargeAccount implements LargeAccount {
  const factory _LargeAccount(
      {required String address, required int lamports}) = _$_LargeAccount;

  factory _LargeAccount.fromJson(Map<String, dynamic> json) =
      _$_LargeAccount.fromJson;

  @override
  String get address => throw _privateConstructorUsedError;
  @override
  int get lamports => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LargeAccountCopyWith<_LargeAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Filter.fromJson(json);
}

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

  _Filter call({required Map<String, dynamic> memcmp, required int dataSize}) {
    return _Filter(
      memcmp: memcmp,
      dataSize: dataSize,
    );
  }

  Filter fromJson(Map<String, Object> json) {
    return Filter.fromJson(json);
  }
}

/// @nodoc
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
  Map<String, dynamic> get memcmp => throw _privateConstructorUsedError;
  int get dataSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> memcmp, int dataSize});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;

  @override
  $Res call({
    Object? memcmp = freezed,
    Object? dataSize = freezed,
  }) {
    return _then(_value.copyWith(
      memcmp: memcmp == freezed
          ? _value.memcmp
          : memcmp // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      dataSize: dataSize == freezed
          ? _value.dataSize
          : dataSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$FilterCopyWith(_Filter value, $Res Function(_Filter) then) =
      __$FilterCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> memcmp, int dataSize});
}

/// @nodoc
class __$FilterCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements _$FilterCopyWith<$Res> {
  __$FilterCopyWithImpl(_Filter _value, $Res Function(_Filter) _then)
      : super(_value, (v) => _then(v as _Filter));

  @override
  _Filter get _value => super._value as _Filter;

  @override
  $Res call({
    Object? memcmp = freezed,
    Object? dataSize = freezed,
  }) {
    return _then(_Filter(
      memcmp: memcmp == freezed
          ? _value.memcmp
          : memcmp // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      dataSize: dataSize == freezed
          ? _value.dataSize
          : dataSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Filter implements _Filter {
  const _$_Filter({required this.memcmp, required this.dataSize});

  factory _$_Filter.fromJson(Map<String, dynamic> json) =>
      _$$_FilterFromJson(json);

  @override
  final Map<String, dynamic> memcmp;
  @override
  final int dataSize;

  @override
  String toString() {
    return 'Filter(memcmp: $memcmp, dataSize: $dataSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Filter &&
            (identical(other.memcmp, memcmp) ||
                const DeepCollectionEquality().equals(other.memcmp, memcmp)) &&
            (identical(other.dataSize, dataSize) ||
                const DeepCollectionEquality()
                    .equals(other.dataSize, dataSize)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(memcmp) ^
      const DeepCollectionEquality().hash(dataSize);

  @JsonKey(ignore: true)
  @override
  _$FilterCopyWith<_Filter> get copyWith =>
      __$FilterCopyWithImpl<_Filter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterToJson(this);
  }
}

abstract class _Filter implements Filter {
  const factory _Filter(
      {required Map<String, dynamic> memcmp,
      required int dataSize}) = _$_Filter;

  factory _Filter.fromJson(Map<String, dynamic> json) = _$_Filter.fromJson;

  @override
  Map<String, dynamic> get memcmp => throw _privateConstructorUsedError;
  @override
  int get dataSize => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FilterCopyWith<_Filter> get copyWith => throw _privateConstructorUsedError;
}

ProgramAccount _$ProgramAccountFromJson(Map<String, dynamic> json) {
  return _ProgramAccount.fromJson(json);
}

/// @nodoc
class _$ProgramAccountTearOff {
  const _$ProgramAccountTearOff();

  _ProgramAccount call({required Account account, required String pubkey}) {
    return _ProgramAccount(
      account: account,
      pubkey: pubkey,
    );
  }

  ProgramAccount fromJson(Map<String, Object> json) {
    return ProgramAccount.fromJson(json);
  }
}

/// @nodoc
const $ProgramAccount = _$ProgramAccountTearOff();

/// @nodoc
mixin _$ProgramAccount {
  Account get account => throw _privateConstructorUsedError;
  String get pubkey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramAccountCopyWith<ProgramAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramAccountCopyWith<$Res> {
  factory $ProgramAccountCopyWith(
          ProgramAccount value, $Res Function(ProgramAccount) then) =
      _$ProgramAccountCopyWithImpl<$Res>;
  $Res call({Account account, String pubkey});

  $AccountCopyWith<$Res> get account;
}

/// @nodoc
class _$ProgramAccountCopyWithImpl<$Res>
    implements $ProgramAccountCopyWith<$Res> {
  _$ProgramAccountCopyWithImpl(this._value, this._then);

  final ProgramAccount _value;
  // ignore: unused_field
  final $Res Function(ProgramAccount) _then;

  @override
  $Res call({
    Object? account = freezed,
    Object? pubkey = freezed,
  }) {
    return _then(_value.copyWith(
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $AccountCopyWith<$Res> get account {
    return $AccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value));
    });
  }
}

/// @nodoc
abstract class _$ProgramAccountCopyWith<$Res>
    implements $ProgramAccountCopyWith<$Res> {
  factory _$ProgramAccountCopyWith(
          _ProgramAccount value, $Res Function(_ProgramAccount) then) =
      __$ProgramAccountCopyWithImpl<$Res>;
  @override
  $Res call({Account account, String pubkey});

  @override
  $AccountCopyWith<$Res> get account;
}

/// @nodoc
class __$ProgramAccountCopyWithImpl<$Res>
    extends _$ProgramAccountCopyWithImpl<$Res>
    implements _$ProgramAccountCopyWith<$Res> {
  __$ProgramAccountCopyWithImpl(
      _ProgramAccount _value, $Res Function(_ProgramAccount) _then)
      : super(_value, (v) => _then(v as _ProgramAccount));

  @override
  _ProgramAccount get _value => super._value as _ProgramAccount;

  @override
  $Res call({
    Object? account = freezed,
    Object? pubkey = freezed,
  }) {
    return _then(_ProgramAccount(
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgramAccount implements _ProgramAccount {
  const _$_ProgramAccount({required this.account, required this.pubkey});

  factory _$_ProgramAccount.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramAccountFromJson(json);

  @override
  final Account account;
  @override
  final String pubkey;

  @override
  String toString() {
    return 'ProgramAccount(account: $account, pubkey: $pubkey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProgramAccount &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.pubkey, pubkey) ||
                const DeepCollectionEquality().equals(other.pubkey, pubkey)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(pubkey);

  @JsonKey(ignore: true)
  @override
  _$ProgramAccountCopyWith<_ProgramAccount> get copyWith =>
      __$ProgramAccountCopyWithImpl<_ProgramAccount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramAccountToJson(this);
  }
}

abstract class _ProgramAccount implements ProgramAccount {
  const factory _ProgramAccount(
      {required Account account, required String pubkey}) = _$_ProgramAccount;

  factory _ProgramAccount.fromJson(Map<String, dynamic> json) =
      _$_ProgramAccount.fromJson;

  @override
  Account get account => throw _privateConstructorUsedError;
  @override
  String get pubkey => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProgramAccountCopyWith<_ProgramAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentBlockhash _$RecentBlockhashFromJson(Map<String, dynamic> json) {
  return _RecentBlockhash.fromJson(json);
}

/// @nodoc
class _$RecentBlockhashTearOff {
  const _$RecentBlockhashTearOff();

  _RecentBlockhash call(
      {required String blockhash, required FeeCalculator feeCalculator}) {
    return _RecentBlockhash(
      blockhash: blockhash,
      feeCalculator: feeCalculator,
    );
  }

  RecentBlockhash fromJson(Map<String, Object> json) {
    return RecentBlockhash.fromJson(json);
  }
}

/// @nodoc
const $RecentBlockhash = _$RecentBlockhashTearOff();

/// @nodoc
mixin _$RecentBlockhash {
  String get blockhash => throw _privateConstructorUsedError;
  FeeCalculator get feeCalculator => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentBlockhashCopyWith<RecentBlockhash> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentBlockhashCopyWith<$Res> {
  factory $RecentBlockhashCopyWith(
          RecentBlockhash value, $Res Function(RecentBlockhash) then) =
      _$RecentBlockhashCopyWithImpl<$Res>;
  $Res call({String blockhash, FeeCalculator feeCalculator});

  $FeeCalculatorCopyWith<$Res> get feeCalculator;
}

/// @nodoc
class _$RecentBlockhashCopyWithImpl<$Res>
    implements $RecentBlockhashCopyWith<$Res> {
  _$RecentBlockhashCopyWithImpl(this._value, this._then);

  final RecentBlockhash _value;
  // ignore: unused_field
  final $Res Function(RecentBlockhash) _then;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? feeCalculator = freezed,
  }) {
    return _then(_value.copyWith(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as FeeCalculator,
    ));
  }

  @override
  $FeeCalculatorCopyWith<$Res> get feeCalculator {
    return $FeeCalculatorCopyWith<$Res>(_value.feeCalculator, (value) {
      return _then(_value.copyWith(feeCalculator: value));
    });
  }
}

/// @nodoc
abstract class _$RecentBlockhashCopyWith<$Res>
    implements $RecentBlockhashCopyWith<$Res> {
  factory _$RecentBlockhashCopyWith(
          _RecentBlockhash value, $Res Function(_RecentBlockhash) then) =
      __$RecentBlockhashCopyWithImpl<$Res>;
  @override
  $Res call({String blockhash, FeeCalculator feeCalculator});

  @override
  $FeeCalculatorCopyWith<$Res> get feeCalculator;
}

/// @nodoc
class __$RecentBlockhashCopyWithImpl<$Res>
    extends _$RecentBlockhashCopyWithImpl<$Res>
    implements _$RecentBlockhashCopyWith<$Res> {
  __$RecentBlockhashCopyWithImpl(
      _RecentBlockhash _value, $Res Function(_RecentBlockhash) _then)
      : super(_value, (v) => _then(v as _RecentBlockhash));

  @override
  _RecentBlockhash get _value => super._value as _RecentBlockhash;

  @override
  $Res call({
    Object? blockhash = freezed,
    Object? feeCalculator = freezed,
  }) {
    return _then(_RecentBlockhash(
      blockhash: blockhash == freezed
          ? _value.blockhash
          : blockhash // ignore: cast_nullable_to_non_nullable
              as String,
      feeCalculator: feeCalculator == freezed
          ? _value.feeCalculator
          : feeCalculator // ignore: cast_nullable_to_non_nullable
              as FeeCalculator,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecentBlockhash implements _RecentBlockhash {
  const _$_RecentBlockhash(
      {required this.blockhash, required this.feeCalculator});

  factory _$_RecentBlockhash.fromJson(Map<String, dynamic> json) =>
      _$$_RecentBlockhashFromJson(json);

  @override
  final String blockhash;
  @override
  final FeeCalculator feeCalculator;

  @override
  String toString() {
    return 'RecentBlockhash(blockhash: $blockhash, feeCalculator: $feeCalculator)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RecentBlockhash &&
            (identical(other.blockhash, blockhash) ||
                const DeepCollectionEquality()
                    .equals(other.blockhash, blockhash)) &&
            (identical(other.feeCalculator, feeCalculator) ||
                const DeepCollectionEquality()
                    .equals(other.feeCalculator, feeCalculator)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(blockhash) ^
      const DeepCollectionEquality().hash(feeCalculator);

  @JsonKey(ignore: true)
  @override
  _$RecentBlockhashCopyWith<_RecentBlockhash> get copyWith =>
      __$RecentBlockhashCopyWithImpl<_RecentBlockhash>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecentBlockhashToJson(this);
  }
}

abstract class _RecentBlockhash implements RecentBlockhash {
  const factory _RecentBlockhash(
      {required String blockhash,
      required FeeCalculator feeCalculator}) = _$_RecentBlockhash;

  factory _RecentBlockhash.fromJson(Map<String, dynamic> json) =
      _$_RecentBlockhash.fromJson;

  @override
  String get blockhash => throw _privateConstructorUsedError;
  @override
  FeeCalculator get feeCalculator => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecentBlockhashCopyWith<_RecentBlockhash> get copyWith =>
      throw _privateConstructorUsedError;
}

PerfSample _$PerfSampleFromJson(Map<String, dynamic> json) {
  return _PerfSample.fromJson(json);
}

/// @nodoc
class _$PerfSampleTearOff {
  const _$PerfSampleTearOff();

  _PerfSample call(
      {required int slot,
      required int numTransactions,
      required int numSlots,
      required int samplePeriodSec}) {
    return _PerfSample(
      slot: slot,
      numTransactions: numTransactions,
      numSlots: numSlots,
      samplePeriodSec: samplePeriodSec,
    );
  }

  PerfSample fromJson(Map<String, Object> json) {
    return PerfSample.fromJson(json);
  }
}

/// @nodoc
const $PerfSample = _$PerfSampleTearOff();

/// @nodoc
mixin _$PerfSample {
  int get slot => throw _privateConstructorUsedError;
  int get numTransactions => throw _privateConstructorUsedError;
  int get numSlots => throw _privateConstructorUsedError;
  int get samplePeriodSec => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerfSampleCopyWith<PerfSample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerfSampleCopyWith<$Res> {
  factory $PerfSampleCopyWith(
          PerfSample value, $Res Function(PerfSample) then) =
      _$PerfSampleCopyWithImpl<$Res>;
  $Res call({int slot, int numTransactions, int numSlots, int samplePeriodSec});
}

/// @nodoc
class _$PerfSampleCopyWithImpl<$Res> implements $PerfSampleCopyWith<$Res> {
  _$PerfSampleCopyWithImpl(this._value, this._then);

  final PerfSample _value;
  // ignore: unused_field
  final $Res Function(PerfSample) _then;

  @override
  $Res call({
    Object? slot = freezed,
    Object? numTransactions = freezed,
    Object? numSlots = freezed,
    Object? samplePeriodSec = freezed,
  }) {
    return _then(_value.copyWith(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      numTransactions: numTransactions == freezed
          ? _value.numTransactions
          : numTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      numSlots: numSlots == freezed
          ? _value.numSlots
          : numSlots // ignore: cast_nullable_to_non_nullable
              as int,
      samplePeriodSec: samplePeriodSec == freezed
          ? _value.samplePeriodSec
          : samplePeriodSec // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PerfSampleCopyWith<$Res> implements $PerfSampleCopyWith<$Res> {
  factory _$PerfSampleCopyWith(
          _PerfSample value, $Res Function(_PerfSample) then) =
      __$PerfSampleCopyWithImpl<$Res>;
  @override
  $Res call({int slot, int numTransactions, int numSlots, int samplePeriodSec});
}

/// @nodoc
class __$PerfSampleCopyWithImpl<$Res> extends _$PerfSampleCopyWithImpl<$Res>
    implements _$PerfSampleCopyWith<$Res> {
  __$PerfSampleCopyWithImpl(
      _PerfSample _value, $Res Function(_PerfSample) _then)
      : super(_value, (v) => _then(v as _PerfSample));

  @override
  _PerfSample get _value => super._value as _PerfSample;

  @override
  $Res call({
    Object? slot = freezed,
    Object? numTransactions = freezed,
    Object? numSlots = freezed,
    Object? samplePeriodSec = freezed,
  }) {
    return _then(_PerfSample(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      numTransactions: numTransactions == freezed
          ? _value.numTransactions
          : numTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      numSlots: numSlots == freezed
          ? _value.numSlots
          : numSlots // ignore: cast_nullable_to_non_nullable
              as int,
      samplePeriodSec: samplePeriodSec == freezed
          ? _value.samplePeriodSec
          : samplePeriodSec // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PerfSample implements _PerfSample {
  const _$_PerfSample(
      {required this.slot,
      required this.numTransactions,
      required this.numSlots,
      required this.samplePeriodSec});

  factory _$_PerfSample.fromJson(Map<String, dynamic> json) =>
      _$$_PerfSampleFromJson(json);

  @override
  final int slot;
  @override
  final int numTransactions;
  @override
  final int numSlots;
  @override
  final int samplePeriodSec;

  @override
  String toString() {
    return 'PerfSample(slot: $slot, numTransactions: $numTransactions, numSlots: $numSlots, samplePeriodSec: $samplePeriodSec)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PerfSample &&
            (identical(other.slot, slot) ||
                const DeepCollectionEquality().equals(other.slot, slot)) &&
            (identical(other.numTransactions, numTransactions) ||
                const DeepCollectionEquality()
                    .equals(other.numTransactions, numTransactions)) &&
            (identical(other.numSlots, numSlots) ||
                const DeepCollectionEquality()
                    .equals(other.numSlots, numSlots)) &&
            (identical(other.samplePeriodSec, samplePeriodSec) ||
                const DeepCollectionEquality()
                    .equals(other.samplePeriodSec, samplePeriodSec)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(slot) ^
      const DeepCollectionEquality().hash(numTransactions) ^
      const DeepCollectionEquality().hash(numSlots) ^
      const DeepCollectionEquality().hash(samplePeriodSec);

  @JsonKey(ignore: true)
  @override
  _$PerfSampleCopyWith<_PerfSample> get copyWith =>
      __$PerfSampleCopyWithImpl<_PerfSample>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PerfSampleToJson(this);
  }
}

abstract class _PerfSample implements PerfSample {
  const factory _PerfSample(
      {required int slot,
      required int numTransactions,
      required int numSlots,
      required int samplePeriodSec}) = _$_PerfSample;

  factory _PerfSample.fromJson(Map<String, dynamic> json) =
      _$_PerfSample.fromJson;

  @override
  int get slot => throw _privateConstructorUsedError;
  @override
  int get numTransactions => throw _privateConstructorUsedError;
  @override
  int get numSlots => throw _privateConstructorUsedError;
  @override
  int get samplePeriodSec => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PerfSampleCopyWith<_PerfSample> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionSignatureInformation _$TransactionSignatureInformationFromJson(
    Map<String, dynamic> json) {
  return _TransactionSignatureInformation.fromJson(json);
}

/// @nodoc
class _$TransactionSignatureInformationTearOff {
  const _$TransactionSignatureInformationTearOff();

  _TransactionSignatureInformation call(
      {required String signature,
      required int slot,
      required Map<String, dynamic>? err,
      required String? memo,
      required int? blockTime}) {
    return _TransactionSignatureInformation(
      signature: signature,
      slot: slot,
      err: err,
      memo: memo,
      blockTime: blockTime,
    );
  }

  TransactionSignatureInformation fromJson(Map<String, Object> json) {
    return TransactionSignatureInformation.fromJson(json);
  }
}

/// @nodoc
const $TransactionSignatureInformation =
    _$TransactionSignatureInformationTearOff();

/// @nodoc
mixin _$TransactionSignatureInformation {
  String get signature => throw _privateConstructorUsedError;
  int get slot => throw _privateConstructorUsedError;
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  int? get blockTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionSignatureInformationCopyWith<TransactionSignatureInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionSignatureInformationCopyWith<$Res> {
  factory $TransactionSignatureInformationCopyWith(
          TransactionSignatureInformation value,
          $Res Function(TransactionSignatureInformation) then) =
      _$TransactionSignatureInformationCopyWithImpl<$Res>;
  $Res call(
      {String signature,
      int slot,
      Map<String, dynamic>? err,
      String? memo,
      int? blockTime});
}

/// @nodoc
class _$TransactionSignatureInformationCopyWithImpl<$Res>
    implements $TransactionSignatureInformationCopyWith<$Res> {
  _$TransactionSignatureInformationCopyWithImpl(this._value, this._then);

  final TransactionSignatureInformation _value;
  // ignore: unused_field
  final $Res Function(TransactionSignatureInformation) _then;

  @override
  $Res call({
    Object? signature = freezed,
    Object? slot = freezed,
    Object? err = freezed,
    Object? memo = freezed,
    Object? blockTime = freezed,
  }) {
    return _then(_value.copyWith(
      signature: signature == freezed
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$TransactionSignatureInformationCopyWith<$Res>
    implements $TransactionSignatureInformationCopyWith<$Res> {
  factory _$TransactionSignatureInformationCopyWith(
          _TransactionSignatureInformation value,
          $Res Function(_TransactionSignatureInformation) then) =
      __$TransactionSignatureInformationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String signature,
      int slot,
      Map<String, dynamic>? err,
      String? memo,
      int? blockTime});
}

/// @nodoc
class __$TransactionSignatureInformationCopyWithImpl<$Res>
    extends _$TransactionSignatureInformationCopyWithImpl<$Res>
    implements _$TransactionSignatureInformationCopyWith<$Res> {
  __$TransactionSignatureInformationCopyWithImpl(
      _TransactionSignatureInformation _value,
      $Res Function(_TransactionSignatureInformation) _then)
      : super(_value, (v) => _then(v as _TransactionSignatureInformation));

  @override
  _TransactionSignatureInformation get _value =>
      super._value as _TransactionSignatureInformation;

  @override
  $Res call({
    Object? signature = freezed,
    Object? slot = freezed,
    Object? err = freezed,
    Object? memo = freezed,
    Object? blockTime = freezed,
  }) {
    return _then(_TransactionSignatureInformation(
      signature: signature == freezed
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      blockTime: blockTime == freezed
          ? _value.blockTime
          : blockTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionSignatureInformation
    implements _TransactionSignatureInformation {
  const _$_TransactionSignatureInformation(
      {required this.signature,
      required this.slot,
      required this.err,
      required this.memo,
      required this.blockTime});

  factory _$_TransactionSignatureInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_TransactionSignatureInformationFromJson(json);

  @override
  final String signature;
  @override
  final int slot;
  @override
  final Map<String, dynamic>? err;
  @override
  final String? memo;
  @override
  final int? blockTime;

  @override
  String toString() {
    return 'TransactionSignatureInformation(signature: $signature, slot: $slot, err: $err, memo: $memo, blockTime: $blockTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransactionSignatureInformation &&
            (identical(other.signature, signature) ||
                const DeepCollectionEquality()
                    .equals(other.signature, signature)) &&
            (identical(other.slot, slot) ||
                const DeepCollectionEquality().equals(other.slot, slot)) &&
            (identical(other.err, err) ||
                const DeepCollectionEquality().equals(other.err, err)) &&
            (identical(other.memo, memo) ||
                const DeepCollectionEquality().equals(other.memo, memo)) &&
            (identical(other.blockTime, blockTime) ||
                const DeepCollectionEquality()
                    .equals(other.blockTime, blockTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(signature) ^
      const DeepCollectionEquality().hash(slot) ^
      const DeepCollectionEquality().hash(err) ^
      const DeepCollectionEquality().hash(memo) ^
      const DeepCollectionEquality().hash(blockTime);

  @JsonKey(ignore: true)
  @override
  _$TransactionSignatureInformationCopyWith<_TransactionSignatureInformation>
      get copyWith => __$TransactionSignatureInformationCopyWithImpl<
          _TransactionSignatureInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionSignatureInformationToJson(this);
  }
}

abstract class _TransactionSignatureInformation
    implements TransactionSignatureInformation {
  const factory _TransactionSignatureInformation(
      {required String signature,
      required int slot,
      required Map<String, dynamic>? err,
      required String? memo,
      required int? blockTime}) = _$_TransactionSignatureInformation;

  factory _TransactionSignatureInformation.fromJson(Map<String, dynamic> json) =
      _$_TransactionSignatureInformation.fromJson;

  @override
  String get signature => throw _privateConstructorUsedError;
  @override
  int get slot => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  @override
  String? get memo => throw _privateConstructorUsedError;
  @override
  int? get blockTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionSignatureInformationCopyWith<_TransactionSignatureInformation>
      get copyWith => throw _privateConstructorUsedError;
}

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) {
  return _SignatureStatus.fromJson(json);
}

/// @nodoc
class _$SignatureStatusTearOff {
  const _$SignatureStatusTearOff();

  _SignatureStatus call(
      {required int slot,
      required int? confirmations,
      required Map<String, dynamic>? err,
      required Commitment confirmationStatus}) {
    return _SignatureStatus(
      slot: slot,
      confirmations: confirmations,
      err: err,
      confirmationStatus: confirmationStatus,
    );
  }

  SignatureStatus fromJson(Map<String, Object> json) {
    return SignatureStatus.fromJson(json);
  }
}

/// @nodoc
const $SignatureStatus = _$SignatureStatusTearOff();

/// @nodoc
mixin _$SignatureStatus {
  int get slot => throw _privateConstructorUsedError;
  int? get confirmations => throw _privateConstructorUsedError;
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  Commitment get confirmationStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignatureStatusCopyWith<SignatureStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignatureStatusCopyWith<$Res> {
  factory $SignatureStatusCopyWith(
          SignatureStatus value, $Res Function(SignatureStatus) then) =
      _$SignatureStatusCopyWithImpl<$Res>;
  $Res call(
      {int slot,
      int? confirmations,
      Map<String, dynamic>? err,
      Commitment confirmationStatus});
}

/// @nodoc
class _$SignatureStatusCopyWithImpl<$Res>
    implements $SignatureStatusCopyWith<$Res> {
  _$SignatureStatusCopyWithImpl(this._value, this._then);

  final SignatureStatus _value;
  // ignore: unused_field
  final $Res Function(SignatureStatus) _then;

  @override
  $Res call({
    Object? slot = freezed,
    Object? confirmations = freezed,
    Object? err = freezed,
    Object? confirmationStatus = freezed,
  }) {
    return _then(_value.copyWith(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      confirmations: confirmations == freezed
          ? _value.confirmations
          : confirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      confirmationStatus: confirmationStatus == freezed
          ? _value.confirmationStatus
          : confirmationStatus // ignore: cast_nullable_to_non_nullable
              as Commitment,
    ));
  }
}

/// @nodoc
abstract class _$SignatureStatusCopyWith<$Res>
    implements $SignatureStatusCopyWith<$Res> {
  factory _$SignatureStatusCopyWith(
          _SignatureStatus value, $Res Function(_SignatureStatus) then) =
      __$SignatureStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {int slot,
      int? confirmations,
      Map<String, dynamic>? err,
      Commitment confirmationStatus});
}

/// @nodoc
class __$SignatureStatusCopyWithImpl<$Res>
    extends _$SignatureStatusCopyWithImpl<$Res>
    implements _$SignatureStatusCopyWith<$Res> {
  __$SignatureStatusCopyWithImpl(
      _SignatureStatus _value, $Res Function(_SignatureStatus) _then)
      : super(_value, (v) => _then(v as _SignatureStatus));

  @override
  _SignatureStatus get _value => super._value as _SignatureStatus;

  @override
  $Res call({
    Object? slot = freezed,
    Object? confirmations = freezed,
    Object? err = freezed,
    Object? confirmationStatus = freezed,
  }) {
    return _then(_SignatureStatus(
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as int,
      confirmations: confirmations == freezed
          ? _value.confirmations
          : confirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      confirmationStatus: confirmationStatus == freezed
          ? _value.confirmationStatus
          : confirmationStatus // ignore: cast_nullable_to_non_nullable
              as Commitment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SignatureStatus implements _SignatureStatus {
  const _$_SignatureStatus(
      {required this.slot,
      required this.confirmations,
      required this.err,
      required this.confirmationStatus});

  factory _$_SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$$_SignatureStatusFromJson(json);

  @override
  final int slot;
  @override
  final int? confirmations;
  @override
  final Map<String, dynamic>? err;
  @override
  final Commitment confirmationStatus;

  @override
  String toString() {
    return 'SignatureStatus(slot: $slot, confirmations: $confirmations, err: $err, confirmationStatus: $confirmationStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignatureStatus &&
            (identical(other.slot, slot) ||
                const DeepCollectionEquality().equals(other.slot, slot)) &&
            (identical(other.confirmations, confirmations) ||
                const DeepCollectionEquality()
                    .equals(other.confirmations, confirmations)) &&
            (identical(other.err, err) ||
                const DeepCollectionEquality().equals(other.err, err)) &&
            (identical(other.confirmationStatus, confirmationStatus) ||
                const DeepCollectionEquality()
                    .equals(other.confirmationStatus, confirmationStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(slot) ^
      const DeepCollectionEquality().hash(confirmations) ^
      const DeepCollectionEquality().hash(err) ^
      const DeepCollectionEquality().hash(confirmationStatus);

  @JsonKey(ignore: true)
  @override
  _$SignatureStatusCopyWith<_SignatureStatus> get copyWith =>
      __$SignatureStatusCopyWithImpl<_SignatureStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignatureStatusToJson(this);
  }
}

abstract class _SignatureStatus implements SignatureStatus {
  const factory _SignatureStatus(
      {required int slot,
      required int? confirmations,
      required Map<String, dynamic>? err,
      required Commitment confirmationStatus}) = _$_SignatureStatus;

  factory _SignatureStatus.fromJson(Map<String, dynamic> json) =
      _$_SignatureStatus.fromJson;

  @override
  int get slot => throw _privateConstructorUsedError;
  @override
  int? get confirmations => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  @override
  Commitment get confirmationStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SignatureStatusCopyWith<_SignatureStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

StakeActivation _$StakeActivationFromJson(Map<String, dynamic> json) {
  return _StakeActivation.fromJson(json);
}

/// @nodoc
class _$StakeActivationTearOff {
  const _$StakeActivationTearOff();

  _StakeActivation call(
      {required StakeActivationState state,
      required int active,
      required int inactive}) {
    return _StakeActivation(
      state: state,
      active: active,
      inactive: inactive,
    );
  }

  StakeActivation fromJson(Map<String, Object> json) {
    return StakeActivation.fromJson(json);
  }
}

/// @nodoc
const $StakeActivation = _$StakeActivationTearOff();

/// @nodoc
mixin _$StakeActivation {
  StakeActivationState get state => throw _privateConstructorUsedError;
  int get active => throw _privateConstructorUsedError;
  int get inactive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeActivationCopyWith<StakeActivation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeActivationCopyWith<$Res> {
  factory $StakeActivationCopyWith(
          StakeActivation value, $Res Function(StakeActivation) then) =
      _$StakeActivationCopyWithImpl<$Res>;
  $Res call({StakeActivationState state, int active, int inactive});
}

/// @nodoc
class _$StakeActivationCopyWithImpl<$Res>
    implements $StakeActivationCopyWith<$Res> {
  _$StakeActivationCopyWithImpl(this._value, this._then);

  final StakeActivation _value;
  // ignore: unused_field
  final $Res Function(StakeActivation) _then;

  @override
  $Res call({
    Object? state = freezed,
    Object? active = freezed,
    Object? inactive = freezed,
  }) {
    return _then(_value.copyWith(
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as StakeActivationState,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      inactive: inactive == freezed
          ? _value.inactive
          : inactive // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$StakeActivationCopyWith<$Res>
    implements $StakeActivationCopyWith<$Res> {
  factory _$StakeActivationCopyWith(
          _StakeActivation value, $Res Function(_StakeActivation) then) =
      __$StakeActivationCopyWithImpl<$Res>;
  @override
  $Res call({StakeActivationState state, int active, int inactive});
}

/// @nodoc
class __$StakeActivationCopyWithImpl<$Res>
    extends _$StakeActivationCopyWithImpl<$Res>
    implements _$StakeActivationCopyWith<$Res> {
  __$StakeActivationCopyWithImpl(
      _StakeActivation _value, $Res Function(_StakeActivation) _then)
      : super(_value, (v) => _then(v as _StakeActivation));

  @override
  _StakeActivation get _value => super._value as _StakeActivation;

  @override
  $Res call({
    Object? state = freezed,
    Object? active = freezed,
    Object? inactive = freezed,
  }) {
    return _then(_StakeActivation(
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as StakeActivationState,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      inactive: inactive == freezed
          ? _value.inactive
          : inactive // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StakeActivation implements _StakeActivation {
  const _$_StakeActivation(
      {required this.state, required this.active, required this.inactive});

  factory _$_StakeActivation.fromJson(Map<String, dynamic> json) =>
      _$$_StakeActivationFromJson(json);

  @override
  final StakeActivationState state;
  @override
  final int active;
  @override
  final int inactive;

  @override
  String toString() {
    return 'StakeActivation(state: $state, active: $active, inactive: $inactive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StakeActivation &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.inactive, inactive) ||
                const DeepCollectionEquality()
                    .equals(other.inactive, inactive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(inactive);

  @JsonKey(ignore: true)
  @override
  _$StakeActivationCopyWith<_StakeActivation> get copyWith =>
      __$StakeActivationCopyWithImpl<_StakeActivation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StakeActivationToJson(this);
  }
}

abstract class _StakeActivation implements StakeActivation {
  const factory _StakeActivation(
      {required StakeActivationState state,
      required int active,
      required int inactive}) = _$_StakeActivation;

  factory _StakeActivation.fromJson(Map<String, dynamic> json) =
      _$_StakeActivation.fromJson;

  @override
  StakeActivationState get state => throw _privateConstructorUsedError;
  @override
  int get active => throw _privateConstructorUsedError;
  @override
  int get inactive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StakeActivationCopyWith<_StakeActivation> get copyWith =>
      throw _privateConstructorUsedError;
}

Supply _$SupplyFromJson(Map<String, dynamic> json) {
  return _Supply.fromJson(json);
}

/// @nodoc
class _$SupplyTearOff {
  const _$SupplyTearOff();

  _Supply call(
      {required int total,
      required int circulating,
      required int nonCirculating,
      required List<String> nonCirculatingAccounts}) {
    return _Supply(
      total: total,
      circulating: circulating,
      nonCirculating: nonCirculating,
      nonCirculatingAccounts: nonCirculatingAccounts,
    );
  }

  Supply fromJson(Map<String, Object> json) {
    return Supply.fromJson(json);
  }
}

/// @nodoc
const $Supply = _$SupplyTearOff();

/// @nodoc
mixin _$Supply {
  int get total => throw _privateConstructorUsedError;
  int get circulating => throw _privateConstructorUsedError;
  int get nonCirculating => throw _privateConstructorUsedError;
  List<String> get nonCirculatingAccounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupplyCopyWith<Supply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplyCopyWith<$Res> {
  factory $SupplyCopyWith(Supply value, $Res Function(Supply) then) =
      _$SupplyCopyWithImpl<$Res>;
  $Res call(
      {int total,
      int circulating,
      int nonCirculating,
      List<String> nonCirculatingAccounts});
}

/// @nodoc
class _$SupplyCopyWithImpl<$Res> implements $SupplyCopyWith<$Res> {
  _$SupplyCopyWithImpl(this._value, this._then);

  final Supply _value;
  // ignore: unused_field
  final $Res Function(Supply) _then;

  @override
  $Res call({
    Object? total = freezed,
    Object? circulating = freezed,
    Object? nonCirculating = freezed,
    Object? nonCirculatingAccounts = freezed,
  }) {
    return _then(_value.copyWith(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      circulating: circulating == freezed
          ? _value.circulating
          : circulating // ignore: cast_nullable_to_non_nullable
              as int,
      nonCirculating: nonCirculating == freezed
          ? _value.nonCirculating
          : nonCirculating // ignore: cast_nullable_to_non_nullable
              as int,
      nonCirculatingAccounts: nonCirculatingAccounts == freezed
          ? _value.nonCirculatingAccounts
          : nonCirculatingAccounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$SupplyCopyWith<$Res> implements $SupplyCopyWith<$Res> {
  factory _$SupplyCopyWith(_Supply value, $Res Function(_Supply) then) =
      __$SupplyCopyWithImpl<$Res>;
  @override
  $Res call(
      {int total,
      int circulating,
      int nonCirculating,
      List<String> nonCirculatingAccounts});
}

/// @nodoc
class __$SupplyCopyWithImpl<$Res> extends _$SupplyCopyWithImpl<$Res>
    implements _$SupplyCopyWith<$Res> {
  __$SupplyCopyWithImpl(_Supply _value, $Res Function(_Supply) _then)
      : super(_value, (v) => _then(v as _Supply));

  @override
  _Supply get _value => super._value as _Supply;

  @override
  $Res call({
    Object? total = freezed,
    Object? circulating = freezed,
    Object? nonCirculating = freezed,
    Object? nonCirculatingAccounts = freezed,
  }) {
    return _then(_Supply(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      circulating: circulating == freezed
          ? _value.circulating
          : circulating // ignore: cast_nullable_to_non_nullable
              as int,
      nonCirculating: nonCirculating == freezed
          ? _value.nonCirculating
          : nonCirculating // ignore: cast_nullable_to_non_nullable
              as int,
      nonCirculatingAccounts: nonCirculatingAccounts == freezed
          ? _value.nonCirculatingAccounts
          : nonCirculatingAccounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Supply implements _Supply {
  const _$_Supply(
      {required this.total,
      required this.circulating,
      required this.nonCirculating,
      required this.nonCirculatingAccounts});

  factory _$_Supply.fromJson(Map<String, dynamic> json) =>
      _$$_SupplyFromJson(json);

  @override
  final int total;
  @override
  final int circulating;
  @override
  final int nonCirculating;
  @override
  final List<String> nonCirculatingAccounts;

  @override
  String toString() {
    return 'Supply(total: $total, circulating: $circulating, nonCirculating: $nonCirculating, nonCirculatingAccounts: $nonCirculatingAccounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Supply &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.circulating, circulating) ||
                const DeepCollectionEquality()
                    .equals(other.circulating, circulating)) &&
            (identical(other.nonCirculating, nonCirculating) ||
                const DeepCollectionEquality()
                    .equals(other.nonCirculating, nonCirculating)) &&
            (identical(other.nonCirculatingAccounts, nonCirculatingAccounts) ||
                const DeepCollectionEquality().equals(
                    other.nonCirculatingAccounts, nonCirculatingAccounts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(circulating) ^
      const DeepCollectionEquality().hash(nonCirculating) ^
      const DeepCollectionEquality().hash(nonCirculatingAccounts);

  @JsonKey(ignore: true)
  @override
  _$SupplyCopyWith<_Supply> get copyWith =>
      __$SupplyCopyWithImpl<_Supply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupplyToJson(this);
  }
}

abstract class _Supply implements Supply {
  const factory _Supply(
      {required int total,
      required int circulating,
      required int nonCirculating,
      required List<String> nonCirculatingAccounts}) = _$_Supply;

  factory _Supply.fromJson(Map<String, dynamic> json) = _$_Supply.fromJson;

  @override
  int get total => throw _privateConstructorUsedError;
  @override
  int get circulating => throw _privateConstructorUsedError;
  @override
  int get nonCirculating => throw _privateConstructorUsedError;
  @override
  List<String> get nonCirculatingAccounts => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SupplyCopyWith<_Supply> get copyWith => throw _privateConstructorUsedError;
}

SolanaVersion _$SolanaVersionFromJson(Map<String, dynamic> json) {
  return _SolanaVersion.fromJson(json);
}

/// @nodoc
class _$SolanaVersionTearOff {
  const _$SolanaVersionTearOff();

  _SolanaVersion call(
      {@JsonKey(name: 'solana-core') required String solanaCore,
      @JsonKey(name: 'feature-set') required int featureSet}) {
    return _SolanaVersion(
      solanaCore: solanaCore,
      featureSet: featureSet,
    );
  }

  SolanaVersion fromJson(Map<String, Object> json) {
    return SolanaVersion.fromJson(json);
  }
}

/// @nodoc
const $SolanaVersion = _$SolanaVersionTearOff();

/// @nodoc
mixin _$SolanaVersion {
  @JsonKey(name: 'solana-core')
  String get solanaCore => throw _privateConstructorUsedError;
  @JsonKey(name: 'feature-set')
  int get featureSet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SolanaVersionCopyWith<SolanaVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolanaVersionCopyWith<$Res> {
  factory $SolanaVersionCopyWith(
          SolanaVersion value, $Res Function(SolanaVersion) then) =
      _$SolanaVersionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'solana-core') String solanaCore,
      @JsonKey(name: 'feature-set') int featureSet});
}

/// @nodoc
class _$SolanaVersionCopyWithImpl<$Res>
    implements $SolanaVersionCopyWith<$Res> {
  _$SolanaVersionCopyWithImpl(this._value, this._then);

  final SolanaVersion _value;
  // ignore: unused_field
  final $Res Function(SolanaVersion) _then;

  @override
  $Res call({
    Object? solanaCore = freezed,
    Object? featureSet = freezed,
  }) {
    return _then(_value.copyWith(
      solanaCore: solanaCore == freezed
          ? _value.solanaCore
          : solanaCore // ignore: cast_nullable_to_non_nullable
              as String,
      featureSet: featureSet == freezed
          ? _value.featureSet
          : featureSet // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$SolanaVersionCopyWith<$Res>
    implements $SolanaVersionCopyWith<$Res> {
  factory _$SolanaVersionCopyWith(
          _SolanaVersion value, $Res Function(_SolanaVersion) then) =
      __$SolanaVersionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'solana-core') String solanaCore,
      @JsonKey(name: 'feature-set') int featureSet});
}

/// @nodoc
class __$SolanaVersionCopyWithImpl<$Res>
    extends _$SolanaVersionCopyWithImpl<$Res>
    implements _$SolanaVersionCopyWith<$Res> {
  __$SolanaVersionCopyWithImpl(
      _SolanaVersion _value, $Res Function(_SolanaVersion) _then)
      : super(_value, (v) => _then(v as _SolanaVersion));

  @override
  _SolanaVersion get _value => super._value as _SolanaVersion;

  @override
  $Res call({
    Object? solanaCore = freezed,
    Object? featureSet = freezed,
  }) {
    return _then(_SolanaVersion(
      solanaCore: solanaCore == freezed
          ? _value.solanaCore
          : solanaCore // ignore: cast_nullable_to_non_nullable
              as String,
      featureSet: featureSet == freezed
          ? _value.featureSet
          : featureSet // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SolanaVersion implements _SolanaVersion {
  const _$_SolanaVersion(
      {@JsonKey(name: 'solana-core') required this.solanaCore,
      @JsonKey(name: 'feature-set') required this.featureSet});

  factory _$_SolanaVersion.fromJson(Map<String, dynamic> json) =>
      _$$_SolanaVersionFromJson(json);

  @override
  @JsonKey(name: 'solana-core')
  final String solanaCore;
  @override
  @JsonKey(name: 'feature-set')
  final int featureSet;

  @override
  String toString() {
    return 'SolanaVersion(solanaCore: $solanaCore, featureSet: $featureSet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SolanaVersion &&
            (identical(other.solanaCore, solanaCore) ||
                const DeepCollectionEquality()
                    .equals(other.solanaCore, solanaCore)) &&
            (identical(other.featureSet, featureSet) ||
                const DeepCollectionEquality()
                    .equals(other.featureSet, featureSet)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(solanaCore) ^
      const DeepCollectionEquality().hash(featureSet);

  @JsonKey(ignore: true)
  @override
  _$SolanaVersionCopyWith<_SolanaVersion> get copyWith =>
      __$SolanaVersionCopyWithImpl<_SolanaVersion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SolanaVersionToJson(this);
  }
}

abstract class _SolanaVersion implements SolanaVersion {
  const factory _SolanaVersion(
          {@JsonKey(name: 'solana-core') required String solanaCore,
          @JsonKey(name: 'feature-set') required int featureSet}) =
      _$_SolanaVersion;

  factory _SolanaVersion.fromJson(Map<String, dynamic> json) =
      _$_SolanaVersion.fromJson;

  @override
  @JsonKey(name: 'solana-core')
  String get solanaCore => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'feature-set')
  int get featureSet => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SolanaVersionCopyWith<_SolanaVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

VoteAccounts _$VoteAccountsFromJson(Map<String, dynamic> json) {
  return _VoteAccounts.fromJson(json);
}

/// @nodoc
class _$VoteAccountsTearOff {
  const _$VoteAccountsTearOff();

  _VoteAccounts call(
      {required String votePubkey,
      required String nodePubkey,
      required int activatedStake,
      required bool epochVoteAccount,
      required int commission,
      required int lastVote,
      required List<int> epochCredits}) {
    return _VoteAccounts(
      votePubkey: votePubkey,
      nodePubkey: nodePubkey,
      activatedStake: activatedStake,
      epochVoteAccount: epochVoteAccount,
      commission: commission,
      lastVote: lastVote,
      epochCredits: epochCredits,
    );
  }

  VoteAccounts fromJson(Map<String, Object> json) {
    return VoteAccounts.fromJson(json);
  }
}

/// @nodoc
const $VoteAccounts = _$VoteAccountsTearOff();

/// @nodoc
mixin _$VoteAccounts {
  String get votePubkey => throw _privateConstructorUsedError;
  String get nodePubkey => throw _privateConstructorUsedError;
  int get activatedStake => throw _privateConstructorUsedError;
  bool get epochVoteAccount => throw _privateConstructorUsedError;
  int get commission => throw _privateConstructorUsedError;
  int get lastVote => throw _privateConstructorUsedError;
  List<int> get epochCredits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoteAccountsCopyWith<VoteAccounts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteAccountsCopyWith<$Res> {
  factory $VoteAccountsCopyWith(
          VoteAccounts value, $Res Function(VoteAccounts) then) =
      _$VoteAccountsCopyWithImpl<$Res>;
  $Res call(
      {String votePubkey,
      String nodePubkey,
      int activatedStake,
      bool epochVoteAccount,
      int commission,
      int lastVote,
      List<int> epochCredits});
}

/// @nodoc
class _$VoteAccountsCopyWithImpl<$Res> implements $VoteAccountsCopyWith<$Res> {
  _$VoteAccountsCopyWithImpl(this._value, this._then);

  final VoteAccounts _value;
  // ignore: unused_field
  final $Res Function(VoteAccounts) _then;

  @override
  $Res call({
    Object? votePubkey = freezed,
    Object? nodePubkey = freezed,
    Object? activatedStake = freezed,
    Object? epochVoteAccount = freezed,
    Object? commission = freezed,
    Object? lastVote = freezed,
    Object? epochCredits = freezed,
  }) {
    return _then(_value.copyWith(
      votePubkey: votePubkey == freezed
          ? _value.votePubkey
          : votePubkey // ignore: cast_nullable_to_non_nullable
              as String,
      nodePubkey: nodePubkey == freezed
          ? _value.nodePubkey
          : nodePubkey // ignore: cast_nullable_to_non_nullable
              as String,
      activatedStake: activatedStake == freezed
          ? _value.activatedStake
          : activatedStake // ignore: cast_nullable_to_non_nullable
              as int,
      epochVoteAccount: epochVoteAccount == freezed
          ? _value.epochVoteAccount
          : epochVoteAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      lastVote: lastVote == freezed
          ? _value.lastVote
          : lastVote // ignore: cast_nullable_to_non_nullable
              as int,
      epochCredits: epochCredits == freezed
          ? _value.epochCredits
          : epochCredits // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$VoteAccountsCopyWith<$Res>
    implements $VoteAccountsCopyWith<$Res> {
  factory _$VoteAccountsCopyWith(
          _VoteAccounts value, $Res Function(_VoteAccounts) then) =
      __$VoteAccountsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String votePubkey,
      String nodePubkey,
      int activatedStake,
      bool epochVoteAccount,
      int commission,
      int lastVote,
      List<int> epochCredits});
}

/// @nodoc
class __$VoteAccountsCopyWithImpl<$Res> extends _$VoteAccountsCopyWithImpl<$Res>
    implements _$VoteAccountsCopyWith<$Res> {
  __$VoteAccountsCopyWithImpl(
      _VoteAccounts _value, $Res Function(_VoteAccounts) _then)
      : super(_value, (v) => _then(v as _VoteAccounts));

  @override
  _VoteAccounts get _value => super._value as _VoteAccounts;

  @override
  $Res call({
    Object? votePubkey = freezed,
    Object? nodePubkey = freezed,
    Object? activatedStake = freezed,
    Object? epochVoteAccount = freezed,
    Object? commission = freezed,
    Object? lastVote = freezed,
    Object? epochCredits = freezed,
  }) {
    return _then(_VoteAccounts(
      votePubkey: votePubkey == freezed
          ? _value.votePubkey
          : votePubkey // ignore: cast_nullable_to_non_nullable
              as String,
      nodePubkey: nodePubkey == freezed
          ? _value.nodePubkey
          : nodePubkey // ignore: cast_nullable_to_non_nullable
              as String,
      activatedStake: activatedStake == freezed
          ? _value.activatedStake
          : activatedStake // ignore: cast_nullable_to_non_nullable
              as int,
      epochVoteAccount: epochVoteAccount == freezed
          ? _value.epochVoteAccount
          : epochVoteAccount // ignore: cast_nullable_to_non_nullable
              as bool,
      commission: commission == freezed
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as int,
      lastVote: lastVote == freezed
          ? _value.lastVote
          : lastVote // ignore: cast_nullable_to_non_nullable
              as int,
      epochCredits: epochCredits == freezed
          ? _value.epochCredits
          : epochCredits // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VoteAccounts implements _VoteAccounts {
  const _$_VoteAccounts(
      {required this.votePubkey,
      required this.nodePubkey,
      required this.activatedStake,
      required this.epochVoteAccount,
      required this.commission,
      required this.lastVote,
      required this.epochCredits});

  factory _$_VoteAccounts.fromJson(Map<String, dynamic> json) =>
      _$$_VoteAccountsFromJson(json);

  @override
  final String votePubkey;
  @override
  final String nodePubkey;
  @override
  final int activatedStake;
  @override
  final bool epochVoteAccount;
  @override
  final int commission;
  @override
  final int lastVote;
  @override
  final List<int> epochCredits;

  @override
  String toString() {
    return 'VoteAccounts(votePubkey: $votePubkey, nodePubkey: $nodePubkey, activatedStake: $activatedStake, epochVoteAccount: $epochVoteAccount, commission: $commission, lastVote: $lastVote, epochCredits: $epochCredits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _VoteAccounts &&
            (identical(other.votePubkey, votePubkey) ||
                const DeepCollectionEquality()
                    .equals(other.votePubkey, votePubkey)) &&
            (identical(other.nodePubkey, nodePubkey) ||
                const DeepCollectionEquality()
                    .equals(other.nodePubkey, nodePubkey)) &&
            (identical(other.activatedStake, activatedStake) ||
                const DeepCollectionEquality()
                    .equals(other.activatedStake, activatedStake)) &&
            (identical(other.epochVoteAccount, epochVoteAccount) ||
                const DeepCollectionEquality()
                    .equals(other.epochVoteAccount, epochVoteAccount)) &&
            (identical(other.commission, commission) ||
                const DeepCollectionEquality()
                    .equals(other.commission, commission)) &&
            (identical(other.lastVote, lastVote) ||
                const DeepCollectionEquality()
                    .equals(other.lastVote, lastVote)) &&
            (identical(other.epochCredits, epochCredits) ||
                const DeepCollectionEquality()
                    .equals(other.epochCredits, epochCredits)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(votePubkey) ^
      const DeepCollectionEquality().hash(nodePubkey) ^
      const DeepCollectionEquality().hash(activatedStake) ^
      const DeepCollectionEquality().hash(epochVoteAccount) ^
      const DeepCollectionEquality().hash(commission) ^
      const DeepCollectionEquality().hash(lastVote) ^
      const DeepCollectionEquality().hash(epochCredits);

  @JsonKey(ignore: true)
  @override
  _$VoteAccountsCopyWith<_VoteAccounts> get copyWith =>
      __$VoteAccountsCopyWithImpl<_VoteAccounts>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoteAccountsToJson(this);
  }
}

abstract class _VoteAccounts implements VoteAccounts {
  const factory _VoteAccounts(
      {required String votePubkey,
      required String nodePubkey,
      required int activatedStake,
      required bool epochVoteAccount,
      required int commission,
      required int lastVote,
      required List<int> epochCredits}) = _$_VoteAccounts;

  factory _VoteAccounts.fromJson(Map<String, dynamic> json) =
      _$_VoteAccounts.fromJson;

  @override
  String get votePubkey => throw _privateConstructorUsedError;
  @override
  String get nodePubkey => throw _privateConstructorUsedError;
  @override
  int get activatedStake => throw _privateConstructorUsedError;
  @override
  bool get epochVoteAccount => throw _privateConstructorUsedError;
  @override
  int get commission => throw _privateConstructorUsedError;
  @override
  int get lastVote => throw _privateConstructorUsedError;
  @override
  List<int> get epochCredits => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VoteAccountsCopyWith<_VoteAccounts> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionStatus _$TransactionStatusFromJson(Map<String, dynamic> json) {
  return _TransactionStatus.fromJson(json);
}

/// @nodoc
class _$TransactionStatusTearOff {
  const _$TransactionStatusTearOff();

  _TransactionStatus call(
      {required Map<String, dynamic>? err,
      required List<String>? logs,
      required List<Account>? accounts}) {
    return _TransactionStatus(
      err: err,
      logs: logs,
      accounts: accounts,
    );
  }

  TransactionStatus fromJson(Map<String, Object> json) {
    return TransactionStatus.fromJson(json);
  }
}

/// @nodoc
const $TransactionStatus = _$TransactionStatusTearOff();

/// @nodoc
mixin _$TransactionStatus {
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  List<String>? get logs => throw _privateConstructorUsedError;
  List<Account>? get accounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionStatusCopyWith<TransactionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStatusCopyWith<$Res> {
  factory $TransactionStatusCopyWith(
          TransactionStatus value, $Res Function(TransactionStatus) then) =
      _$TransactionStatusCopyWithImpl<$Res>;
  $Res call(
      {Map<String, dynamic>? err, List<String>? logs, List<Account>? accounts});
}

/// @nodoc
class _$TransactionStatusCopyWithImpl<$Res>
    implements $TransactionStatusCopyWith<$Res> {
  _$TransactionStatusCopyWithImpl(this._value, this._then);

  final TransactionStatus _value;
  // ignore: unused_field
  final $Res Function(TransactionStatus) _then;

  @override
  $Res call({
    Object? err = freezed,
    Object? logs = freezed,
    Object? accounts = freezed,
  }) {
    return _then(_value.copyWith(
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      logs: logs == freezed
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>?,
    ));
  }
}

/// @nodoc
abstract class _$TransactionStatusCopyWith<$Res>
    implements $TransactionStatusCopyWith<$Res> {
  factory _$TransactionStatusCopyWith(
          _TransactionStatus value, $Res Function(_TransactionStatus) then) =
      __$TransactionStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, dynamic>? err, List<String>? logs, List<Account>? accounts});
}

/// @nodoc
class __$TransactionStatusCopyWithImpl<$Res>
    extends _$TransactionStatusCopyWithImpl<$Res>
    implements _$TransactionStatusCopyWith<$Res> {
  __$TransactionStatusCopyWithImpl(
      _TransactionStatus _value, $Res Function(_TransactionStatus) _then)
      : super(_value, (v) => _then(v as _TransactionStatus));

  @override
  _TransactionStatus get _value => super._value as _TransactionStatus;

  @override
  $Res call({
    Object? err = freezed,
    Object? logs = freezed,
    Object? accounts = freezed,
  }) {
    return _then(_TransactionStatus(
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      logs: logs == freezed
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionStatus implements _TransactionStatus {
  const _$_TransactionStatus(
      {required this.err, required this.logs, required this.accounts});

  factory _$_TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionStatusFromJson(json);

  @override
  final Map<String, dynamic>? err;
  @override
  final List<String>? logs;
  @override
  final List<Account>? accounts;

  @override
  String toString() {
    return 'TransactionStatus(err: $err, logs: $logs, accounts: $accounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransactionStatus &&
            (identical(other.err, err) ||
                const DeepCollectionEquality().equals(other.err, err)) &&
            (identical(other.logs, logs) ||
                const DeepCollectionEquality().equals(other.logs, logs)) &&
            (identical(other.accounts, accounts) ||
                const DeepCollectionEquality()
                    .equals(other.accounts, accounts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(err) ^
      const DeepCollectionEquality().hash(logs) ^
      const DeepCollectionEquality().hash(accounts);

  @JsonKey(ignore: true)
  @override
  _$TransactionStatusCopyWith<_TransactionStatus> get copyWith =>
      __$TransactionStatusCopyWithImpl<_TransactionStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionStatusToJson(this);
  }
}

abstract class _TransactionStatus implements TransactionStatus {
  const factory _TransactionStatus(
      {required Map<String, dynamic>? err,
      required List<String>? logs,
      required List<Account>? accounts}) = _$_TransactionStatus;

  factory _TransactionStatus.fromJson(Map<String, dynamic> json) =
      _$_TransactionStatus.fromJson;

  @override
  Map<String, dynamic>? get err => throw _privateConstructorUsedError;
  @override
  List<String>? get logs => throw _privateConstructorUsedError;
  @override
  List<Account>? get accounts => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionStatusCopyWith<_TransactionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
