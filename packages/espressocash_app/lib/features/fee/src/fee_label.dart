import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/async_snapshot.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../balances/presentation/format_amount.dart';

part 'fee_label.freezed.dart';

@freezed
class FeeType with _$FeeType {
  const factory FeeType.direct(Ed25519HDPublicKey address) = _FeeTypeDirect;
  const factory FeeType.splitKey() = _FeeTypeSplitKey;
}

class FeeLabel extends StatefulWidget {
  const FeeLabel({super.key, required this.type});

  final FeeType type;

  @override
  State<FeeLabel> createState() => _FeeLabelState();
}

class _FeeLabelState extends State<FeeLabel> {
  late final Future<String> _amount;

  @override
  void initState() {
    super.initState();
    _amount = sl<FeeCalculator>()
        .call(widget.type)
        .then((value) => value.format(DeviceLocale.localeOf(context)));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: _amount,
        builder: (context, snapshot) {
          final String text = snapshot.toResult().when(
                loading: always(context.l10n.feesCalculating),
                error: always(context.l10n.feesFailed),
                data: identity,
              );

          return Text(
            context.l10n.feeAmount(text),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      );
}

@injectable
class FeeCalculator {
  FeeCalculator(this._cryptopleaseClient, this._solanaClient);

  final CryptopleaseClient _cryptopleaseClient;
  final SolanaClient _solanaClient;

  Future<Amount> call(FeeType type) => _cryptopleaseClient
      .getFees()
      .then(
        (fees) async => type.map(
          direct: (type) async {
            final hasAta = await _solanaClient.hasAssociatedTokenAccount(
              owner: type.address,
              mint: Token.usdc.publicKey,
            );

            return hasAta
                ? fees.directPayment.ataExists
                : fees.directPayment.ataDoesNotExist;
          },
          splitKey: (_) async => fees.splitKeyPayment,
        ),
      )
      .then((fee) => Amount(value: fee, currency: Currency.usdc));
}
