import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

abstract class TxSigner {
  Future<Message> createSignedTx(OutgoingTransfer payment, MyAccount account);
}
