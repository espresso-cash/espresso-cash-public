import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/colors.dart';
import '../../ui/rounded_rectangle.dart';

final cpRoundedRectangle = Story(
  name: 'CpRoundedRectangle',
  builder:
      (_) => Padding(
        padding: const EdgeInsets.all(32),
        child: GridView.count(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CpRoundedRectangle(
              backgroundColor: CpColors.successBackgroundColor,
              child: Center(child: Text('Custom color', style: TextStyle(color: Colors.white))),
            ),
            CpRoundedRectangle(
              child: Center(child: Text('Default color', style: TextStyle(color: Colors.white))),
            ),
            ColoredBox(
              color: Colors.blue,
              child: CpRoundedRectangle(
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(32),
                child: ColoredBox(
                  color: Colors.red,
                  child: Center(
                    child: Text('Custom margin & padding', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 100,
                child: CpRoundedRectangle(
                  child: Center(child: Text('Smaller size', style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ),
);
