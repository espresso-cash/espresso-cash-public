import 'dart:async';

import 'package:cryptoplease/bl/analytics/analytics_manager.dart';
import 'package:cryptoplease/bl/outgoing_transfers/pending_request_bloc/pending_request_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

/// If the app is opened with deep link (no matter whether the app was started
/// or resumed from background) it will parse the link and add it to
/// `LinkNotifier`.
///
/// There's no logic for link processing here, it just tries to parse the deep
/// link as link with payment data, and if succeeds, notifies listeners.
///
/// If listener accepted the link, should reset the current link with setting
/// `LinkNotifier.value` to `null`.
class DynamicLinksController extends StatefulWidget {
  const DynamicLinksController({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _DynamicLinksControllerState createState() => _DynamicLinksControllerState();
}

class _DynamicLinksControllerState extends State<DynamicLinksController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  StreamSubscription<dynamic>? _subscription;

  Future<void> _init() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    data?.link.also(_tryProcessSplitKeyFirstPart).also(_tryProcessLink);

    _subscription = FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData? dynamicLink) async {
      if (dynamicLink == null) return;

      _tryProcessLink(dynamicLink.link);
      _tryProcessSplitKeyFirstPart(dynamicLink.link);
    });

    final initialUri = await getInitialUri();
    _tryProcessSplitKeySecondPart(initialUri);
    _tryProcessLink(initialUri);
    uriLinkStream.listen((link) {
      _tryProcessLink(link);
      _tryProcessSplitKeySecondPart(link);
    });
  }

  void _tryProcessLink(Uri? link) {
    if (link == null) return;
    _tryProcessFirstLink(link);
    _tryProcessSecondLink(link);
    _tryProcessSolanaPayLink(link);
  }

  void _tryProcessSolanaPayLink(Uri link) {
    context.read<PendingRequestBloc>().add(PendingRequestEvent.linkAdded(link));
  }

  void _tryProcessFirstLink(Uri link) {
    final firstPart = SplitKeyIncomingFirstPart.tryParse(link);

    if (firstPart == null) return;

    final event = SplitKeyIncomingPaymentEvent.firstPartAdded(
      firstPart: firstPart,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
    context.read<AnalyticsManager>().logShareableLinkPressed();
  }

  void _tryProcessSecondLink(Uri link) {
    final secondPart = SplitKeySecondLink.tryParse(link);
    if (secondPart == null) return;

    final event = SplitKeyIncomingPaymentEvent.secondPartAdded(
      value: secondPart,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
  }

  @Deprecated('Old format of split key payment link')
  void _tryProcessSplitKeyFirstPart(Uri link) {
    if (link.path != '/') return;
    if (link.queryParameters['type'] != 'sk') return;

    final firstPart = link.queryParameters['first'];
    final tokenAddress = link.queryParameters['token'] ?? Token.sol.address;

    if (firstPart != null) {
      final event = SplitKeyIncomingPaymentEvent.firstPartAdded(
        firstPart: SplitKeyIncomingFirstPart(
          keyPart: firstPart,
          tokenAddress: tokenAddress,
        ),
      );
      context.read<SplitKeyIncomingPaymentBloc>().add(event);
    }
  }

  @Deprecated('Old format of split key payment link')
  void _tryProcessSplitKeySecondPart(Uri? uri) {
    if (uri == null) return;

    final secondPart = SplitKeySecondLink.tryParse(uri);
    if (secondPart == null) return;

    final event = SplitKeyIncomingPaymentEvent.secondPartAdded(
      value: secondPart,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
