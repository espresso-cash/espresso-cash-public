import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/split_key_payments.dart';
import '../../../../routes.gr.dart';

class ISLPListener extends StatefulWidget {
  const ISLPListener({super.key, required this.child});

  final Widget child;

  @override
  State<ISLPListener> createState() => _ISLPListenerState();
}

class _ISLPListenerState extends State<ISLPListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final data = SplitQrLink.tryParse(link);

      if (data != null) {
        context.router.push(const FirstPartQrRoute()).ignore();

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
