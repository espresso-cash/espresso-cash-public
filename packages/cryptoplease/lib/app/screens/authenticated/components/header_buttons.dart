import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/flow.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/send_flow.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// TODO(JE): remove if not used in other pages
class AddFundsButton extends StatelessWidget {
  const AddFundsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderedListButton(
        label: context.l10n.addFunds,
        icon: SvgPicture.asset(Assets.icons.add.path),
        onPressed: () => context.router.navigate(
          AddFundsRoute(
            wallet: context.read<MyAccount>().wallet,
            token: Token.sol,
          ),
        ),
      );
}

class SwapButton extends StatelessWidget {
  const SwapButton({Key? key, this.token}) : super(key: key);

  final Token? token;

  @override
  Widget build(BuildContext context) => HeaderedListButton(
        label: context.l10n.swap,
        icon: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(width: 2, color: const Color(0xffFF8956)),
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            Assets.icons.swap.path,
            color: Colors.white,
          ),
        ),
        onPressed: () => context.router.navigate(
          SwapTokenFlowRoute(token: token),
        ),
      );
}

class SendButton extends StatelessWidget {
  const SendButton({Key? key, this.token}) : super(key: key);

  final Token? token;

  @override
  Widget build(BuildContext context) => HeaderedListButton(
        label: context.l10n.send,
        icon: SvgPicture.asset(Assets.icons.send.path),
        onPressed: () => context.navigateToSendFt(token),
      );
}

class ReceiveButton extends StatelessWidget {
  const ReceiveButton({Key? key, this.token}) : super(key: key);

  final Token? token;

  @override
  Widget build(BuildContext context) => HeaderedListButton(
        label: context.l10n.receive,
        icon: SvgPicture.asset(Assets.icons.receive.path),
        onPressed: () => context.navigateToReceiveFlow(token: token),
      );
}
