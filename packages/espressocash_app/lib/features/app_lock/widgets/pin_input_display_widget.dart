import 'package:flutter/material.dart';

import 'pin_display.dart';
import 'pin_keypad.dart';

class PinInputDisplayWidget extends StatefulWidget {
  const PinInputDisplayWidget({super.key, this.message, required this.onCompleted});

  final String? message;
  final ValueSetter<String> onCompleted;

  @override
  State<PinInputDisplayWidget> createState() => _PinInputDisplayWidgetState();
}

class _PinInputDisplayWidgetState extends State<PinInputDisplayWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onInputChanged);
  }

  void _onInputChanged() {
    if (_controller.text.length != _maxDigits) return;

    widget.onCompleted(_controller.text);
    _controller.text = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        if (message != null) ...[
          Text(
            message.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 36),
        ],
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder:
              (context, value, _) =>
                  PinDisplay(maxDigits: _maxDigits, currentDigits: value.text.length),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomCenter,
          child: PinKeypad(maxDigits: _maxDigits, controller: _controller),
        ),
      ],
    );
  }
}

const _maxDigits = 6;
