import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/dynamic_links_wrapper.dart';
import '../../../../core/single_key_payments.dart';
import '../../../../routes.gr.dart';
import '../../widgets/extensions.dart';

class ISLPListener extends StatefulWidget {
  const ISLPListener({super.key, required this.child});

  final Widget child;

  @override
  State<ISLPListener> createState() => _ISLPListenerState();
}

class _ISLPListenerState extends State<ISLPListener> {
  Future<void> _processISLP(SingleKeyPaymentData data) async {
    final id = await context.createISLP(data);

    if (!mounted) return;
    context.router.push(IncomingSingleLinkRoute(id: id)).ignore();
  }

  bool _onLink(Uri link) {
    final data = SingleKeyPaymentData.tryParse(link);
    if (data != null) {
      _processISLP(data);

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => DynamicLinksWrapper(
        onLink: _onLink,
        child: widget.child,
      );
}
