import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpContentPadding = Story(
  name: 'CpContentPadding',
  builder: (context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        color: Colors.yellow,
        width: 200,
        height: 200,
        child: Container(
          color: Colors.green,
          width: 200,
          height: 200,
          child: const Center(child: Text('Without padding')),
        ),
      ),
      const SizedBox(height: 32),
      Container(
        color: Colors.yellow,
        width: 200,
        height: 200,
        child: CpContentPadding(
          child: Container(
            color: Colors.green,
            width: 200,
            height: 200,
            child: const Center(child: Text('With padding')),
          ),
        ),
      ),
    ],
  ),
);
