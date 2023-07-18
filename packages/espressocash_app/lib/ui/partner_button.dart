import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class PartnerButton extends StatelessWidget {
  const PartnerButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.image,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final AssetGenImage image;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 25),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: const StadiumBorder(),
          ),
          child: SizedBox(
            height: 52,
            child: image.image(
              frameBuilder: (context, child, _, __) => Container(
                padding: const EdgeInsets.all(8),
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xfff8f8f8),
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
}
