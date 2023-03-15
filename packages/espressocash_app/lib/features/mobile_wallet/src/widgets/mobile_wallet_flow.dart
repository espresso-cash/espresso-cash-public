import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../di.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/theme.dart';
import '../bl/bloc.dart';
import '../models/remote_request.dart';

class MobileWalletFlow extends StatelessWidget {
  const MobileWalletFlow({
    Key? key,
    required this.request,
  }) : super(key: key);

  final RemoteRequest request;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => sl<MobileWalletBloc>(
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
  void _onAccept() =>
      context.read<MobileWalletBloc>().add(const MobileWalletEvent.accepted());

  void _onDecline() =>
      context.read<MobileWalletBloc>().add(const MobileWalletEvent.declined());

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<MobileWalletBloc, MobileWalletState>(
              listener: (context, state) => state.whenOrNull(
                result: (r) => context.router.pop(r),
              ),
              builder: (context, state) => state.when(
                result:
                    always(const Center(child: CircularProgressIndicator())),
                requested: (r) => _RequestWidget(
                  message: r.map(
                    authorizeDapp: always('authorizeDapp'),
                    signPayloads: always('signPayloads'),
                    signTransactionsForSending:
                        always('signTransactionsForSending'),
                  ),
                  onAccept: _onAccept,
                  onDecline: _onDecline,
                ),
              ),
            ),
          ),
        ),
      );
}

class _RequestWidget extends StatelessWidget {
  const _RequestWidget({
    Key? key,
    required this.message,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  final String message;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(message),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onDecline,
                child: const Text(
                  'Decline',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: onAccept,
                child: const Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      );
}
