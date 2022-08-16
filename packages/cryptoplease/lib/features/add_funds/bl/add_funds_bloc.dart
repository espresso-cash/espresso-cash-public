import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/flow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_funds_bloc.freezed.dart';

typedef AddFundsRequestSigner = Future<String> Function(
  String address,
  Amount amount,
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
      final url = await _signRequest(
        event.walletAddress,
        event.amount,
      );
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
    required Amount amount,
  }) = AddFundsUrlRequested;
}

typedef AddFundsState = Flow<Exception, String>;
