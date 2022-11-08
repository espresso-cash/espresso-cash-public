import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import 'repository.dart';

part 'on_ramp_bloc.freezed.dart';

@injectable
class OnRampBloc extends Bloc<OnRampEvent, OnRampState> {
  OnRampBloc({
    @factoryParam required Token token,
    @factoryParam required Wallet wallet,
    required OnRampRepository repository,
  })  : _repository = repository,
        _wallet = wallet,
        _token = token,
        super(const OnRampState.initial()) {
    on<OnRampEvent>(_eventHandler, transformer: sequential());
  }

  final OnRampRepository _repository;
  final Wallet _wallet;
  final Token _token;

  EventHandler<OnRampEvent, OnRampState> get _eventHandler =>
      (event, emit) => event.map(
            ftxRequested: (_) => _onFtxRequested(emit),
            kadoRequested: (_) => _onKadoRequested(emit),
            moonpayRequested: (_) => _onMoonpayRequested(emit),
          );

  void _onFtxRequested(Emitter<OnRampState> emit) {
    emit(const OnRampState.initial());
    emit(const OnRampState.success(ftxAddCashSupportUrl));
  }

  void _onKadoRequested(Emitter<OnRampState> emit) {
    emit(const OnRampState.initial());

    final url = Uri.parse(kadoBaseUrl).addParams({
      'apiKey': kadoApiKey,
      'product': 'BUY',
      'network': 'SOLANA',
      'onPayCurrency': 'usd',
      'onRevCurrency': _token.symbol,
      'onToAddress': _wallet.address,
    });

    emit(OnRampState.success(url.toString()));
  }

  Future<void> _onMoonpayRequested(Emitter<OnRampState> emit) async {
    emit(const OnRampState.processing());
    try {
      final url = await _repository.signFundsRequest(
        address: _wallet.address,
        token: _token,
      );
      emit(OnRampState.success(url));
    } on Exception catch (e) {
      emit(OnRampState.failure(e));
    }
  }
}

@freezed
class OnRampEvent with _$OnRampEvent {
  const factory OnRampEvent.moonpayRequested() = _MoonpayRequested;

  const factory OnRampEvent.ftxRequested() = _FtxRequested;

  const factory OnRampEvent.kadoRequested() = _KadoRequested;
}

typedef OnRampState = Flow<Exception, String>;

extension on Uri {
  Uri addParams(Map<String, dynamic> params) => replace(
        queryParameters: {
          ...queryParameters,
          ...params,
        },
      );
}
