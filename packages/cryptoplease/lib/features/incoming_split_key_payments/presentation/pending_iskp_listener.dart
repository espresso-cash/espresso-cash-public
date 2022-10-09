import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/dynamic_links/dynamic_links_notifier.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/pending_iskp.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/pending_iskp_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingISKPListener extends StatefulWidget {
  const PendingISKPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingISKPListener> createState() => _PendingISKPListenerState();
}

class _PendingISKPListenerState extends State<PendingISKPListener> {
  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final existing = await context.read<PendingISKPRepository>().load();
    if (existing != null) {
      if (!mounted) return;

      _openFirstPartReadyScreen();
    }
  }

  void _openFirstPartReadyScreen() {
    context.router.push(
      FirstPartReadyRoute(
        onCancel: () => context.read<PendingISKPRepository>().clear(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final firstPart = ISKPFirstPart.tryParse(link);
      if (firstPart != null) {
        context.read<PendingISKPRepository>().save(firstPart);
        _openFirstPartReadyScreen();

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
