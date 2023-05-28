import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/button.dart';
import '../../../../ui/theme.dart';
import '../bl/bloc.dart';
import '../models/remote_request.dart';

class RemoteRequestScreen extends StatelessWidget {
  const RemoteRequestScreen({
    super.key,
    required this.request,
  });

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
  const _Content();

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
            title: Text(context.l10n.mobileWalletTitle),
          ),
          body: BlocConsumer<RemoteRequestBloc, RemoteRequestState>(
            listener: (context, state) => state.whenOrNull(
              result: (r) => context.router.pop(r),
            ),
            builder: (context, state) => state.when(
              loading: always(
                const Center(child: CircularProgressIndicator()),
              ),
              result: always(
                const Center(child: CircularProgressIndicator()),
              ),
              requested: (request) {
                final content = request.when(
                  authorizeDapp: (it) => _AuthorizeRequestWidget(request: it),
                  signPayloads: (it) => _SignPayloadsWidget(request: it),
                  signTransactionsForSending: (it) =>
                      _SignAndSendPayloadsWidget(request: it),
                );

                final acceptLabel = request.when(
                  authorizeDapp: always(
                    context.l10n.mobileWalletAcceptAuthorization,
                  ),
                  signTransactionsForSending: always(
                    context.l10n.mobileWalletAcceptSignAndSendPayloads,
                  ),
                  signPayloads: (it) => it.map(
                    messages:
                        always(context.l10n.mobileWalletAcceptSignMessages),
                    transactions:
                        always(context.l10n.mobileWalletAcceptSignTransactions),
                  ),
                );

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        content,
                        const Spacer(),
                        _Buttons(
                          acceptLabel: acceptLabel,
                          onAccept: _onAccept,
                          onDecline: _onDecline,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.acceptLabel,
    required this.onAccept,
    required this.onDecline,
  });

  final String acceptLabel;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CpButton(text: context.l10n.cancel, onPressed: onDecline),
            CpButton(text: acceptLabel, onPressed: onAccept),
          ],
        ),
      );
}

class _AuthorizeRequestWidget extends StatelessWidget {
  const _AuthorizeRequestWidget({required this.request});

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
        Text(
          context.l10n.mobileWalletAuthorize(name),
          style: _titleStyle,
        ),
        const SizedBox(height: 8),
        if (identityUri != null) Text(identityUri.toString()),
      ],
    );
  }
}

class _SignPayloadsWidget extends StatelessWidget {
  const _SignPayloadsWidget({required this.request});

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
              transactions: always(context.l10n.mobileWalletSignTransactions),
              messages: always(context.l10n.mobileWalletSignMessages),
            ),
            style: _titleStyle,
          ),
          const SizedBox(height: 8),
          Text(
            request.map(
              transactions: (it) =>
                  context.l10n.mobileWalletSignTransactionsRequest(
                it.identityName ?? '',
                it.payloads.length,
              ),
              messages: (it) => context.l10n.mobileWalletSignMessagesRequest(
                it.identityName ?? '',
                it.payloads.length,
              ),
            ),
          ),
        ],
      );
}

class _SignAndSendPayloadsWidget extends StatelessWidget {
  const _SignAndSendPayloadsWidget({required this.request});

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
          Text(
            context.l10n.mobileWalletSignAndSendTransactions,
            style: _titleStyle,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.mobileWalletSignTransactionsRequest(
              request.identityName ?? '',
              request.transactions.length,
            ),
          ),
          const SizedBox(height: 8),
          Text(context.l10n.mobileWalletSendTransactions),
        ],
      );
}

class _DAppIcon extends StatelessWidget {
  const _DAppIcon({
    required this.iconUri,
    required this.identityUri,
  });

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
