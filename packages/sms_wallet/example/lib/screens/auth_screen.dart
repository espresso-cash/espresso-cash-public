import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_wallet/sms_wallet.dart';
import 'package:sms_wallet_example/mobile_wallet/bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  final AuthorizeRequest request;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Uri? _iconUri;

  @override
  void initState() {
    super.initState();
    final identityUri = Uri.tryParse(widget.request.identityUri ?? '');
    final iconUri = widget.request.iconUri;

    if (identityUri != null && iconUri != null && identityUri.isAbsolute) {
      _iconUri = identityUri.replace(
        pathSegments: [
          ...identityUri.pathSegments,
          Uri.encodeFull(iconUri),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconUri = _iconUri;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Authorize dapp', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          if (iconUri != null) Image.network(iconUri.toString()),
          Text(widget.request.identityName ?? '<no name>'),
          Text(widget.request.identityUri ?? '<no URI>'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => context.read<MobileWalletBloc>().authorizeDapp(
                      isAuthorized: true,
                      scopeTag: 'app',
                      qualifier: null,
                    ),
                child: const Text('Authorize'),
              ),
              ElevatedButton(
                onPressed: () => context.read<MobileWalletBloc>().authorizeDapp(
                      isAuthorized: false,
                      scopeTag: 'app',
                      qualifier: null,
                    ),
                child: const Text('Decline'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
