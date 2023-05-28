import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_client/src/api.dart';
import 'package:solana_mobile_client/src/mobile_wallet_adapter_client.dart';

class LocalAssociationScenario {
  const LocalAssociationScenario._(this._instanceId);

  Future<MobileWalletAdapterClient> start() async {
    await api.start(_instanceId);

    return MobileWalletAdapterClient(_instanceId);
  }

  Future<void> close() async {
    await api.close(_instanceId);
  }

  Future<void> startActivityForResult(String? uriPrefix) async {
    await api.startActivityForResult(_instanceId, uriPrefix);
  }

  final int _instanceId;

  static int _id = 1;

  static Future<LocalAssociationScenario> create() async {
    final id = _id++;
    await api.create(id);

    return LocalAssociationScenario._(id);
  }
}

@internal
final api = ApiLocalAssociationScenario();
