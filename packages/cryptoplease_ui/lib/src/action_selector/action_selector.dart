import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

export 'button.dart';

class CpActionSelector extends StatelessWidget {
  const CpActionSelector({
    Key? key,
    required this.header,
    required this.actions,
    this.appBarLeading,
  }) : super(key: key);

  final String header;
  final List<CpActionSelectorButton> actions;
  final Widget? appBarLeading;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(hasBorder: false, leading: appBarLeading),
        body: CpContentPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  header,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: CpColors.primaryTextColor,
                    fontSize: 21,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              ...actions,
            ],
          ),
        ),
      );
}
