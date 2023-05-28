import 'package:flutter/material.dart';

import 'colors.dart';

class CpLoader extends StatefulWidget {
  const CpLoader({
    super.key,
    required this.child,
    required this.isLoading,
  });

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
            color: CpColors.yellowColor,
          ),
        ),
      );
}

Future<T> runWithLoader<T>(
  BuildContext context,
  Future<T> Function() fn,
) async {
  final future = fn();

  await showDialog<T>(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: LoadingDialog<T>(future: future),
    ),
  );

  return future;
}

class LoadingDialog<T> extends StatefulWidget {
  const LoadingDialog({super.key, required this.future});

  final Future<T> future;

  @override
  State<LoadingDialog<T>> createState() => _LoadingDialogState();
}

class _LoadingDialogState<T> extends State<LoadingDialog<T>> {
  @override
  void initState() {
    super.initState();
    widget.future.then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) => const LoadingIndicator();
}
