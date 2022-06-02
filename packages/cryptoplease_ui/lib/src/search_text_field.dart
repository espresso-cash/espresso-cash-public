import 'package:cryptoplease_ui/src/colors.dart';
import 'package:flutter/material.dart';

enum CpSearchTextVariant { dark, light }

class CpSearchTextField extends StatefulWidget {
  const CpSearchTextField({
    Key? key,
    required this.label,
    required this.onSearch,
    this.variant = CpSearchTextVariant.light,
    this.controller,
  }) : super(key: key);

  final ValueSetter<String> onSearch;
  final TextEditingController? controller;
  final String label;
  final CpSearchTextVariant variant;

  @override
  CpSearchTextFieldState createState() => CpSearchTextFieldState();
}

class CpSearchTextFieldState extends State<CpSearchTextField> {
  late final TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();

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
  }

  void _onSearch(String text) {
    widget.onSearch(text);
  }

  void _onClear() {
    _searchController.clear();
    _focusNode.unfocus();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) => TextField(
        cursorColor: _accentColor,
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: _onSearch,
        onSubmitted: _onSearch,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            gapPadding: 0,
            borderSide: BorderSide(color: _borderColor),
          ),
          label: Text(widget.label),
          labelStyle: _labelStyle,
          prefixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, widget) => value.text.isEmpty
                ? Icon(Icons.search, color: _accentColor)
                : widget ?? const SizedBox.shrink(),
            child: IconButton(
              onPressed: _onClear,
              icon: Icon(Icons.close, color: _accentColor),
            ),
          ),
        ),
      );
}

const _labelStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
);
