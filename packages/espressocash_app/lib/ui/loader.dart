import 'package:flutter/material.dart';

import 'colors.dart';

class CpLoader extends StatefulWidget {
  const CpLoader({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  State<CpLoader> createState() => _CpLoaderState();
}

class _CpLoaderState extends State<CpLoader> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _key, child: widget.child);

    return widget.isLoading
        ? WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: [
                child,
                Container(
                  color: Colors.black38,
                  child: const LoadingIndicator(),
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
            color: CpColors.yellowColor,
          ),
        ),
      );
}
