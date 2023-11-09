// ignore_for_file: avoid-cubits, avoid-non-null-assertion

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/processing_state.dart';
import '../../../core/blockchain.dart';
import '../data/repository.dart';

part 'bloc.freezed.dart';

@freezed
class UniversalPayState with _$UniversalPayState {
  const factory UniversalPayState({
    @Default('') String destinationEvmAddress,
    @Default('0') String? totalAmount,
    @Default({}) Map<Blockchain, Decimal> fees,
    @Default(Blockchain.ethereum) Blockchain selectedBlockchain,
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = _UniversalPayState;
}

@Injectable(scope: 'landing')
class UniversalPayCubit extends Cubit<UniversalPayState> {
  UniversalPayCubit({
    required UniversalPayRepository repository,
    @factoryParam required SolanaPayRequest request,
  })  : _repository = repository,
        _request = request,
        super(const UniversalPayState()) {
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

    final networkFee = await _repository.getBlockchainFee(
      chainId: state.selectedBlockchain.chainId,
      amount: _request.amount!.toString(),
    );

    final fee = Decimal.parse(networkFee.toStringAsFixed(2));

    final Decimal totalAmount = _request.amount! + fee;

    emit(
      state.copyWith(
        destinationEvmAddress: destinationAddress,
        totalAmount: totalAmount.toString(),
        fees: {
          state.selectedBlockchain: fee,
        },
        processingState: const ProcessingStateNone(),
      ),
    );
  }

  Future<void> changeBlockchain(Blockchain blockchain) async {
    if (!state.fees.containsKey(blockchain)) {
      emit(state.copyWith(processingState: const ProcessingStateProcessing()));

      final networkFee = await _repository.getBlockchainFee(
        chainId: blockchain.chainId,
        amount: _request.amount!.toString(),
      );

      final fee = Decimal.parse(networkFee.toStringAsFixed(2));

      final Decimal totalAmount = _request.amount! + fee;

      final fees = {
        ...state.fees,
        blockchain: fee,
      };

      emit(
        state.copyWith(
          selectedBlockchain: blockchain,
          totalAmount: totalAmount.toString(),
          fees: fees,
          processingState: const ProcessingStateNone(),
        ),
      );
    } else {
      final Decimal totalAmount = _request.amount! + state.fees[blockchain]!;

      emit(
        state.copyWith(
          selectedBlockchain: blockchain,
          totalAmount: totalAmount.toString(),
          processingState: const ProcessingStateNone(),
        ),
      );
    }
  }
}
