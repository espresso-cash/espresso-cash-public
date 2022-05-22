import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SwapStepWidget extends StatefulWidget {
  const SwapStepWidget({
    Key? key,
    required this.isLoading,
    required this.message,
  }) : super(key: key);

  final String message;
  final bool isLoading;

  @override
  State<SwapStepWidget> createState() => _SwapStepWidgetState();
}

class _SwapStepWidgetState extends State<SwapStepWidget> {
  @override
  Widget build(BuildContext context) => CpContentPadding(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              Flexible(
                child: Text(widget.message),
              ),
            ],
          ),
        ),
      );
}
