import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/info_icon.dart';

class UnavailableTokenNotice extends StatelessWidget {
  const UnavailableTokenNotice({super.key, required this.tokenName});

  final String tokenName;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xff181818),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: CpInfoIcon(
                iconColor: Colors.black,
                height: 14,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                context.l10n.unavailableToken(tokenName),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
}
