import 'package:cryptoplease/features/profile/components/menu_header.dart';
import 'package:cryptoplease/features/profile/components/menu_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Column(
          children: const [
            MenuHeader(),
            MenuSection(),
          ],
        ),
      );
}
