// ignore_for_file: avoid-cubits

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/processing_state.dart';
import '../../../core/blockchain.dart';
import '../data/repository.dart';

part 'universal_pay_bloc.freezed.dart';

@freezed
class UniversalPayState with _$UniversalPayState {
  const factory UniversalPayState({
    String? destinationAddress,
    String? totalAmount,
    @Default(Blockchain.ethereum) Blockchain blockchain,
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = _UniversalPayState;
}

class UniversalPayCubit extends Cubit<UniversalPayState> {
  UniversalPayCubit(
    this._repository,
    this._request,
  ) : super(const UniversalPayState()) {
    _init();
  }

  final UniversalPayRepository _repository;
  final SolanaPayRequest _request;

  Future<void> _init() async {
    emit(state.copyWith(processingState: const ProcessingStateProcessing()));

    final reference = _request.reference?.firstOrNull;
    if (reference == null) return;

    final destinationAddress = await _repository.fetch(
      receiver: _request.recipient.toBase58(),
      reference: reference.toBase58(),
    );

    final Decimal totalAmount = _request.amount! + state.blockchain.fee;

    emit(
      state.copyWith(
        destinationAddress: destinationAddress,
        totalAmount: totalAmount.toString(),
        processingState: const ProcessingStateNone(),
      ),
    );
  }

  void changeBlockchain(Blockchain blockchain) {
    final Decimal totalAmount = _request.amount! + blockchain.fee;

    emit(
      state.copyWith(
        blockchain: blockchain,
        totalAmount: totalAmount.toString(),
      ),
    );
  }
}
