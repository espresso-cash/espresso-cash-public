import 'package:cryptoplease/presentation/screens/app_lock/components/pin_display.dart';
import 'package:cryptoplease/presentation/screens/app_lock/components/pin_keypad.dart';
import 'package:flutter/material.dart';

class PinInputDisplayWidget extends StatefulWidget {
  const PinInputDisplayWidget({
    Key? key,
    this.message,
    required this.onCompleted,
  }) : super(key: key);

  final String? message;
  final void Function(String) onCompleted;

  @override
  State<PinInputDisplayWidget> createState() => _PinInputDisplayWidgetState();
}

class _PinInputDisplayWidgetState extends State<PinInputDisplayWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()..addListener(_onInputChanged);
  }

  void _onInputChanged() {
    if (controller.text.length == _maxDigits) {
      widget.onCompleted(controller.text);
      controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (message != null) ...[
          Text(message, style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: 24),
        ],
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => PinDisplay(
            maxDigits: _maxDigits,
            currentDigits: value.text.length,
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.bottomCenter,
          child: PinKeypad(
            maxDigits: _maxDigits,
            controller: controller,
          ),
        ),
      ],
    );
  }
}

const _maxDigits = 6;
