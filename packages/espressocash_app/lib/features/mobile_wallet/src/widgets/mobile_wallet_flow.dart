import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../di.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/button.dart';
import '../../../../ui/theme.dart';
import '../bl/bloc.dart';
import '../models/remote_request.dart';

class RemoteRequestScreen extends StatelessWidget {
  const RemoteRequestScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  final RemoteRequest request;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => sl<RemoteRequestBloc>(
          param1: request,
          param2: context.read<MyAccount>(),
        ),
        child: const _Content(),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  void _onAccept() => context
      .read<RemoteRequestBloc>()
      .add(const RemoteRequestEvent.accepted());

  void _onDecline() => context
      .read<RemoteRequestBloc>()
      .add(const RemoteRequestEvent.declined());

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Scaffold(
          appBar: CpAppBar(
            title: const Text('Espresso Cash Wallet'),
          ),
          body: BlocConsumer<RemoteRequestBloc, RemoteRequestState>(
            listener: (context, state) => state.whenOrNull(
              result: (r) => context.router.pop(r),
            ),
            builder: (context, state) => state.when(
              result: always(
                const Center(child: CircularProgressIndicator()),
              ),
              requested: (request) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      request.when(
                        authorizeDapp: (it) =>
                            _AuthorizeRequestWidget(request: it),
                        signPayloads: (it) => _SignPayloadsWidget(request: it),
                        signTransactionsForSending: (it) =>
                            _SignAndSendPayloadsWidget(request: it),
                      ),
                      const Spacer(),
                      _Buttons(
                        onAccept: _onAccept,
                        onDecline: _onDecline,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CpButton(text: 'Decline', onPressed: onDecline),
            CpButton(text: 'Accept', onPressed: onAccept),
          ],
        ),
      );
}

class _AuthorizeRequestWidget extends StatelessWidget {
  const _AuthorizeRequestWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final AuthorizeRequest request;

  @override
  Widget build(BuildContext context) {
    final name = request.identityName ?? '';
    final identityUri = request.identityUri;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DAppIcon(
          identityUri: identityUri,
          iconUri: request.iconUri,
        ),
        const SizedBox(height: 16),
        Text('Authorize $name?', style: _titleStyle),
        const SizedBox(height: 8),
        if (identityUri != null) Text(identityUri.toString()),
      ],
    );
  }
}

class _SignPayloadsWidget extends StatelessWidget {
  const _SignPayloadsWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final SignPayloadsRequest request;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DAppIcon(
            identityUri: request.identityUri,
            iconUri: request.iconRelativeUri,
          ),
          const SizedBox(height: 16),
          Text(
            request.map(
              transactions: always('Sign Transaction(s)'),
              messages: always('Sign Message(s)'),
            ),
            style: _titleStyle,
          ),
          const SizedBox(height: 8),
          Text(
            '${request.identityName} is requesting you to sign ${request.payloads.length} payload(s)',
          ),
        ],
      );
}

class _SignAndSendPayloadsWidget extends StatelessWidget {
  const _SignAndSendPayloadsWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final SignAndSendTransactionsRequest request;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DAppIcon(
            identityUri: request.identityUri,
            iconUri: request.iconRelativeUri,
          ),
          const SizedBox(height: 16),
          const Text('Sign and Send Transaction(s)', style: _titleStyle),
          const SizedBox(height: 8),
          Text(
            '${request.identityName} is requesting you to sign ${request.transactions.length} transactions(s)',
          ),
          const SizedBox(height: 8),
          const Text(
            'These transactions will be immediately submitted after signing.',
          ),
        ],
      );
}

class _DAppIcon extends StatelessWidget {
  const _DAppIcon({
    Key? key,
    required this.iconUri,
    required this.identityUri,
  }) : super(key: key);

  final Uri? iconUri;
  final Uri? identityUri;

  @override
  Widget build(BuildContext context) {
    final identityUri = this.identityUri;
    Uri? iconUri = this.iconUri;

    if (identityUri != null && iconUri != null && identityUri.isAbsolute) {
      iconUri = identityUri.replace(
        pathSegments: [
          ...identityUri.pathSegments,
          Uri.encodeFull(iconUri.toString()),
        ],
      );
    }

    if (iconUri == null) return const SizedBox.shrink();

    return Image.network(iconUri.toString());
  }
}

const _titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
