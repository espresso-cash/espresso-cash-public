import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/profile/components/menu_header.dart';
import 'package:cryptoplease/features/profile/components/menu_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Column(
          children: [
            MenuHeader(
              selectedToken: Token.sol,
              onDropdownTap: () {},
            ),
            const MenuSection(),
          ],
        ),
      );
}
