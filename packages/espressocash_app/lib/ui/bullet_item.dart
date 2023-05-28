import 'package:flutter/material.dart';

import 'colors.dart';

class CpBulletItemWidget extends StatelessWidget {
  const CpBulletItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 20,
                margin: const EdgeInsets.only(right: 12, top: 2),
                decoration: const ShapeDecoration(
                  color: CpColors.yellowColor,
                  shape: StadiumBorder(),
                ),
                child: const SizedBox(),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  textHeightBehavior: const TextHeightBehavior(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
