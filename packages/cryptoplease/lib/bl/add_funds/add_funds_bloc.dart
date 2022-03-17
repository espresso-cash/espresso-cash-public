import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_funds_bloc.freezed.dart';

typedef AddFundsRequestSigner = Future<String> Function(
  String address,
  Decimal value,
);

class AddFundsBloc extends Bloc<AddFundsEvent, AddFundsState> {
  AddFundsBloc({
    required AddFundsRequestSigner signRequest,
  })  : _signRequest = signRequest,
        super(const AddFundsState.initial()) {
    on<AddFundsEvent>(_eventHandler, transformer: sequential());
  }

  final AddFundsRequestSigner _signRequest;

  EventHandler<AddFundsEvent, AddFundsState> get _eventHandler =>
      (event, emit) => event.map(
            urlRequested: (event) => _onUrlRequested(event, emit),
          );

  Future<void> _onUrlRequested(
    AddFundsUrlRequested event,
    Emitter<AddFundsState> emit,
  ) async {
    emit(const AddFundsState.processing());
    try {
      final url = await _signRequest(event.walletAddress, event.value);
      emit(AddFundsState.success(url));
    } on Exception catch (e) {
      emit(AddFundsState.failure(e));
    }
  }
}

@freezed
class AddFundsEvent with _$AddFundsEvent {
  const factory AddFundsEvent.urlRequested({
    required String walletAddress,
    required Decimal value,
  }) = AddFundsUrlRequested;
}

typedef AddFundsState = Flow<Exception, String>;
