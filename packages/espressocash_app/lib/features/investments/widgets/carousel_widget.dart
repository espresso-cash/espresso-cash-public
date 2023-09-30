import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../ui/button.dart';
import '../../wallet_flow/screens/wallet_flow_screen.dart';

class HomeCarouselWidget extends StatelessWidget {
  const HomeCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 200,
            child: Placeholder(),
          ),
          CpButton(
            minWidth: 250,
            size: CpButtonSize.wide,
            text: 'Send Money Now',
            onPressed: () => context.router.navigate(WalletFlowScreen.route()),
          ),
        ],
      );
}
