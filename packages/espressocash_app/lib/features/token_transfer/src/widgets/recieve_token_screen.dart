import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config.dart';
import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/tokens/token.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';

class TokenReceiveScreen extends StatelessWidget {
  const TokenReceiveScreen({super.key, required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) {
    final account = context.read<MyAccount>();
    final ethAddress =
        (account.wallet as LocalWallet).wallet?.getAddressForCoin(ethCoinId);

    return CpTheme.dark(
      child: Scaffold(
        backgroundColor: CpColors.darkBackground,
        appBar: AppBar(
          title: Text(
            'Receive ${token.name}',
          ),
        ),
        body: Center(
          child: _QrCodeWidget(address: ethAddress!),
        ),
      ),
    );
  }
}

class _QrCodeWidget extends StatelessWidget {
  const _QrCodeWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.copyToClipboard(address),
        child: Container(
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImage(
                data: address,
                padding: EdgeInsets.zero,
                size: 200,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  address,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}
