import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

part 'transaction_details_bloc.freezed.dart';
part 'transaction_details_event.dart';
part 'transaction_details_state.dart';

typedef _Event = TransactionDetailsEvent;
typedef _State = TransactionDetailsState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class TransactionDetailsBloc extends Bloc<_Event, _State> {
  TransactionDetailsBloc(RpcClient client)
      : _rpcClient = client,
        super(const _State.loading()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final RpcClient _rpcClient;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        load: (event) => _onLoad(event, emit),
      );

  Future<void> _onLoad(LoadTransactionDetails event, _Emitter emit) async {
    final result = await _rpcClient
        .getTransaction(
          event.transactionHash,
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        )
        .toEither();
    final statuses = await _rpcClient.getSignatureStatuses(
      [event.transactionHash],
      searchTransactionHistory: true,
    );

    final newState = result.fold(
      (_) => const _State.error(TransactionDetailsError.unexpected),
      (result) {
        if (result == null) {
          return const _State.error(TransactionDetailsError.notFound);
        }

        final transaction = result.transaction;
        final message = transaction.message;
        final blockTime = result.blockTime;

        return _State.ready(
          instructions: message.instructions
              .whereType<ParsedInstruction>()
              .toList(growable: false),
          meta: result.meta,
          signature: event.transactionHash,
          dateTime: blockTime?.toDateTime(),
          status: _getTransactionStatus(statuses.first),
        );
      },
    );

    emit(newState);
  }

  TransactionStatus _getTransactionStatus(SignatureStatus? signatureStatus) {
    if (signatureStatus == null) {
      return TransactionStatus.failed;
    }

    switch (signatureStatus.confirmationStatus) {
      case Commitment.processed:
        return TransactionStatus.pending;
      case Commitment.confirmed:
      case Commitment.finalized:
        return TransactionStatus.confirmed;
    }
  }
}

extension on int {
  DateTime toDateTime() => DateTime.fromMillisecondsSinceEpoch(1000 * this);
}
