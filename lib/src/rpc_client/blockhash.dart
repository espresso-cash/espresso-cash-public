part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class Blockhash {
  Blockhash({
    required this.feeCalculator,
    required this.blockhash,
  });

  factory Blockhash.fromJson(Map<String, dynamic> json) =>
      _$BlockhashFromJson(json);

  final FeeCalculator feeCalculator;
  final String blockhash;
}

@JsonSerializable(createToJson: false)
class BlockhashResponse extends JsonRpcResponse<ValueResponse<Blockhash>> {
  BlockhashResponse(ValueResponse<Blockhash> result) : super(result: result);

  factory BlockhashResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockhashResponseFromJson(json);
}
