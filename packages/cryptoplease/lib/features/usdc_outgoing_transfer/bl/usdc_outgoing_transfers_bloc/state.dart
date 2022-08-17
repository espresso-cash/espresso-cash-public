part of 'bloc.dart';

@freezed
class UsdcOutgoingTransfersState with _$UsdcOutgoingTransfersState {
  const factory UsdcOutgoingTransfersState({
    @Default(IListConst<OutgoingTransferId>([]))
        IList<OutgoingTransferId> processingIds,
    @Default(IMapConst<OutgoingTransferId, Exception>({}))
        IMap<OutgoingTransferId, Exception> errors,
  }) = _UsdcOutgoingTransfersState;
}
