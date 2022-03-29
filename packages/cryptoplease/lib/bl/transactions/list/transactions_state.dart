part of 'transactions_bloc.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default(IListConst<Transaction>([])) IList<Transaction> transactions,
    @Default(LoadingState.none()) LoadingState loadingState,
  }) = _TransactionsState;

  const TransactionsState._();
}

@freezed
class LoadingState with _$LoadingState {
  const LoadingState._();

  const factory LoadingState.none() = None;

  const factory LoadingState.inProgress() = InProgress;

  const factory LoadingState.loadingError(Exception e) = LoadingError;

  const factory LoadingState.success() = Success;
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction.generic({
    required Meta? meta,
    required DateTime? blockTime,
    required String hash,
  }) = GenericTransaction;

  const factory Transaction.transfer({
    required String hash,
    required String senderAddress,
    required String recipientAddress,
    required int amount,
    required DateTime? blockTime,
    Meta? meta,
    @Default('') String memo,
  }) = TransferTransaction;

  factory Transaction.fromSystemTransfer({
    required ParsedSystemTransferInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    Meta? meta,
    String? memo,
  }) {
    final transferTx = instruction.info;
    // TODO(IA): check fee payer before adding the fee
    final amount = transferTx.lamports;

    return Transaction.transfer(
      hash: hash,
      senderAddress: transferTx.source,
      recipientAddress: transferTx.destination,
      blockTime: blockTime,
      amount: amount,
      meta: meta,
      memo: memo ?? '',
    );
  }

  factory Transaction.fromSystemTransferChecked({
    required ParsedSystemTransferCheckedInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    Meta? meta,
    String? memo,
  }) {
    final transferTx = instruction.info;
    final amount = transferTx.lamports;

    return Transaction.transfer(
      hash: hash,
      senderAddress: transferTx.source,
      recipientAddress: transferTx.destination,
      blockTime: blockTime,
      amount: amount,
      meta: meta,
      memo: memo ?? '',
    );
  }

  factory Transaction.fromSplTokenTransfer({
    required ParsedSplTokenTransferInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    Meta? meta,
    String? memo,
  }) {
    final transferTx = instruction.info;
    // TODO(IA): check fee payer before adding the fee
    // FIXME(IA): will probably need to transform the amount at this point
    //            because it could overflow `int`
    final amount = int.parse(transferTx.amount);

    return Transaction.transfer(
      hash: hash,
      senderAddress: transferTx.source,
      recipientAddress: transferTx.destination,
      blockTime: blockTime,
      amount: amount,
      meta: meta,
      memo: memo ?? '',
    );
  }

  factory Transaction.fromSplTokenTransferChecked({
    required ParsedSplTokenTransferCheckedInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    Meta? meta,
    String? memo,
  }) {
    final transferTx = instruction.info;
    // TODO(IA): check fee payer before adding the fee
    // FIXME(IA): will probably need to transform the amount at this point
    //            because it could overflow `int`
    final amount = int.parse(transferTx.tokenAmount.amount);

    return Transaction.transfer(
      hash: hash,
      senderAddress: transferTx.source,
      recipientAddress: transferTx.destination,
      blockTime: blockTime,
      amount: amount,
      meta: meta,
      memo: memo ?? '',
    );
  }

  const Transaction._();
}
