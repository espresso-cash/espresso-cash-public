// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../features/blockchain/models/blockchain.dart';

final _supportedEvmChains = <Blockchain>[
  Blockchain.arbitrum,
  Blockchain.polygon,
  Blockchain.ethereum,
];

class BlockchainDropDown extends StatelessWidget {
  const BlockchainDropDown({
    super.key,
    required this.current,
    required this.onBlockchainChanged,
  });

  final Blockchain current;
  final ValueSetter<Blockchain> onBlockchainChanged;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: _BlockchainDropDown(
          value: current,
          onChanged: (it) => it == current ? ignore : onBlockchainChanged(it),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.chain,
    required this.selected,
    required this.onTap,
  });

  final Blockchain chain;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _itemHeight,
        width: _width,
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: StadiumBorder(),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  chain.logo.image(
                    height: 40,
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      chain.displayName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.13,
                      ),
                    ),
                  ),
                  if (selected)
                    const Icon(
                      Icons.expand_more,
                      size: _iconSize,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _BlockchainDropDown extends StatefulWidget {
  const _BlockchainDropDown({
    required this.onChanged,
    required this.value,
  });

  final Blockchain value;
  final ValueSetter<Blockchain> onChanged;

  @override
  State<_BlockchainDropDown> createState() => _BlockchainDropDownState();
}

class _BlockchainDropDownState extends State<_BlockchainDropDown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: _layerLink,
        child: _Item(
          onTap: _toggleDropdown,
          chain: widget.value,
          selected: true,
        ),
      );

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    final offset = renderBox.localToGlobal(Offset.zero);
    final topOffset = offset.dy + size.height;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 0,
                    color: Colors.transparent,
                    shape: const StadiumBorder(),
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        controller: _scrollController,
                        children: _supportedEvmChains
                            .where((e) => e != widget.value)
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: _spacing,
                                ),
                                child: _Item(
                                  onTap: () {
                                    widget.onChanged(item);
                                    _toggleDropdown();
                                  },
                                  chain: item,
                                  selected: widget.value == item,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      if (!mounted) return;

      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry().also(Overlay.of(context).insert);
      if (!mounted) return;
      setState(() => _isOpen = true);

      await _animationController.forward();
    }
  }
}

const _width = 250.0;
const _itemHeight = 55.0;
const _spacing = 4.0;
const _iconSize = 24.0;
