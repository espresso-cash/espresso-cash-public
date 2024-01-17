// ignore_for_file: avoid-cubits, avoid-non-null-assertion

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/processing_state.dart';
import '../../../../features/tokens/token.dart';
import '../../../core/blockchain.dart';
import '../data/repository.dart';

part 'bloc.freezed.dart';

@freezed
class UniversalPayState with _$UniversalPayState {
  const factory UniversalPayState({
    @Default('') String destinationEvmAddress,
    Decimal? totalAmount,
    Decimal? fee,
    DateTime? expiresAt,
    Blockchain? selectedChain,
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = _UniversalPayState;
}

@Injectable(scope: 'landing')
class UniversalPayBloc extends Cubit<UniversalPayState> {
  UniversalPayBloc({
    required UniversalPayRepository repository,
    @factoryParam required SolanaPayRequest request,
    @factoryParam required Blockchain blockchain,
  })  : _repository = repository,
        _request = request,
        _selectedChain = blockchain,
        super(const UniversalPayState()) {
    _init();
  }

  final UniversalPayRepository _repository;
  final SolanaPayRequest _request;
  final Blockchain _selectedChain;

  Future<void> _init() async {
    emit(state.copyWith(processingState: const ProcessingStateProcessing()));

    final reference = _request.reference?.firstOrNull;
    if (reference == null) return;

    final destinationAddress = await _repository.getEvmAddress(
      receiver: _request.recipient.toBase58(),
      reference: reference.toBase58(),
    );

    emit(
      state.copyWith(
        destinationEvmAddress: destinationAddress,
        selectedChain: _selectedChain,
      ),
    );

    await refreshPrice();
  }

  Future<void> refreshPrice() async {
    emit(state.copyWith(processingState: const ProcessingStateProcessing()));

    final total = await _repository.getTotalAmount(
      chainId: _selectedChain.chainId,
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
