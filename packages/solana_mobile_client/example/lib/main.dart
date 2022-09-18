import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_client_example/client.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ClientBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              ],
            ),
          ),
        ),
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
