import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/first_part_ready_content.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/second_part_ready_content.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/success_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplitKeyIncomingPaymentScreen extends StatefulWidget {
  const SplitKeyIncomingPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SplitKeyIncomingPaymentScreen> createState() =>
      _SplitKeyIncomingPaymentScreenState();
}

class _SplitKeyIncomingPaymentScreenState
    extends State<SplitKeyIncomingPaymentScreen> {
  Widget? _previousContent;

  @override
  Widget build(BuildContext context) =>
      context.watch<SplitKeyIncomingPaymentBloc>().state.map(
            none: (_) => _previousContent ?? const SizedBox(),
            firstPartReady: (s) {
              const content = FirstPartReadyContent();
              _previousContent = content;

              return content;
            },
            secondPartReady: (s) {
              final content = SecondPartReadyContent(payment: s);
              _previousContent = content;

              return content;
            },
            success: (_) {
              const content = SuccessContent();
              _previousContent = content;

              return content;
            },
          );
}
