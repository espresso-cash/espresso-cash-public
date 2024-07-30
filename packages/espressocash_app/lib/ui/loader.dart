import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../utils/callback.dart';
import 'colors.dart';

// ignore: avoid-unnecessary-stateful-widgets, DCM bug
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
            color: CpColors.yellowColor,
          ),
        ),
      );
}

Future<T> runWithLoader<T>(
  BuildContext context,
  Func0<Future<T>> fn, {
  Callback1<Exception>? onError,
}) async {
  final future = fn();

  await showDialog<T>(
    barrierDismissible: false,
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      child: LoadingDialog<T>(future: future, onError: onError),
    ),
  );

  return future;
}

class LoadingDialog<T> extends StatefulWidget {
  const LoadingDialog({
    super.key,
    required this.future,
    this.onError,
  });

  final Future<T> future;
  final Callback1<Exception>? onError;

  @override
  State<LoadingDialog<T>> createState() => _LoadingDialogState();
}

class _LoadingDialogState<T> extends State<LoadingDialog<T>> {
  @override
  void initState() {
    super.initState();
    widget.future.then(
      (_) => Navigator.of(context).pop(),
      onError: (Object error, StackTrace stackTrace) {
        Navigator.of(context).pop();
        if (error is Exception) {
          widget.onError?.call(error);
        } else {
          Error.throwWithStackTrace(error, stackTrace);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => const LoadingIndicator();
}
