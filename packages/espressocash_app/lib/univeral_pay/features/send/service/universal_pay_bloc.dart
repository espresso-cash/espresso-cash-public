// ignore_for_file: avoid-cubits

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import '../data/repository.dart';

part 'universal_pay_bloc.freezed.dart';

@freezed
class PayState with _$PayState {
  const factory PayState({
    required String destinationAddress,
    required String fee,
    required String totalAmount,
  }) = _PayState;
}

typedef UniversalPayState = Flow<Exception, PayState>;

class UniversalPayCubit extends Cubit<UniversalPayState> {
  UniversalPayCubit(
    this._repository,
    this._request,
  ) : super(const Flow.processing()) {
    init();
  }

  final UniversalPayRepository _repository;
  final SolanaPayRequest _request;

  Future<void> init() async {
    final reference = _request.reference?.firstOrNull;
    if (reference == null) return;

    final destinationAddress = await _repository.fetch(
      receiver: _request.recipient.toBase58(),
      reference: reference.toBase58(),
    );

    final fee = Decimal.fromInt(1); // hardcoded fee
    final totalAmount = _request.amount! + fee;

    emit(
      Flow.success(
        PayState(
          destinationAddress: destinationAddress,
          fee: fee.toString(),
          totalAmount: totalAmount.toString(),
        ),
      ),
    );
  }
}
