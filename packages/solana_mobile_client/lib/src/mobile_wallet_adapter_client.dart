import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_client/src/local_association_scenario.dart';

part 'mobile_wallet_adapter_client.freezed.dart';

class MobileWalletAdapterClient {
  MobileWalletAdapterClient(this._scenarioId);

  final int _scenarioId;

  Future<GetCapabilitiesResult> getCapabilities() async {
    final result = await api.getCapabilities(_scenarioId);

    return GetCapabilitiesResult(
      supportsCloneAuthorization: result.supportsCloneAuthorization,
      supportsSignAndSendTransactions: result.supportsSignAndSendTransactions,
      maxTransactionsPerSigningRequest: result.maxTransactionsPerSigningRequest,
      maxMessagesPerSigningRequest: result.maxMessagesPerSigningRequest,
    );
  }
}

@freezed
class GetCapabilitiesResult with _$GetCapabilitiesResult {
  const factory GetCapabilitiesResult({
    required bool supportsCloneAuthorization,
    required bool supportsSignAndSendTransactions,
    required int maxTransactionsPerSigningRequest,
    required int maxMessagesPerSigningRequest,
  }) = _GetCapabilitiesResult;
}
