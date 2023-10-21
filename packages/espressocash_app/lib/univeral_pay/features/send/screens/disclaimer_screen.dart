import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import '../../../../ui/button.dart';
import '../../../core/disclaimer.dart';
import '../../../core/disclaimer_service.dart';
import '../../../core/page.dart';
import '../../../routes.gr.dart';
import '../../request/screens/request_screen.dart';

@RoutePage()
class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key, this.onAccept});

  final VoidCallback? onAccept;

  static const route = DisclaimerRoute.new;

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  bool _isAccepted = false;

  void _onAccept() {
    if (widget.onAccept != null) {
      DisclaimerService().acceptDisclaimer();
      widget.onAccept?.call();
    } else {
      context.router.replace(RequestScreen.route());
    }
  }

  @override
  Widget build(BuildContext context) => PageWidget(
        children: [
          DisclaimerCheckbox(
            value: _isAccepted,
            fontSize: 14,
            onChanged: (value) {
              setState(() {
                _isAccepted = value;
              });
            },
          ),
          const SizedBox(height: 32),
          CpButton(
            onPressed: _isAccepted ? _onAccept : null,
            text: 'Continue',
            size: CpButtonSize.big,
            width: 450,
          ),
        ],
      );
}
