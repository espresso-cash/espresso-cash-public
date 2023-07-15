import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../di.dart';
import '../l10n/device_locale.dart';
import '../l10n/l10n.dart';
import 'amount.dart';
import 'async_snapshot.dart';
import 'currency.dart';
import 'presentation/format_amount.dart';
import 'tokens/token.dart';

part 'fee_label.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
  copyWith: false,
)
sealed class FeeType with _$FeeType {
  const factory FeeType.direct(Ed25519HDPublicKey address) = FeeTypeDirect;
  const factory FeeType.splitKey() = FeeTypeSplitKey;
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
          final String text = switch (snapshot.toResult()) {
            AsyncSnapshotLoading() => context.l10n.feesCalculating,
            AsyncSnapshotError() => context.l10n.feesFailed,
            AsyncSnapshotData(:final data) => data,
          };

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
  const FeeCalculator(this._cryptopleaseClient, this._solanaClient);

  final CryptopleaseClient _cryptopleaseClient;
  final SolanaClient _solanaClient;

  Future<Amount> call(FeeType type) => _cryptopleaseClient.getFees().then(
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
          }
        },
      ).then((fee) => Amount(value: fee, currency: Currency.usdc));
}
