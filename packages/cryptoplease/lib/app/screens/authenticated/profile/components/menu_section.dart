import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: CpColors.lightGreyBackground,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4),
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: CpColors.menuPrimaryTextColor,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Material(
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
