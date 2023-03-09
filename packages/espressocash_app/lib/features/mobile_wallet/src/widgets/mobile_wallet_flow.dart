import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di.dart';
import '../../../../ui/app_bar.dart';
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
        create: (_) => sl<MobileWalletBloc>(param1: request),
        child: const _Content(),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(),
        body: BlocBuilder<MobileWalletBloc, MobileWalletState>(
          builder: (context, state) => Center(
            child: Text(
              state.toString(),
            ),
          ),
        ),
      );
}
