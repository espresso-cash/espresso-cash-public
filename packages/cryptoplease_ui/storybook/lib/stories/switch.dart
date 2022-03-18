import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpSwitch = Story(
  name: 'CpSwitch',
  builder: (context) => const SafeArea(
    child: _Content(),
  ),
);

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _switch1 = true;
  bool _switch2 = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CpSwitch(
            title: 'Switch 1',
            value: _switch1,
            onChanged: (value) => setState(() => _switch1 = value),
            padding: const EdgeInsets.all(16),
          ),
          CpSwitch(
            title: 'Switch 2',
            value: _switch2,
            onChanged: (value) => setState(() => _switch2 = value),
            padding: const EdgeInsets.all(16),
          ),
        ],
      );
}
