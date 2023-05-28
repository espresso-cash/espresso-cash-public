import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/switch.dart';

final cpSwitch = Story(
  name: 'CpSwitch',
  builder: (context) => const SafeArea(
    child: _Content(),
  ),
);

class _Content extends StatefulWidget {
  const _Content();

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _switch1 = true;
  bool _switch2 = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            title: const Text('Switch 1'),
            trailing: CpSwitch(
              value: _switch1,
              onChanged: (value) => setState(() => _switch1 = value),
            ),
          ),
          ListTile(
            title: const Text('Switch 2'),
            trailing: CpSwitch(
              value: _switch2,
              onChanged: (value) => setState(() => _switch2 = value),
            ),
          ),
        ],
      );
}
