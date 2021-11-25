// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_spl_token_program_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedSplTokenProgramAccountData _$ParsedSplTokenProgramAccountDataFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'account':
      return TokenAccountData.fromJson(json);
    case 'mint':
      return MintAccountData.fromJson(json);

    default:
      return UnknownAccountData.fromJson(json);
  }
}

/// @nodoc
class _$ParsedSplTokenProgramAccountDataTearOff {
  const _$ParsedSplTokenProgramAccountDataTearOff();

  TokenAccountData account(
      {required ParsedSplTokenAccountDataInfo info,
      required String type,
      String? accountType}) {
    return TokenAccountData(
      info: info,
      type: type,
      accountType: accountType,
    );
  }

  MintAccountData mint(
      {required ParsedSplMintAccountDataInfo info,
      required String type,
      String? accountType}) {
    return MintAccountData(
      info: info,
      type: type,
      accountType: accountType,
    );
  }

  UnknownAccountData unknown({required String type}) {
    return UnknownAccountData(
      type: type,
    );
  }

  ParsedSplTokenProgramAccountData fromJson(Map<String, Object> json) {
    return ParsedSplTokenProgramAccountData.fromJson(json);
  }
}

/// @nodoc
const $ParsedSplTokenProgramAccountData =
    _$ParsedSplTokenProgramAccountDataTearOff();

/// @nodoc
mixin _$ParsedSplTokenProgramAccountData {
  String get type => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)
        account,
    required TResult Function(
            ParsedSplMintAccountDataInfo info, String type, String? accountType)
        mint,
    required TResult Function(String type) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenAccountData value) account,
    required TResult Function(MintAccountData value) mint,
    required TResult Function(UnknownAccountData value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedSplTokenProgramAccountDataCopyWith<ParsedSplTokenProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  factory $ParsedSplTokenProgramAccountDataCopyWith(
          ParsedSplTokenProgramAccountData value,
          $Res Function(ParsedSplTokenProgramAccountData) then) =
      _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>;
  $Res call({String type});
}

/// @nodoc
class _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  _$ParsedSplTokenProgramAccountDataCopyWithImpl(this._value, this._then);

  final ParsedSplTokenProgramAccountData _value;
  // ignore: unused_field
  final $Res Function(ParsedSplTokenProgramAccountData) _then;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $TokenAccountDataCopyWith<$Res>
    implements $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  factory $TokenAccountDataCopyWith(
          TokenAccountData value, $Res Function(TokenAccountData) then) =
      _$TokenAccountDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {ParsedSplTokenAccountDataInfo info, String type, String? accountType});
}

/// @nodoc
class _$TokenAccountDataCopyWithImpl<$Res>
    extends _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $TokenAccountDataCopyWith<$Res> {
  _$TokenAccountDataCopyWithImpl(
      TokenAccountData _value, $Res Function(TokenAccountData) _then)
      : super(_value, (v) => _then(v as TokenAccountData));

  @override
  TokenAccountData get _value => super._value as TokenAccountData;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
    Object? accountType = freezed,
  }) {
    return _then(TokenAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenAccountDataInfo,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountType: accountType == freezed
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenAccountData implements TokenAccountData {
  const _$TokenAccountData(
      {required this.info, required this.type, this.accountType});

  factory _$TokenAccountData.fromJson(Map<String, dynamic> json) =>
      _$$TokenAccountDataFromJson(json);

  @override
  final ParsedSplTokenAccountDataInfo info;
  @override
  final String type;
  @override
  final String? accountType;

  @override
  String toString() {
    return 'ParsedSplTokenProgramAccountData.account(info: $info, type: $type, accountType: $accountType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(accountType);

  @JsonKey(ignore: true)
  @override
  $TokenAccountDataCopyWith<TokenAccountData> get copyWith =>
      _$TokenAccountDataCopyWithImpl<TokenAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)
        account,
    required TResult Function(
            ParsedSplMintAccountDataInfo info, String type, String? accountType)
        mint,
    required TResult Function(String type) unknown,
  }) {
    return account(info, type, accountType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
  }) {
    return account?.call(info, type, accountType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
    required TResult orElse(),
  }) {
    if (account != null) {
      return account(info, type, accountType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenAccountData value) account,
    required TResult Function(MintAccountData value) mint,
    required TResult Function(UnknownAccountData value) unknown,
  }) {
    return account(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
  }) {
    return account?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (account != null) {
      return account(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenAccountDataToJson(this)..['type'] = 'account';
  }
}

abstract class TokenAccountData implements ParsedSplTokenProgramAccountData {
  const factory TokenAccountData(
      {required ParsedSplTokenAccountDataInfo info,
      required String type,
      String? accountType}) = _$TokenAccountData;

  factory TokenAccountData.fromJson(Map<String, dynamic> json) =
      _$TokenAccountData.fromJson;

  ParsedSplTokenAccountDataInfo get info => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  String? get accountType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $TokenAccountDataCopyWith<TokenAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MintAccountDataCopyWith<$Res>
    implements $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  factory $MintAccountDataCopyWith(
          MintAccountData value, $Res Function(MintAccountData) then) =
      _$MintAccountDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {ParsedSplMintAccountDataInfo info, String type, String? accountType});
}

/// @nodoc
class _$MintAccountDataCopyWithImpl<$Res>
    extends _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $MintAccountDataCopyWith<$Res> {
  _$MintAccountDataCopyWithImpl(
      MintAccountData _value, $Res Function(MintAccountData) _then)
      : super(_value, (v) => _then(v as MintAccountData));

  @override
  MintAccountData get _value => super._value as MintAccountData;

  @override
  $Res call({
    Object? info = freezed,
    Object? type = freezed,
    Object? accountType = freezed,
  }) {
    return _then(MintAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as ParsedSplMintAccountDataInfo,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountType: accountType == freezed
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MintAccountData implements MintAccountData {
  const _$MintAccountData(
      {required this.info, required this.type, this.accountType});

  factory _$MintAccountData.fromJson(Map<String, dynamic> json) =>
      _$$MintAccountDataFromJson(json);

  @override
  final ParsedSplMintAccountDataInfo info;
  @override
  final String type;
  @override
  final String? accountType;

  @override
  String toString() {
    return 'ParsedSplTokenProgramAccountData.mint(info: $info, type: $type, accountType: $accountType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MintAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(accountType);

  @JsonKey(ignore: true)
  @override
  $MintAccountDataCopyWith<MintAccountData> get copyWith =>
      _$MintAccountDataCopyWithImpl<MintAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)
        account,
    required TResult Function(
            ParsedSplMintAccountDataInfo info, String type, String? accountType)
        mint,
    required TResult Function(String type) unknown,
  }) {
    return mint(info, type, accountType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
  }) {
    return mint?.call(info, type, accountType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
    required TResult orElse(),
  }) {
    if (mint != null) {
      return mint(info, type, accountType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenAccountData value) account,
    required TResult Function(MintAccountData value) mint,
    required TResult Function(UnknownAccountData value) unknown,
  }) {
    return mint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
  }) {
    return mint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (mint != null) {
      return mint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MintAccountDataToJson(this)..['type'] = 'mint';
  }
}

abstract class MintAccountData implements ParsedSplTokenProgramAccountData {
  const factory MintAccountData(
      {required ParsedSplMintAccountDataInfo info,
      required String type,
      String? accountType}) = _$MintAccountData;

  factory MintAccountData.fromJson(Map<String, dynamic> json) =
      _$MintAccountData.fromJson;

  ParsedSplMintAccountDataInfo get info => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  String? get accountType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MintAccountDataCopyWith<MintAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnknownAccountDataCopyWith<$Res>
    implements $ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  factory $UnknownAccountDataCopyWith(
          UnknownAccountData value, $Res Function(UnknownAccountData) then) =
      _$UnknownAccountDataCopyWithImpl<$Res>;
  @override
  $Res call({String type});
}

/// @nodoc
class _$UnknownAccountDataCopyWithImpl<$Res>
    extends _$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    implements $UnknownAccountDataCopyWith<$Res> {
  _$UnknownAccountDataCopyWithImpl(
      UnknownAccountData _value, $Res Function(UnknownAccountData) _then)
      : super(_value, (v) => _then(v as UnknownAccountData));

  @override
  UnknownAccountData get _value => super._value as UnknownAccountData;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(UnknownAccountData(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnknownAccountData implements UnknownAccountData {
  const _$UnknownAccountData({required this.type});

  factory _$UnknownAccountData.fromJson(Map<String, dynamic> json) =>
      _$$UnknownAccountDataFromJson(json);

  @override
  final String type;

  @override
  String toString() {
    return 'ParsedSplTokenProgramAccountData.unknown(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UnknownAccountData &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  $UnknownAccountDataCopyWith<UnknownAccountData> get copyWith =>
      _$UnknownAccountDataCopyWithImpl<UnknownAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)
        account,
    required TResult Function(
            ParsedSplMintAccountDataInfo info, String type, String? accountType)
        mint,
    required TResult Function(String type) unknown,
  }) {
    return unknown(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
  }) {
    return unknown?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountDataInfo info, String type,
            String? accountType)?
        account,
    TResult Function(ParsedSplMintAccountDataInfo info, String type,
            String? accountType)?
        mint,
    TResult Function(String type)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenAccountData value) account,
    required TResult Function(MintAccountData value) mint,
    required TResult Function(UnknownAccountData value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenAccountData value)? account,
    TResult Function(MintAccountData value)? mint,
    TResult Function(UnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownAccountDataToJson(this)..['type'] = 'unknown';
  }
}

abstract class UnknownAccountData implements ParsedSplTokenProgramAccountData {
  const factory UnknownAccountData({required String type}) =
      _$UnknownAccountData;

  factory UnknownAccountData.fromJson(Map<String, dynamic> json) =
      _$UnknownAccountData.fromJson;

  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $UnknownAccountDataCopyWith<UnknownAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}
