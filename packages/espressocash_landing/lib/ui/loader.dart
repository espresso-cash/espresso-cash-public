import 'package:flutter/material.dart';

import 'colors.dart';

class EcLoader extends StatefulWidget {
  const EcLoader({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  State<EcLoader> createState() => _EcLoaderState();
}

class _EcLoaderState extends State<EcLoader> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _key, child: widget.child);

    return widget.isLoading
        ? PopScope(
            canPop: false,
            child: Stack(
              children: [
                child,
                const ColoredBox(
                  color: Colors.black38,
                  child: LoadingIndicator(),
                ),
              ],
            ),
          )
        : child;
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(
            color: EcLandingColors.yellowColor,
          ),
        ),
      );
}
