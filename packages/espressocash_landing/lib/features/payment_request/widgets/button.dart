import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../ui/arrow.dart';

class WalletButton extends StatelessWidget {
  const WalletButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final String label;
  final AssetGenImage icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          width: 300,
          height: 63,
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: StadiumBorder(),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  leading: icon.image(height: 40, width: 40),
                  title: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.13,
                    ),
                  ),
                  trailing: const LandingArrow(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
}
