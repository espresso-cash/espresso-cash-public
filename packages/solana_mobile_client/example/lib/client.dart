import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

part 'client.freezed.dart';

class ClientBloc extends Cubit<ClientState> {
  ClientBloc() : super(const ClientState());

  Future<void> requestCapabilities() async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    final result = await client.getCapabilities();
    await session.close();

    emit(state.copyWith(capabilities: result));
  }
}

@freezed
class ClientState with _$ClientState {
  const factory ClientState({
    GetCapabilitiesResult? capabilities,
  }) = _ClientState;
}
