import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client_example/client.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ClientBloc(
        SolanaClient(
          rpcUrl: Uri.parse('https://api.testnet.solana.com'),
          websocketUrl: Uri.parse('wss://api.testnet.solana.com'),
        ),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: BlocConsumer<ClientBloc, ClientState>(
            listener: (context, state) {
              // ignore: avoid_print, only for example
              print(state.capabilities);
            },
            listenWhen: (previous, current) =>
                previous.capabilities != current.capabilities,
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Text(
                    'Public key: ${state.address ?? '<none>'}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Button(
                  onPressed: () =>
                      context.read<ClientBloc>().requestCapabilities(),
                  text: 'Get capabilities',
                ),
                Button(
                  onPressed: () => context.read<ClientBloc>().authorize(),
                  text: 'Authorize',
                ),
                Button(
                  onPressed: state.isAuthorized
                      ? () => context.read<ClientBloc>().reauthorize()
                      : null,
                  text: 'Reauthorize',
                ),
                Button(
                  onPressed: state.isAuthorized
                      ? () => context.read<ClientBloc>().deauthorize()
                      : null,
                  text: 'Deauthorize',
                ),
                Button(
                  onPressed: state.canRequestAirdrop
                      ? () => context.read<ClientBloc>().requestAirdrop()
                      : null,
                  text: 'Request airdrop',
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SignTxButton(count: 1, text: 'Sign txn x1'),
                    ),
                    Expanded(child: SignTxButton(count: 3, text: 'x3')),
                    Expanded(child: SignTxButton(count: 20, text: 'x20')),
                  ],
                ),
                Button(
                  onPressed: () =>
                      context.read<ClientBloc>().authorizeAndSignTransactions(),
                  text: 'Combined authorize and sign txn x1',
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SignMsgButton(count: 1, text: 'Sign msg x1'),
                    ),
                    Expanded(child: SignMsgButton(count: 3, text: 'x3')),
                    Expanded(child: SignMsgButton(count: 20, text: 'x20')),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SignAndSendTxButton(
                        count: 1,
                        text: 'Sign and send txn x1',
                      ),
                    ),
                    Expanded(child: SignAndSendTxButton(count: 3, text: 'x3')),
                    Expanded(
                      child: SignAndSendTxButton(count: 20, text: 'x20'),
                    ),
                  ],
                ),
                Footer(
                  hasAuthToken: state.isAuthorized,
                  accountName: state.authorizationResult?.accountLabel,
                  walletUriPrefix: state.authorizationResult?.walletUriBase,
                ),
              ],
            ),
          ),
        ),
      );
}

class SignAndSendTxButton extends StatelessWidget {
  const SignAndSendTxButton({
    super.key,
    required this.text,
    required this.count,
  });

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) => Button(
        onPressed: context.watch<ClientBloc>().state.isAuthorized
            ? () => context.read<ClientBloc>().signAndSendTransactions(count)
            : null,
        text: text,
      );
}

class SignMsgButton extends StatelessWidget {
  const SignMsgButton({
    super.key,
    required this.text,
    required this.count,
  });

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) => Button(
        onPressed: context.watch<ClientBloc>().state.isAuthorized
            ? () => context.read<ClientBloc>().signMessages(count)
            : null,
        text: text,
      );
}

class SignTxButton extends StatelessWidget {
  const SignTxButton({
    super.key,
    required this.text,
    required this.count,
  });

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) => Button(
        onPressed: context.watch<ClientBloc>().state.isAuthorized
            ? () => context.read<ClientBloc>().signTransactions(count)
            : null,
        text: text,
      );
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      );
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.hasAuthToken,
    required this.accountName,
    required this.walletUriPrefix,
  });

  final bool hasAuthToken;
  final String? accountName;
  final Uri? walletUriPrefix;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FooterRow(
              title: 'Has auth token?',
              value: SizedBox.square(
                dimension: 18,
                child: Checkbox(value: hasAuthToken, onChanged: null),
              ),
            ),
            FooterRow(
              title: 'Account Name:',
              value: Text(accountName ?? '<none>'),
            ),
            FooterRow(
              title: 'Wallet Uri Prefix:',
              value: Text(walletUriPrefix?.toString() ?? '<none>'),
            ),
          ],
        ),
      );
}

class FooterRow extends StatelessWidget {
  const FooterRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            value,
          ],
        ),
      );
}
