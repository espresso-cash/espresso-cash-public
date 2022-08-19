import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'tx_processor.freezed.dart';

abstract class TxProcessor {
  AsyncEither<TxCreationError, SignedTx> createTx({
    required String firstPart,
    required String secondPart,
    required String recipient,
    required String tokenAddress,
  });

  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> sendPayment(
    SignedTx tx,
  );

  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> wait(SignedTx tx);
}

@freezed
class TxCreationError with _$TxCreationError {
  const factory TxCreationError.invalidLink() = _InvalidLink;
  const factory TxCreationError.consumedByRecipient() = _ConsumedByRecipient;
  const factory TxCreationError.consumedByOther() = _ConsumedByOther;
  const factory TxCreationError.other() = _Other;
}
