import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/value_views.dart';
import 'package:flutter/widgets.dart';

class MemoInstructionDetails extends StatelessWidget {
  const MemoInstructionDetails({
    Key? key,
    required this.memo,
  }) : super(key: key);

  final String? memo;

  @override
  Widget build(BuildContext context) {
    final memo = this.memo;
    if (memo == null) {
      return const SizedBox();
    }

    return DetailsValue(value: memo);
  }
}
