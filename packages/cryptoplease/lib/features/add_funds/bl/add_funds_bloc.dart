import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

part 'add_funds_bloc.freezed.dart';

@injectable
class AddFundsBloc extends Bloc<AddFundsEvent, AddFundsState> {
  AddFundsBloc({
    @factoryParam required Token token,
    @factoryParam required Wallet wallet,
    required AddFundsRepository repository,
  })  : _repository = repository,
        _wallet = wallet,
        _token = token,
        super(const AddFundsState.initial()) {
    on<AddFundsEvent>(_eventHandler, transformer: sequential());
  }

  final AddFundsRepository _repository;
  final Wallet _wallet;
  final Token _token;

  EventHandler<AddFundsEvent, AddFundsState> get _eventHandler =>
      (event, emit) => event.map(
            ftxRequested: (_) => _onFtxRequested(emit),
            kadoRequested: (_) => _onKadoRequested(emit),
            moonpayRequested: (_) => _onMoonpayRequested(emit),
          );

  void _onFtxRequested(Emitter<AddFundsState> emit) {
    emit(const AddFundsState.initial());
    emit(const AddFundsState.success(ftxAddCashSupportUrl));
  }

  void _onKadoRequested(Emitter<AddFundsState> emit) {
    emit(const AddFundsState.initial());

    final url = Uri.parse(kadoBaseUrl).addParams({
      'apiKey': kadoApiKey,
      'product': 'BUY',
      'network': 'SOLANA',
      'onPayCurrency': 'usd',
      'onRevCurrency': _token.symbol,
      'onToAddress': _wallet.address,
    });

    emit(AddFundsState.success(url.toString()));
  }

  Future<void> _onMoonpayRequested(Emitter<AddFundsState> emit) async {
    emit(const AddFundsState.processing());
    try {
      final url = await _repository.signFundsRequest(
        address: _wallet.address,
        token: _token,
      );
      emit(AddFundsState.success(url));
    } on Exception catch (e) {
      emit(AddFundsState.failure(e));
    }
  }
}

@freezed
class AddFundsEvent with _$AddFundsEvent {
  const factory AddFundsEvent.moonpayRequested() = _MoonpayRequested;

  const factory AddFundsEvent.ftxRequested() = _FtxRequested;

  const factory AddFundsEvent.kadoRequested() = _KadoRequested;
}

typedef AddFundsState = Flow<Exception, String>;

extension on Uri {
  Uri addParams(Map<String, dynamic> params) => replace(
        queryParameters: {
          ...queryParameters,
          ...params,
        },
      );
}
