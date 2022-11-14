import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/flow.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../outgoing_split_key_payments/module.dart';
import '../pending_activity.dart';

part 'oskp_cancel_bloc.freezed.dart';

@freezed
class OSKPCancelException with _$OSKPCancelException implements Exception {
  const factory OSKPCancelException.nonCancelable() = _NonCancelable;
  const factory OSKPCancelException.generic(Exception e) = _Generic;
}

typedef OSKPCancelState = Flow<OSKPCancelException, void>;

@freezed
class OSKPCancelEvent with _$OSKPCancelEvent {
  const factory OSKPCancelEvent.cancelRequested(OSKPPendingActivity activity) =
      _OSKPCancelEvent;
}

typedef _Event = OSKPCancelEvent;
typedef _State = OSKPCancelState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class OSKPCancelBloc extends Bloc<_Event, _State> {
  OSKPCancelBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
  })  : _account = account,
        _client = client,
        super(const OSKPCancelState.initial()) {
    on<_Event>(_handler);
  }

  final Ed25519HDKeyPair _account;
  final CryptopleaseClient _client;

  _EventHandler get _handler => (event, emit) => event.map(
        cancelRequested: (e) => _onCancelRequested(e, emit),
      );

  Future<void> _onCancelRequested(
    _OSKPCancelEvent event,
    _Emitter emit,
  ) async {
    try {
      emit(const OSKPCancelState.processing());

      final payment = event.activity.data;
      final escrow = payment.escrow;

      if (escrow == null) throw const OSKPCancelException.nonCancelable();

      final dto = CreatePaymentRequestDto(
        senderAccount: _account.address,
        escrowAccount: escrow.address,
        amount: payment.amount.value,
        cluster: apiCluster,
      );

      final tx = await _client
          .createPayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(_account));
    } on OSKPCancelException catch (e) {
      emit(OSKPCancelState.failure(e));
    } on Exception catch (e) {
      emit(OSKPCancelState.failure(OSKPCancelException.generic(e)));
    }
  }
}

extension OSKPCancelExt on OutgoingSplitKeyPayment {
  bool isCancelable() => escrow != null;

  Ed25519HDKeyPair? get escrow => status.map(
        txCreated: (tx) => tx.escrow,
        linksReady: (tx) => tx.escrow,
        txSendFailure: (tx) => tx.escrow,
        txWaitFailure: (tx) => tx.escrow,
        txLinksFailure: (tx) => tx.escrow,
        txSent: (_) => null,
        txConfirmed: (_) => null,
        txFailure: (_) => null,
        success: (_) => null,
      );
}
