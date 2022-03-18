import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    Key? key,
    required this.fields,
    required this.title,
  }) : super(key: key);

  final Map<String, Widget> fields;
  final String title;

  @override
  Widget build(BuildContext context) => Column(
        children: fields.entries
            .map((entry) => _DetailsRow(label: entry.key, value: entry.value))
            .toList(growable: false),
      );
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: CpColors.listDividerColor,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: CpColors.primaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                    ),
              ),
              value,
            ],
          ),
        ),
      );
}
