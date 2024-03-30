import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../blockchain/models/blockchain.dart';
import '../../feature_flags/services/feature_flags_manager.dart';

class NetworkPickerScreen extends StatelessWidget {
  const NetworkPickerScreen({
    super.key,
    this.initial,
    required this.onSubmitted,
  });

  final Blockchain? initial;
  final ValueSetter<Blockchain> onSubmitted;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(context.l10n.walletNetworks.toUpperCase()),
          ),
          body: _Content(
            initial: initial,
            onSubmitted: onSubmitted,
          ),
        ),
      );
}

class NetworkPickerRoute extends GoRouteData {
  const NetworkPickerRoute(this.$extra);

  final NetworkPickerParams $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NetworkPickerScreen(
        initial: $extra.initial,
        onSubmitted: $extra.onSubmitted,
      );
}

typedef NetworkPickerParams = ({
  Blockchain? initial,
  ValueSetter<Blockchain> onSubmitted,
});

class _Content extends StatefulWidget {
  const _Content({
    this.initial,
    required this.onSubmitted,
  });

  final Blockchain? initial;
  final ValueSetter<Blockchain> onSubmitted;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  Blockchain? _selectedNetwork;

  late final List<Blockchain> _networks;

  @override
  void initState() {
    super.initState();

    _networks = sl<FeatureFlagsManager>().isOutgoingDlnEnabled()
        ? Blockchain.values
        : const [Blockchain.solana];

    _selectedNetwork = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: 32,
                left: 20,
                right: 20,
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: _networks.length,
              itemExtent: _tileHeight,
              itemBuilder: (BuildContext context, int index) {
                final network = _networks[index];
                final selected = network == _selectedNetwork;

                return DecoratedBox(
                  decoration: selected
                      ? const ShapeDecoration(
                          color: Color(0xff404040),
                          shape: StadiumBorder(),
                        )
                      : const BoxDecoration(),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      network.displayName,
                      style: TextStyle(fontSize: selected ? 19 : 17),
                    ),
                    selectedColor: Colors.white,
                    shape: selected ? const StadiumBorder() : null,
                    onTap: () => widget.onSubmitted(network),
                  ),
                );
              },
            ),
          ),
        ],
      );
}

const _tileHeight = 46.0;
