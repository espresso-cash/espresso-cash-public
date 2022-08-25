import 'package:cryptoplease/core/api_reference.dart';
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

  TxCreator fromApiReference(ApiReference apiReference) {
    switch (apiReference) {
      case ApiReference.cryptoplease:
        return _cpTxCreator;
      case ApiReference.solana:
        return _solanaTxCreator;
    }
  }

  TxCreator fromPayment(OutgoingTransfer payment) => payment.map(
        direct: (_) => _solanaTxCreator,
        splitKey: (s) => fromApiReference(s.apiReference),
      );
}
