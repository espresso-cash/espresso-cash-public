import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../models/remote_request.dart';

part 'bloc.freezed.dart';

@freezed
class MobileWalletEvent with _$MobileWalletEvent {
  const factory MobileWalletEvent.accepted() = _Authorize;
  const factory MobileWalletEvent.declined() = _Decline;
}

@freezed
class MobileWalletState with _$MobileWalletState {
  const factory MobileWalletState.requested(RemoteRequest request) = _Requested;
  const factory MobileWalletState.result(Object? result) = _Result;
}

@injectable
class MobileWalletBloc extends Bloc<MobileWalletEvent, MobileWalletState> {
  MobileWalletBloc(
    this._client, {
    @factoryParam required RemoteRequest request,
  }) : super(MobileWalletState.requested(request));

  final SolanaClient _client;
}
