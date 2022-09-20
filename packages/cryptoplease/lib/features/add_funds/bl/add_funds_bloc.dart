import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_quote.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'add_funds_bloc.freezed.dart';
part 'add_funds_event.dart';
part 'add_funds_state.dart';

class AddFundsBloc extends Bloc<AddFundsEvent, AddFundsState> {
  AddFundsBloc({
    required AddFundsRepository repository,
  })  : _repository = repository,
        super(
          const AddFundsState.initialized(
            inputAmount: FiatAmount(value: 0, currency: Currency.usd),
          ),
        ) {
    on<AddFundsEvent>(
      _eventHandler,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
  }

  final AddFundsRepository _repository;

  EventHandler<AddFundsEvent, AddFundsState> get _eventHandler =>
      (event, emit) => event.map(
            outputInvalidated: (_) => _onOutputInvalidated(emit),
            amountUpdated: (event) => _onAmountUpdated(event, emit),
            urlRequested: (event) => _onUrlRequested(event, emit),
          );

  Future<void> _onOutputInvalidated(Emitter<AddFundsState> emit) async =>
      state.mapOrNull(
        initialized: (state) async {
          emit(state.toProcessing());

          try {
            final quote = await _repository.buyQuote(
              Token.usdc,
              state.inputAmount,
            );

            emit(state.ready(quote));
          } on Exception catch (_) {
            emit(const AddFundsState.failure());
          }
        },
      );

  Future<void> _onAmountUpdated(
    _AmountUpdated event,
    Emitter<AddFundsState> emit,
  ) async {
    final newState = state.maybeMap(
      initialized: (state) => state.copyWith(
        inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
      ),
      orElse: () => AddFundsState.initialized(
        inputAmount: FiatAmount(
          currency: Currency.usd,
          value: Currency.usd.decimalToInt(event.decimal),
        ),
      ),
    );

    emit(newState);

    add(const AddFundsEvent.outputInvalidated());
  }

  Future<void> _onUrlRequested(
    _UrlRequested event,
    Emitter<AddFundsState> emit,
  ) async {
    final amount = state.mapOrNull(
      initialized: (state) => state.inputAmount,
    );

    if (amount == null) return;

    emit(const AddFundsState.loading());
    try {
      final url = await _repository.signFundsRequest(
        event.walletAddress,
        amount,
      );
      emit(AddFundsState.success(url));
    } on Exception catch (_) {
      emit(const AddFundsState.failure());
    }
  }
}

extension on _Initialized {
  _Initialized toProcessing() => copyWith(
        quote: null,
        processingState: const ProcessingState.processing(),
      );

  _Initialized ready(AddFundsQuote quote) => copyWith(
        quote: quote,
        processingState: const ProcessingState.none(),
      );
}
