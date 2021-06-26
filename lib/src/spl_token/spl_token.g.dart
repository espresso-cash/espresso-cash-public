// GENERATED CODE - DO NOT MODIFY BY HAND

part of spl_token;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociatedTokenAccount _$AssociatedTokenAccountFromJson(
    Map<String, dynamic> json) {
  return AssociatedTokenAccount(
    address: json['pubkey'] as String,
    account: Account.fromJson(json['account'] as Map<String, dynamic>),
  );
}

AssociatedTokenAccountResponse _$AssociatedTokenAccountResponseFromJson(
    Map<String, dynamic> json) {
  return AssociatedTokenAccountResponse(
    ValueResponse.fromJson(
        json['result'] as Map<String, dynamic>,
        (value) => (value as List<dynamic>)
            .map((e) =>
                AssociatedTokenAccount.fromJson(e as Map<String, dynamic>))
            .toList()),
  );
}

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) {
  return TokenAmount(
    decimals: json['decimals'] as int,
    amount: json['amount'] as String,
    uiAmountString: json['uiAmountString'] as String,
  );
}

TokenBalanceResponse _$TokenBalanceResponseFromJson(Map<String, dynamic> json) {
  return TokenBalanceResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => TokenAmount.fromJson(value as Map<String, dynamic>)),
  );
}

TokenSupply _$TokenSupplyFromJson(Map<String, dynamic> json) {
  return TokenSupply(
    amount: json['amount'] as String,
    decimals: json['decimals'] as int,
  );
}

TokenSupplyResult _$TokenSupplyResultFromJson(Map<String, dynamic> json) {
  return TokenSupplyResult(
    context: json['context'],
    value: TokenSupply.fromJson(json['value'] as Map<String, dynamic>),
  );
}

GetTokenSupplyResponse _$GetTokenSupplyResponseFromJson(
    Map<String, dynamic> json) {
  return GetTokenSupplyResponse(
    TokenSupplyResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}
