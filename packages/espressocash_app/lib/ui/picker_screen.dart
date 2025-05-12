import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../ui/app_bar.dart';
import '../../ui/colors.dart';
import '../../ui/text_field.dart';
import '../../ui/theme.dart';
import 'page_spacer_wrapper.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, {required bool selected});

typedef ItemFilter<T> = bool Function(T item, String searchQuery);
typedef ItemTapCallback<T> = Future<void> Function(T selected, BuildContext context);

class CustomPickerScreen<T> extends StatelessWidget {
  const CustomPickerScreen({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.title,
    this.initial,
    this.onTap,
    this.filterItem,
    this.searchPlaceholder,
  });

  static Future<void> open<T>(
    BuildContext context, {
    NavigatorState? navigator,
    required String title,
    required List<T> items,
    required ItemBuilder<T> itemBuilder,
    T? initial,
    Future<void> Function(T selected, BuildContext context)? onTap,
    ItemFilter<T>? filterItem,
    String? searchPlaceholder,
  }) => (navigator ?? Navigator.of(context, rootNavigator: true)).pushAndRemoveUntil<T>(
    PageRouteBuilder(
      pageBuilder:
          (context, _, _) => CustomPickerScreen<T>(
            title: title,
            items: items,
            itemBuilder: itemBuilder,
            initial: initial,
            onTap: onTap,
            filterItem: filterItem,
            searchPlaceholder: searchPlaceholder,
          ),
      transitionDuration: Duration.zero,
    ),
    F,
  );

  static Future<void> push<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required ItemBuilder<T> itemBuilder,
    T? initial,
    Future<void> Function(T selected, BuildContext context)? onTap,
    ItemFilter<T>? filterItem,
    String? searchPlaceholder,
  }) => Navigator.of(context).push<void>(
    MaterialPageRoute(
      builder:
          (context) => CustomPickerScreen<T>(
            title: title,
            items: items,
            itemBuilder: itemBuilder,
            initial: initial,
            onTap: onTap,
            filterItem: filterItem,
            searchPlaceholder: searchPlaceholder,
          ),
    ),
  );

  final String title;
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final T? initial;
  final ItemTapCallback<T>? onTap;
  final ItemFilter<T>? filterItem;
  final String? searchPlaceholder;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.deepGreyColor,
      appBar: CpAppBar(title: Text(title.toUpperCase())),
      body: _Wrapper(
        child: _Content<T>(
          items: items,
          itemBuilder: itemBuilder,
          initial: initial,
          onTap: onTap,
          filterItem: filterItem,
          searchPlaceholder: searchPlaceholder,
        ),
      ),
    ),
  );
}

class _Content<T> extends StatefulWidget {
  const _Content({
    required this.items,
    required this.itemBuilder,
    this.initial,
    this.onTap,
    this.filterItem,
    this.searchPlaceholder,
  });

  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final T? initial;
  final ItemTapCallback<T>? onTap;
  final ItemFilter<T>? filterItem;
  final String? searchPlaceholder;

  @override
  State<_Content<T>> createState() => _ContentState<T>();
}

class _ContentState<T> extends State<_Content<T>> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  T? _selectedItem;
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _selectedItem = widget.initial;

    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text);
    });

    final item = _selectedItem;
    if (item != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = widget.items.indexOf(item);
        final centerOffset = ((context.size?.height ?? 0) - _tileHeight) / 2.5;
        final offset = index * _tileHeight - centerOffset;
        _scrollController.jumpTo(offset);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        widget.items.where((item) {
          final filter = widget.filterItem;

          return filter != null
              ? filter(item, _searchText)
              : item.toString().toLowerCase().contains(_searchText.toLowerCase());
        }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CpTextField(
            controller: _searchController,
            autocorrect: false,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            fontSize: 16,
            border: CpTextFieldBorder.stadium,
            placeholder: widget.searchPlaceholder ?? context.l10n.searchPlaceholder,
            backgroundColor: CpColors.blackTextFieldBackgroundColor,
            textColor: Colors.white,
            inputType: TextInputType.text,
          ),
        ),
        if (filteredItems.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                context.l10n.noResultsFound,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: filteredItems.length,
              itemExtent: _tileHeight,
              itemBuilder: (BuildContext context, int index) {
                final item = filteredItems[index];
                final selected = item == _selectedItem;

                return DecoratedBox(
                  decoration:
                      selected
                          ? const ShapeDecoration(
                            color: CpColors.blackTextFieldBackgroundColor,
                            shape: StadiumBorder(),
                          )
                          : const BoxDecoration(),
                  child: ListTile(
                    dense: true,
                    title: widget.itemBuilder(context, item, selected: selected),
                    selectedColor: Colors.white,
                    shape: selected ? const StadiumBorder() : null,
                    onTap: () async {
                      await widget.onTap?.let((onTap) => onTap(item, context));

                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      child,
      const Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: FadeGradient(height: 100, direction: FadeGradientDirection.bottomUp),
      ),
    ],
  );
}

const _tileHeight = 46.0;
