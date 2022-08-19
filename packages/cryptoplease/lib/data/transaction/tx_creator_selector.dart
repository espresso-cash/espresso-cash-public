import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/data/transaction/creators/cp_tx_creator.dart';
import 'package:cryptoplease/data/transaction/creators/solana_tx_creator.dart';
import 'package:cryptoplease/data/transaction/tx_creator.dart';

class TxCreatorSelector {
  TxCreatorSelector({
    required SolanaTxCreator solanaTxCreator,
    required CpTxCreator cpTxCreator,
  })  : _solanaTxCreator = solanaTxCreator,
        _cpTxCreator = cpTxCreator;

  final SolanaTxCreator _solanaTxCreator;
  final CpTxCreator _cpTxCreator;

  TxCreator fromTokenAddress(String tokenAddress) {
    if (tokenAddress == Token.usdc.address) return _cpTxCreator;

    return _solanaTxCreator;
  }
}
