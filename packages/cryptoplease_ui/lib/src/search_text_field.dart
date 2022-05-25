import 'package:cryptoplease_ui/src/colors.dart';
import 'package:flutter/material.dart';

enum CpSearchTextVariant { dark, light }

class CpSearchTextField extends StatefulWidget {
  const CpSearchTextField({
    Key? key,
    required this.label,
    required this.onClear,
    required this.onSearch,
    this.variant = CpSearchTextVariant.light,
    this.submitOnChange = true,
    this.controller,
  }) : super(key: key);

  final ValueSetter<String>? onSearch;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final String label;
  final bool submitOnChange;
  final CpSearchTextVariant variant;

  @override
  CpSearchTextFieldState createState() => CpSearchTextFieldState();
}

class CpSearchTextFieldState extends State<CpSearchTextField> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  Color get _borderColor {
    switch (widget.variant) {
      case CpSearchTextVariant.dark:
        return CpColors.accentDarkBackground;
      case CpSearchTextVariant.light:
        return CpColors.primaryColor;
    }
  }

  Color get _accentColor {
    switch (widget.variant) {
      case CpSearchTextVariant.dark:
        return CpColors.lightGreyBackground;
      case CpSearchTextVariant.light:
        return CpColors.primaryTextColor;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
  }

  void _onSearch(String text) {
    if (!widget.submitOnChange) _focusNode.unfocus();
    widget.onSearch?.call(text);
  }

  void _onClear() {
    _searchController.clear();
    _focusNode.unfocus();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) => TextField(
        cursorColor: _accentColor,
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: widget.submitOnChange ? _onSearch : null,
        onSubmitted: _onSearch,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            gapPadding: 0,
            borderSide: BorderSide(color: _borderColor),
          ),
          label: Text(widget.label),
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, widget) {
              if (value.text.isEmpty) {
                return Icon(
                  Icons.search,
                  color: _accentColor,
                );
              }

              return widget ?? const SizedBox.shrink();
            },
            child: IconButton(
              onPressed: _onClear,
              icon: Icon(
                Icons.close,
                color: _accentColor,
              ),
            ),
          ),
        ),
      );
}
