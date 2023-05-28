import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/tokens/token.dart';
import '../../../../../ui/colors.dart';

class TokenDropDown extends StatelessWidget {
  const TokenDropDown({
    super.key,
    required this.current,
    required this.onTokenChanged,
    required this.availableTokens,
  });

  final Token current;
  final ValueSetter<Token> onTokenChanged;
  final Iterable<Token> availableTokens;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: _TokenDropDown(
          value: current,
          onChanged: (it) => it == current ? ignore : onTokenChanged(it),
          items: availableTokens.toList(),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
    final title = Text(label, textAlign: TextAlign.center, style: style);
    final color = selected
        ? CpColors.greenDropdownEnabled
        : CpColors.greenDropdownDisabled;

    final Widget child;

    if (selected) {
      child = Row(
        children: [
          const SizedBox(width: _iconSize),
          Expanded(child: title),
          const Icon(Icons.expand_more, size: _iconSize)
        ],
      );
    } else {
      child = Center(child: title);
    }

    return SizedBox(
      height: _itemHeight,
      width: _width,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: child,
      ),
    );
  }
}

class _TokenDropDown extends StatefulWidget {
  const _TokenDropDown({
    required this.onChanged,
    required this.value,
    required this.items,
  });

  final Token value;
  final List<Token> items;
  final ValueSetter<Token> onChanged;

  @override
  State<_TokenDropDown> createState() => _TokenDropDownState();
}

class _TokenDropDownState extends State<_TokenDropDown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  late OverlayEntry _overlayEntry;
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
    _overlayEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: _layerLink,
        child: _Item(
          onTap: _toggleDropdown,
          label: widget.value.symbol,
          selected: true,
        ),
      );

  OverlayEntry _createOverlayEntry() {
    // ignore: cast_nullable_to_non_nullable, RenderBox is not nullable
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final offset = renderBox.localToGlobal(Offset.zero);
    final topOffset = offset.dy + size.height;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        children: widget.items
                            .where((e) => e != widget.value)
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: _spacing,
                                ),
                                child: _Item(
                                  onTap: () {
                                    widget.onChanged.call(item);
                                    _toggleDropdown();
                                  },
                                  label: item.symbol,
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
      _overlayEntry.remove();
      if (!mounted) return;

      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      if (!mounted) return;
      setState(() => _isOpen = true);

      await _animationController.forward();
    }
  }
}

const _width = 250.0;
const _itemHeight = 55.0;
const _spacing = 8.0;
const _iconSize = 24.0;
