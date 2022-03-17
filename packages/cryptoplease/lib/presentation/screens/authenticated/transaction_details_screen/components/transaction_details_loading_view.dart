import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TransactionDetailsLoadingView extends StatelessWidget {
  const TransactionDetailsLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        // Add padding at the bottom so that the spinner is centered
        padding: EdgeInsets.only(bottom: kToolbarHeight),
        child: Center(
          child: CircularProgressIndicator(color: CpColors.yellowColor),
        ),
      );
}
