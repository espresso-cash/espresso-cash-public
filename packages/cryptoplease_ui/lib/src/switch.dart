import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CpSwitch extends StatefulWidget {
  const CpSwitch({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String title;
  final bool value;
  final void Function(bool) onChanged;
  final EdgeInsets padding;

  @override
  State<CpSwitch> createState() => _CpSwitchState();
}

class _CpSwitchState extends State<CpSwitch> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.padding,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.subtitle2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CupertinoSwitch(
              value: widget.value,
              onChanged: widget.onChanged,
              thumbColor: widget.value ? Colors.white : CpColors.yellowColor,
              activeColor: CpColors.yellowColor,
              trackColor: const Color(0xffdb5936),
            ),
          ],
        ),
      );
}
