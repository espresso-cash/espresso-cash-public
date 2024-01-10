import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../ramp/models/ramp_partner.dart';
import '../../../tokens/token.dart';
import '../../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._cryptopleaseClient, this._solanaClient);

  final CryptopleaseClient _cryptopleaseClient;
  final SolanaClient _solanaClient;

  Future<CryptoAmount> call(FeeType type) => _cryptopleaseClient.getFees().then(
        (fees) async {
          switch (type) {
            case FeeTypeDirect(:final address):
              final hasAta = await _solanaClient.hasAssociatedTokenAccount(
                owner: address,
                mint: Token.usdc.publicKey,
              );

              return hasAta
                  ? fees.directPayment.ataExists
                  : fees.directPayment.ataDoesNotExist;
            case FeeTypeSplitKey():
              return fees.escrowPayment;
            case FeeTypeWithdraw(:final amount, :final partner):
              final feePercentage = switch (partner) {
                RampPartner.scalex => fees.withdrawFeePercentage.scalex,
                RampPartner.coinflow => fees.withdrawFeePercentage.coinflow,
                RampPartner.guardarian => fees.withdrawFeePercentage.guardarian,
                RampPartner.rampNetwork =>
                  fees.withdrawFeePercentage.rampNetwork,
                RampPartner.kado => fees.withdrawFeePercentage.kado,
              };
              final calculatedFee = (amount * feePercentage / 100).round();

              return fees.directPayment.ataExists + calculatedFee;
          }
        },
      ).then((fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc));
}
