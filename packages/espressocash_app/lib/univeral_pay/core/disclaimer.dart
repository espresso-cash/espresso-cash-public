import 'package:flutter/material.dart';

class DisclaimerCheckbox extends StatelessWidget {
  const DisclaimerCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 450,
        child: Column(
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Disclaimer for Money Transfer Service Demo\nThis is a demonstration of our money transfer service and involves actual monetary transactions. By using this demo, you acknowledge and agree to the following terms:\n\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '''
1. Educational Purpose: This demo is designed to showcase the functionality and user experience of our money transfer service. It involves real monetary transactions for the purpose of this demonstration.\n
2. Risk of System Error: While we have taken extensive measures to ensure the reliability and accuracy of our systems, there is a small possibility of system error. In the event of such an error, there may be a chance of loss of funds. Any such loss would involve actual money and may not be temporary.\n
3. Code Not Audited: Please note that the underlying code for this demo has not undergone a formal security audit. It is provided for demonstration purposes only and may not reflect the final, audited version.\n
4. Not a Guarantee of Service: The features, functionalities, and processes demonstrated in this platform are subject to change and may not represent the final version of our service.\n
5. Not for Production Use: This demo is not intended for live or production use. Please do not attempt to use this platform for actual financial transactions outside the scope of this demonstration.\n
6. No Liability for Loss: In the event of a system error resulting in the loss of funds, we shall not be held liable for any associated inconvenience or any perceived loss. Any such loss would involve actual money.''',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () {
                onChanged(!value);
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      width: 30,
                      height: 30,
                      decoration: const ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.transparent,
                          ),
                          child: SizedBox.square(
                            child: value
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Text(
                        'I have read and understood the above disclaimer and agree to use this demo solely for educational and demonstrative purposes.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
