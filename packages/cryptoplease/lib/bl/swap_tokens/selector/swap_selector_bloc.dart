import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'swap_selector_bloc.freezed.dart';
part 'swap_selector_event.dart';
part 'swap_selector_state.dart';

typedef _Event = SwapSelectorEvent;
typedef _State = SwapSelectorState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SwapSelectorBloc extends Bloc<_Event, _State> {
  SwapSelectorBloc({
    required TokenList tokenList,
    required JupiterAggregatorClient jupiterAggregatorClient,
    required Map<Token, Amount> balances,
  })  : _tokenList = tokenList,
        _jupiterClient = jupiterAggregatorClient,
        _balances = balances,
        super(
          SwapSelectorState(
            amount: Amount.zero(currency: Currency.sol),
            slippage: Decimal.one,
          ),
        ) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final Map<Token, Amount> _balances;

  late JupiterIndexedRouteMap _routeMap;
  late Iterable<Token?> _jupiterTokens;
  late Map<String, int> _mintToIndex;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        initialized: (e) => _onInitialized(e, emit),
        inputSelected: (e) => _onInputSelected(e, emit),
        outputSelected: (e) => _onOutputSelected(e, emit),
        amountUpdated: (e) => _onAmountUpdated(e, emit),
        slippageUpdated: (e) => _onSlippageUpdated(e, emit),
      );

  Future<void> _onInitialized(
    SwapSelectorLoadEvent _,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(processingState: const ProcessingState.processing()),
    );
    try {
      _routeMap = await _jupiterClient.getIndexedRouteMap();
      _jupiterTokens = _routeMap.mintKeys.map(_tokenList.findTokenByMint);
      _mintToIndex = _routeMap.mintKeys.asMap().map((k, v) => MapEntry(v, k));
      final inputTokens = _jupiterTokens.whereNotNull();

      emit(
        state.copyWith(
          inputTokens: inputTokens,
          processingState: const ProcessingState.none(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          processingState: ProcessingState.error(e),
        ),
      );
    }
  }

  Future<void> _onInputSelected(
    SwapSelectorInputEvent inputEvent,
    _Emitter emit,
  ) async {
    final mint = inputEvent.inputToken.address;
    final index = _mintToIndex[mint].toString();
    final outputIndexes = _routeMap.indexedRouteMap[index]!;
    final outputTokens = outputIndexes
        .map((index) => _jupiterTokens.elementAt(index))
        .whereNotNull();

    emit(
      state.copyWith(
        outputTokens: outputTokens,
        selectedInput: inputEvent.inputToken,
        amount: Amount.crypto(
          value: state.amount.value,
          currency: CryptoCurrency(token: inputEvent.inputToken),
        ),
        selectedOutput: null,
      ),
    );
  }

  void _onOutputSelected(
    SwapSelectorOutputEvent outputEvent,
    _Emitter emit,
  ) {
    emit(
      state.copyWith(
        selectedOutput: outputEvent.outputToken,
      ),
    );
  }

  void _onSlippageUpdated(
    SwapSelectorSlippageEvent slippageEvent,
    _Emitter emit,
  ) {
    emit(
      state.copyWith(
        slippage: slippageEvent.slippage,
      ),
    );
  }

  void _onAmountUpdated(
    SwapSelectorAmountEvent amountEvent,
    _Emitter emit,
  ) {
    final tokenValue = state.amount.currency.decimalToInt(amountEvent.decimal);
    final tokenAmount = state.amount.copyWith(value: tokenValue);

    emit(
      state.copyWith(
        amount: tokenAmount,
      ),
    );
  }

  Either<ValidationError, void> validate() {
    final token = state.selectedInput;
    if (token == null) return const Either.right(null);

    final userBalance = _balances[token] ??
        Amount.zero(currency: Currency.crypto(token: token));

    if (userBalance < state.amount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.amount,
        ),
      );
    }

    // TODO(rhbrunetto): calculate fee?

    // var feeBalance =
    //     _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);
    // if (token == Token.sol) {
    //   feeBalance -= state.amount;
    // }

    // if (feeBalance < state.fee) {
    //   return Either.left(ValidationError.insufficientFee(state.fee));
    // }

    return const Either.right(null);
  }
}
