import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../models/network.dart';

@RoutePage()
class NetworkPickerScreen extends StatelessWidget {
  const NetworkPickerScreen({
    super.key,
    this.initial,
    required this.onSubmitted,
  });

  static const route = NetworkPickerRoute.new;

  final Network? initial;
  final ValueSetter<Network> onSubmitted;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text('Networks'.toUpperCase()),
          ),
          body: _Content(
            initial: initial,
            onSubmitted: onSubmitted,
          ),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({
    this.initial,
    required this.onSubmitted,
  });

  final Network? initial;
  final ValueSetter<Network> onSubmitted;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final ScrollController _scrollController = ScrollController();

  Network? _selectedNetwork;

  final _networks = networks;

  @override
  void initState() {
    super.initState();

    _selectedNetwork = widget.initial;

    final network = _selectedNetwork;
    if (network != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = _networks.indexOf(network);
        final centerOffset = (context.size?.height ?? 0 - _tileHeight) / 2.5;
        final offset = index * _tileHeight - centerOffset;
        _scrollController.jumpTo(offset);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
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
                      network.name,
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
