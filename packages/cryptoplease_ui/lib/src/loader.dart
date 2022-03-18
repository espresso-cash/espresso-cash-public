import 'package:cryptoplease_ui/src/colors.dart';
import 'package:flutter/material.dart';

class CpLoader extends StatefulWidget {
  const CpLoader({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  _CpLoaderState createState() => _CpLoaderState();
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
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: CpColors.yellowColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        : child;
  }
}
