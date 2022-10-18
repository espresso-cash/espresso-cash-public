import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';

class CpHeaderedListContent extends StatelessWidget {
  const CpHeaderedListContent({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.emptyWidget,
    this.padding,
    this.showDivider = true,
    this.footer,
    this.primary,
  }) : super(key: key);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Widget emptyWidget;
  final EdgeInsets? padding;
  final bool showDivider;
  final Widget? footer;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    final Widget content = itemCount == 0
        ? SliverToBoxAdapter(child: emptyWidget)
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  itemBuilder(context, index),
                  if (showDivider)
                    Container(
                      color: CpColors.listDividerColor,
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                ],
              ),
              childCount: itemCount,
            ),
          );

    final padding = this.padding;

    return CpTheme.light(
      child: Material(
        color: Colors.white,
        child: CustomScrollView(
          primary: primary,
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
            ),
            if (padding == null)
              content
            else
              SliverPadding(padding: padding, sliver: content),
            if (footer != null) SliverToBoxAdapter(child: footer)
          ],
        ),
      ),
    );
  }
}
