import 'package:cryptoplease/core/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/creators/cp_tx_creator.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/creators/solana_tx_creator.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:solana/solana.dart';

class TxCreatorStrategy {
  TxCreatorStrategy({
    required SolanaClient solanaClient,
    required CryptopleaseClient cryptopleaseClient,
  })  : _solanaTxCreator = SolanaTxCreator(solanaClient: solanaClient),
        _cpTxCreator = CpTxCreator(cpClient: cryptopleaseClient);

  final SolanaTxCreator _solanaTxCreator;
  final CpTxCreator _cpTxCreator;

  TxCreator fromApiVersion(SplitKeyApiVersion apiVersion) {
    switch (apiVersion) {
      case SplitKeyApiVersion.v2:
        return _cpTxCreator;
      case SplitKeyApiVersion.v1:
        return _solanaTxCreator;
    }
  }

  TxCreator fromPayment(OutgoingTransfer payment) =>
      fromApiVersion(payment.apiVersion);
}
