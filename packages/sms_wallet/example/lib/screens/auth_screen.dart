import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_wallet_example/mobile_wallet/bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
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
      );
}
