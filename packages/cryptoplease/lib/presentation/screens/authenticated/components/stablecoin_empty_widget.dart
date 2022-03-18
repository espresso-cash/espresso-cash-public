import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StableCoinEmptyWidget extends StatelessWidget {
  const StableCoinEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              context.l10n.stablecoinExplained,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.theyWillAppearHere,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
}
