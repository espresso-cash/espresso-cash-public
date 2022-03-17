import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HomeScreenHeaderRoundButton extends StatelessWidget {
  const HomeScreenHeaderRoundButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final SvgGenImage icon;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: SizedBox(
                width: 45,
                height: 45,
                child: icon.svg(height: 45),
              ),
            ),
          ),
          const Flexible(child: SizedBox(height: 16)),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
