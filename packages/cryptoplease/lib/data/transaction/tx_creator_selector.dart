import 'package:cryptoplease/core/api_version.dart';
import 'package:cryptoplease/data/transaction/creators/cp_tx_creator.dart';
import 'package:cryptoplease/data/transaction/creators/solana_tx_creator.dart';
import 'package:cryptoplease/data/transaction/tx_creator.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';

class TxCreatorSelector {
  TxCreatorSelector({
    required SolanaTxCreator solanaTxCreator,
    required CpTxCreator cpTxCreator,
  })  : _solanaTxCreator = solanaTxCreator,
        _cpTxCreator = cpTxCreator;

  final SolanaTxCreator _solanaTxCreator;
  final CpTxCreator _cpTxCreator;

  TxCreator fromApiVersion(ApiVersion apiVersion) {
    switch (apiVersion) {
      case ApiVersion.v2:
        return _cpTxCreator;
      case ApiVersion.v1:
        return _solanaTxCreator;
    }
  }

  TxCreator fromPayment(OutgoingTransfer payment) => payment.map(
        direct: (_) => _solanaTxCreator,
        splitKey: (s) => fromApiVersion(s.apiVersion),
      );
}
