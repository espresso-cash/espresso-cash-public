import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpTimeline = Story(
  name: 'CpTimeline',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: CpTimeline(
      items: context.knobs.options(
        label: 'Items',
        initial: _data,
        options: [
          Option(label: 'With Data', value: _data),
          const Option(label: 'Empty', value: []),
        ],
      ),
      status: context.knobs.options(
        label: 'Timeline Status',
        initial: CpTimelineStatus.inProgress,
        options: [
          const Option(
            label: 'In Progress',
            value: CpTimelineStatus.inProgress,
          ),
          const Option(
            label: 'Success',
            value: CpTimelineStatus.success,
          ),
          const Option(
            label: 'Failure',
            value: CpTimelineStatus.failure,
          )
        ],
      ),
      active: context.knobs.sliderInt(
        label: 'Current',
        initial: 1,
        min: 0,
        max: _data.length,
      ),
    ),
  ),
);

final _data = <CpTimelineItem>[
  CpTimelineItem(
    title: 'Tile #1',
    subtitle: 'Tile Subtitle #1',
    trailing: '#1',
  ),
  CpTimelineItem(
    title: 'Tile #2',
    subtitle: 'Tile Subtitle #2',
  ),
  CpTimelineItem(
    title: 'Tile #3',
    subtitle: 'Tile Subtitle #3',
  ),
];
