import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'tx_creator.freezed.dart';

abstract class TxCreator {
  AsyncEither<TxCreationError, SignedTx> createOutgoingTx({
    required OutgoingTransfer payment,
    required MyAccount account,
  });

  AsyncEither<TxCreationError, SignedTx> createIncomingTx({
    required String firstPart,
    required String secondPart,
    required String recipient,
    required String tokenAddress,
  });
}

@freezed
class TxCreationError with _$TxCreationError {
  const factory TxCreationError.invalidLink() = _InvalidLink;
  const factory TxCreationError.consumedByRecipient() = _ConsumedByRecipient;
  const factory TxCreationError.consumedByOther() = _ConsumedByOther;
  const factory TxCreationError.other() = _Other;
}
