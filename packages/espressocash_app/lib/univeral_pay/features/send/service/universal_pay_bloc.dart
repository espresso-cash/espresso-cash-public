// ignore_for_file: avoid-cubits, avoid-non-null-assertion

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/processing_state.dart';
import '../../../../core/tokens/token.dart';
import '../../../core/blockchain.dart';
import '../data/repository.dart';

part 'universal_pay_bloc.freezed.dart';

@freezed
class UniversalPayState with _$UniversalPayState {
  const factory UniversalPayState({
    @Default('') String destinationEvmAddress,
    Decimal? totalAmount,
    Decimal? fee,
    @Default(Blockchain.ethereum) Blockchain selectedBlockchain,
    @Default(ProcessingStateNone()) ProcessingState processingState,
    DateTime? expiresAt,
  }) = _UniversalPayState;
}

class UniversalPayBloc extends Cubit<UniversalPayState> {
  UniversalPayBloc(
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

    final destinationAddress = await _repository.getEvmAddress(
      receiver: _request.recipient.toBase58(),
      reference: reference.toBase58(),
    );

    emit(state.copyWith(destinationEvmAddress: destinationAddress));

    await refreshPrice();
  }

  void changeBlockchain(Blockchain blockchain) {
    emit(state.copyWith(selectedBlockchain: blockchain));

    refreshPrice();
  }

  Future<void> refreshPrice() async {
    emit(state.copyWith(processingState: const ProcessingStateProcessing()));

    final total = await _repository.getBlockchainFee(
      chainId: state.selectedBlockchain.chainId,
      amount: _request.amount!.shift(6).toString(),
      address: state.destinationEvmAddress,
    );

    final totalAmount = Amount.fromToken(value: total, token: Token.usdc);

    final fee = totalAmount.decimal - _request.amount!;

    emit(
      state.copyWith(
        totalAmount: totalAmount.decimal,
        fee: fee,
        processingState: const ProcessingStateNone(),
        expiresAt: DateTime.now().add(_refreshDuration),
      ),
    );
  }
}

const _refreshDuration = Duration(seconds: 60);
