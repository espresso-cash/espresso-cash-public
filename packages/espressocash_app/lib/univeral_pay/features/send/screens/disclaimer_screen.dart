import 'package:flutter/widgets.dart';

import '../../../../ui/button.dart';
import '../../../core/disclaimer.dart';
import '../../../core/page.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key, required this.onAccept});

  final VoidCallback onAccept;

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  bool _isAccepted = false;
  @override
  Widget build(BuildContext context) => PageWidget(
        children: [
          DisclaimerCheckbox(
            value: _isAccepted,
            onChanged: (value) {
              setState(() {
                _isAccepted = value;
              });
            },
          ),
          const SizedBox(height: 32),
          CpButton(
            onPressed: _isAccepted ? widget.onAccept : null,
            text: 'Continue',
            size: CpButtonSize.big,
            width: 450,
          ),
        ],
      );
}
