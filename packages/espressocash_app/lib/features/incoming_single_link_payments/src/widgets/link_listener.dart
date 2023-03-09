import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/single_key_payments.dart';
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
      final data = SingleKeyPaymentData.tryParse(link);

      if (data != null) {
        _processISLP(data);

        return true;
      }

      return false;
    });
  }

  Future<void> _processISLP(SingleKeyPaymentData data) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;
    context.router.push(IncomingSingleLinkRoute(data: data)).ignore();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
