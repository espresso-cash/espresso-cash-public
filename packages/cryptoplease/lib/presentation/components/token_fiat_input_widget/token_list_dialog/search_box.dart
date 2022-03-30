import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          isDense: true,
          hintText: context.l10n.search,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CpColors.primaryColor,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CpColors.secondaryTextColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 22,
          ),
        ),
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 20,
            ),
      );
}
