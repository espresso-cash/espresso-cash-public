import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator_strategy.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = OutgoingTransferStatusEvent;
typedef _State = OutgoingTransferStatusState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;
typedef TxTransformer = Transaction? Function(TransactionDetails);

class OutgoingTransferStatusBloc extends Bloc<_Event, _State> {
  OutgoingTransferStatusBloc({
    required RpcClient client,
    required SubscriptionClient subscriptionClient,
    required MyAccount account,
    required TxProcessor txProcessor,
    required TxCreatorStrategy txCreatorStrategy,
    required OutgoingTransferRepository repository,
    required this.transfer,
  })  : _rpcClient = client,
        _subscriptionClient = subscriptionClient,
        _account = account,
        _txProcessor = txProcessor,
        _txCreatorStrategy = txCreatorStrategy,
        _repository = repository,
        super(const _State(processingState: ProcessingState.none())) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final OutgoingTransferSplitKey transfer;

  final RpcClient _rpcClient;
  final SubscriptionClient _subscriptionClient;

  final MyAccount _account;

  final TxProcessor _txProcessor;
  final TxCreatorStrategy _txCreatorStrategy;

  final OutgoingTransferRepository _repository;

  StreamSubscription<Account>? _escrowSubscription;

  @override
  Future<void> close() async {
    await _escrowSubscription?.cancel();
    await super.close();
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        init: (event) => _onInit(event, emit),
        updated: (event) => _onLoad(event, emit),
        cancelled: (event) => _onCancel(event, emit),
      );

  Future<Iterable<Transaction>> _loadTransactions({
    required Ed25519HDPublicKey address,
    required TxTransformer transform,
  }) async {
    final transactions = await _rpcClient.getTransactionsList(
      address,
      limit: 2,
      commitment: Commitment.confirmed,
    );

    return transactions.map(transform).compact();
  }

  Future<Iterable<Transaction>> _fetchTransactions() async {
    final recipient = await transfer.getRecipient();
    final currency = transfer.toAmount().currency;

    final Iterable<Transaction> loadedTransactions;

    if (currency.token == Token.sol) {
      loadedTransactions = await _loadTransactions(
        address: recipient,
        transform: _solTxTransformer,
      );
    } else {
      loadedTransactions = await _loadTransactions(
        address: recipient,
        transform: _splTxTransformer,
      );
    }

    return loadedTransactions.sorted((t1, t2) {
      final blockTime1 = t1.blockTime;
      final blockTime2 = t2.blockTime;
      if (blockTime1 == null && blockTime2 == null) {
        return 0;
      } else if (blockTime1 != null && blockTime2 != null) {
        return blockTime2.millisecondsSinceEpoch -
            blockTime1.millisecondsSinceEpoch;
      } else {
        return blockTime1 == null ? -1 : 1;
      }
    }).toIList();
  }

  Future<void> _cancel() async {
    final keys = splitKey(transfer.privateKey);

    final txCreator = _txCreatorStrategy.fromApiVersion(transfer.apiVersion);

    await txCreator
        .createIncomingTx(
          firstPart: keys.first,
          secondPart: keys.last,
          recipient: _account.address,
          tokenAddress: transfer.tokenAddress,
        )
        .foldAsync(
          (e) => {},
          (tx) => _txProcessor.sendPayment(tx).flatMapAsync(_txProcessor.wait),
        );
  }

  Future<void> _updateStatus(_Emitter emit) async {
    final recipient = await transfer.getRecipient();
    final currency = transfer.toAmount().currency;

    final lamports = await _rpcClient.getBalance(
      recipient.toBase58(),
      commitment: Commitment.confirmed,
    );

    final amount = Amount.crypto(
      value: lamports,
      currency: currency,
    );

    final hasBalance = amount.value != 0;

    final transactions = await _fetchTransactions();

    if (!hasBalance && transactions.length == 2) {
      final transaction = transactions.first as TransferTransaction;

      final status = OutgoingTransferStatus(
        status: transaction.recipientAddress == _account.address
            ? OutgoingStatus.canceled
            : OutgoingStatus.success,
        created: transaction.blockTime,
      );

      await _repository.save(transfer.copyWith(transferStatus: status));

      await _escrowSubscription?.cancel();

      emit(
        state.copyWith(
          transferStatus: status,
          processingState: const ProcessingState.none(),
        ),
      );

      return;
    }

    emit(state.copyWith(processingState: const ProcessingState.none()));
  }

  Future<void> _onInit(_, _Emitter emit) async {
    if (transfer.transferStatus != null) {
      emit(
        state.copyWith(
          processingState: const ProcessingState.none(),
          transferStatus: transfer.transferStatus,
        ),
      );

      return;
    }

    emit(state.copyWith(processingState: const ProcessingState.processing()));

    await _updateStatus(emit);

    final recipient = await transfer.getRecipient();

    _escrowSubscription = _subscriptionClient
        .accountSubscribe(
          recipient.toBase58(),
          commitment: Commitment.confirmed,
        )
        .listen(_onListen);
  }

  Future<void> _onLoad(_, _Emitter emit) async {
    await _updateStatus(emit);
  }

  Future<void> _onCancel(_, _Emitter emit) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));
    await _cancel();
    add(const OutgoingTransferStatusEvent.updated());
  }

  void _onListen(_) {
    add(const OutgoingTransferStatusEvent.updated());
  }
}

Transaction _solTxTransformer(TransactionDetails response) {
  final transaction = response.transaction as ParsedTransaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSystem>()
      .firstWhereOrNull(
        (ParsedInstructionSystem tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return _fallbackTransformer(response);

  return instruction.parsed.maybeMap(
    transfer: (transfer) {
      final transferTx = transfer.info;
      final amount = transferTx.lamports;

      return Transaction.transfer(
        senderAddress: transferTx.source,
        recipientAddress: transferTx.destination,
        amount: amount,
        blockTime: _blockTimeToDateTime(response.blockTime),
        hash: transaction.signatures.first,
        meta: response.meta,
      );
    },
    transferChecked: (transfer) {
      final transferTx = transfer.info;
      final amount = transferTx.lamports;

      return Transaction.transfer(
        senderAddress: transferTx.source,
        recipientAddress: transferTx.destination,
        amount: amount,
        blockTime: _blockTimeToDateTime(response.blockTime),
        hash: transaction.signatures.first,
        meta: response.meta,
      );
    },
    orElse: () => _fallbackTransformer(response),
  );
}

Transaction _splTxTransformer(TransactionDetails response) {
  final transaction = response.transaction as ParsedTransaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSplToken>()
      .firstWhereOrNull(
        (ParsedInstructionSplToken tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return _fallbackTransformer(response);

  return instruction.parsed.maybeMap(
    transfer: (transfer) {
      final transferTx = transfer.info;
      final amount = int.parse(transferTx.amount);

      return Transaction.transfer(
        senderAddress: transferTx.source,
        recipientAddress: transferTx.destination,
        amount: amount,
        blockTime: _blockTimeToDateTime(response.blockTime),
        hash: transaction.signatures.first,
        meta: response.meta,
      );
    },
    transferChecked: (transfer) {
      final transferTx = transfer.info;
      final amount = int.parse(transferTx.tokenAmount.amount);

      return Transaction.transfer(
        senderAddress: transferTx.source,
        recipientAddress: transferTx.destination,
        amount: amount,
        blockTime: _blockTimeToDateTime(response.blockTime),
        hash: transaction.signatures.first,
        meta: response.meta,
      );
    },
    orElse: () => _fallbackTransformer(response),
  );
}

Transaction _fallbackTransformer(TransactionDetails response) =>
    Transaction.generic(
      meta: response.meta,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: (response.transaction as ParsedTransaction).signatures.first,
    );

DateTime? _blockTimeToDateTime(int? blockTime) {
  if (blockTime == null) return null;

  return DateTime.fromMillisecondsSinceEpoch(1000 * blockTime);
}

List<String> splitKey(IList<int> privateKey) {
  final parts = privateKey.splitAt(privateKey.length ~/ 2);

  return [
    base58encode(parts.first.toList()),
    base58encode(parts.second.toList()),
  ];
}
