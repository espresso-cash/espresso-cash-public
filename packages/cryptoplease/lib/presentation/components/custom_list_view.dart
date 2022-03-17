import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.emptyWidget,
    this.padding,
  }) : super(key: key);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Widget emptyWidget;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Widget content;
    if (itemCount == 0) {
      final empty = CpTheme.light(child: emptyWidget);
      content = SliverToBoxAdapter(child: empty);
    } else {
      content = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemBuilder(context, index),
                Container(
                  color: CpColors.listDividerColor,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ],
            ),
          ),
          childCount: itemCount,
        ),
      );
    }

    return CpTheme.dark(
      child: Material(
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
            ),
            if (padding == null)
              content
            else
              SliverPadding(padding: padding!, sliver: content),
            // SliverFil
          ],
        ),
      ),
    );
  }
}
