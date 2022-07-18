import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/stable_token_dropdown.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '32.15',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 57,
                fontWeight: FontWeight.bold,
              ),
            ),
            StableTokenDropdown(
              onTap: () {},
              selectedToken: Token.usdc,
              suffixWidget: const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
