import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:convert/convert.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:trust_wallet_core_lib/protobuf/Ethereum.pb.dart' as Ethereum;
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:web3dart/web3dart.dart' hide Transaction;

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import '../../../../di.dart';

part 'bloc.freezed.dart';

@injectable
class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc(this._ethereumClient) : super(const Flow.initial()) {
    on<TransferEvent>(_eventHandler, transformer: sequential());
  }

  final EthereumClient _ethereumClient;

  EventHandler<TransferEvent, TransferState> get _eventHandler =>
      (event, emit) => event.map(
            submitted: (event) => _onSubmitted(event, emit),
          );

  Future<void> _onSubmitted(
    TransferSubmitted event,
    Emitter<TransferState> emit,
  ) async {
    emit(const Flow.processing());
    try {
      emit(const Flow.processing());

      final amount = Amount.fromDecimal(
        value: Decimal.parse(event.amount.toString()),
        currency: CryptoCurrency(token: event.token),
      );

      final sender =
          EthereumAddress.fromHex(event.wallet.getAddressForCoin(ethCoinId));

      final nonce = await _ethereumClient.getTransactionCount(
        sender,
        atBlock: const BlockNum.pending(),
      );

      final gasPrice = await _ethereumClient.getGasPrice();

      final maxGas = await _ethereumClient.estimateGas(
        sender: sender,
        to: EthereumAddress.fromHex(event.destination),
        value: EtherAmount.fromInt(EtherUnit.wei, amount.value),
        gasPrice: gasPrice,
      );

      final secretPrivateKey = event.wallet.getKeyForCoin(ethCoinId);

      final ethTx = Ethereum.Transaction_Transfer(
        amount: bigIntToBytes(BigInt.from(amount.value)),
      );

      final signingInput = Ethereum.SigningInput(
        chainId: bigIntToBytes(BigInt.from(ethChainId)),
        gasPrice: bigIntToBytes(gasPrice.getInWei),
        gasLimit: bigIntToBytes(maxGas),
        toAddress: event.destination,
        transaction: Ethereum.Transaction(transfer: ethTx),
        privateKey: secretPrivateKey.data(),
        nonce: bigIntToBytes(BigInt.from(nonce)),
      );

      final sign = AnySigner.sign(signingInput.writeToBuffer(), ethCoinId);
      final signingOutput = Ethereum.SigningOutput.fromBuffer(sign);

      final tx = await _ethereumClient
          .sendRawTransaction(Uint8List.fromList(signingOutput.encoded));

      // final walletHex =
      //     hex.encode(event.wallet.getKeyForCoin(ethCoinId).data());
      // final credentials = EthPrivateKey.fromHex(walletHex);

      // final tx = await _ethereumClient.sendTransaction(
      //   credentials,
      //   Transaction(
      //     to: EthereumAddress.fromHex(event.destination),
      //     value: EtherAmount.fromInt(EtherUnit.wei, amount.value),
      //   ),
      //   chainId: ethChainId,
      // );

      print(tx);

      emit(Flow.success(tx));
    } on Exception catch (e) {
      print(e);
      emit(Flow.failure(e));
    }
  }
}

typedef TransferState = Flow<Exception, String>;

@freezed
class TransferEvent with _$TransferEvent {
  const factory TransferEvent.submitted({
    required Token token,
    required double amount,
    required String destination,
    required HDWallet wallet,
  }) = TransferSubmitted;
}

List<int> bigIntToBytes(BigInt number) {
  var inHex = number.toRadixString(16);
  if (inHex.length % 2 == 1) {
    inHex = '0$inHex';
  }
  return hex.decode(inHex);
}
