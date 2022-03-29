part of 'transaction_details_bloc.dart';

enum TransactionDetailsError { notFound, badTransaction, unexpected }

enum TransactionStatus { confirmed, failed, pending }

@freezed
class TransactionDetailsState with _$TransactionDetailsState {
  const factory TransactionDetailsState.loading() = TransactionDetailsLoading;

  const factory TransactionDetailsState.error(TransactionDetailsError error) =
      TransactionDetailsErrored;

  const factory TransactionDetailsState.ready({
    required List<ParsedInstruction> instructions,
    required Meta? meta,
    required DateTime? dateTime,
    required String signature,
    required TransactionStatus status,
  }) = TransactionDetailsReady;
}
