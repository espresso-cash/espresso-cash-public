import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../widgets/off_ramp_bottom_sheet.dart';

@RoutePage()
class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.router.pop();
      OffRampBottomSheet.show(context);
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}
