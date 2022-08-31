import 'package:cryptoplease/core/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/creators/cp_tx_creator.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/creators/solana_tx_creator.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';

class TxCreatorSelector {
  TxCreatorSelector({
    required SolanaTxCreator solanaTxCreator,
    required CpTxCreator cpTxCreator,
  })  : _solanaTxCreator = solanaTxCreator,
        _cpTxCreator = cpTxCreator;

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

  TxCreator fromPayment(OutgoingTransfer payment) => payment.map(
        direct: (_) => _solanaTxCreator,
        splitKey: (s) => fromApiVersion(s.apiVersion),
      );
}
