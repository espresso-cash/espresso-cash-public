import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.5,
                child: Assets.images.logoIcon.image(height: 120),
              ),
              const SizedBox(height: 24.0),
              Text(
                message,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      );
}
