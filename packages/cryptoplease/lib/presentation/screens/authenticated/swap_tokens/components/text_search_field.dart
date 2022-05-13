import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TextSearchFieldWidget extends StatefulWidget {
  const TextSearchFieldWidget({
    Key? key,
    required this.onClear,
    required this.onSearch,
    this.submitOnChange = true,
    this.controller,
  }) : super(key: key);

  final ValueSetter<String>? onSearch;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool submitOnChange;

  @override
  _TextSearchFieldWidgetState createState() => _TextSearchFieldWidgetState();
}

class _TextSearchFieldWidgetState extends State<TextSearchFieldWidget> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

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
        cursorColor: CpColors.lightGreyBackground,
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: widget.submitOnChange ? _onSearch : null,
        onSubmitted: _onSearch,
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            gapPadding: 0,
            borderSide: BorderSide(color: CpColors.accentDarkBackground),
          ),
          label: const Text('Search...'),
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, widget) {
              if (value.text.isEmpty) {
                return const Icon(
                  Icons.search,
                  color: CpColors.lightGreyBackground,
                );
              }

              return widget!;
            },
            child: IconButton(
              onPressed: _onClear,
              icon: const Icon(
                Icons.close,
                color: CpColors.lightGreyBackground,
              ),
            ),
          ),
        ),
      );
}
