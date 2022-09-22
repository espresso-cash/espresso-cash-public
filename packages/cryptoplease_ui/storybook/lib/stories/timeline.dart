import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpTimeline = Story(
  name: 'CpTimeline',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: CpTimelineWidget(
      data: context.knobs.options(
        label: 'Data',
        initial: _data,
        options: [
          Option(label: 'With Data', value: _data),
          const Option(label: 'Empty', value: []),
        ],
      ),
      backgroundColor: context.knobs.options(
        label: 'Background Color',
        initial: CpColors.infoBackgroundColor,
        options: [
          const Option(label: 'Yellow', value: CpColors.infoBackgroundColor),
          const Option(
            label: 'Green',
            value: CpColors.successBackgroundColor,
          ),
          const Option(label: 'Red', value: CpColors.errorBackgroundColor)
        ],
      ),
    ),
  ),
);

final _data = [
  CpTimelineData(
    title: 'Tile #1',
    subtitle: 'Tile Subtitle #1',
    trailing: '#1',
  ),
  CpTimelineData(
    title: 'Tile #2',
    subtitle: 'Tile Subtitle #2',
  ),
  CpTimelineData(
    title: 'Tile #3',
    iconColor: Colors.white,
    connectorColor: Colors.white,
  ),
  CpTimelineData(
    title: 'Tile With long Title',
    subtitle: 'Tile With long Subtitle ',
    icon: const Icon(Icons.check, color: Colors.white),
  ),
];
