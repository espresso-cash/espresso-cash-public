part of 'bloc.dart';

@freezed
class OutgoingTransfersState with _$OutgoingTransfersState {
  const factory OutgoingTransfersState({
    @Default(IListConst<OutgoingTransferId>([]))
        IList<OutgoingTransferId> processingIds,
    @Default(IMapConst<OutgoingTransferId, Exception>({}))
        IMap<OutgoingTransferId, Exception> errors,
  }) = _OutgoingPaymentsState;
}
