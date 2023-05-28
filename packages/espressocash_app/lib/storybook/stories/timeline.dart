import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/timeline.dart';

final cpTimeline = Story(
  name: 'CpTimeline',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: CpTimeline(
      items: _data,
      animated: context.knobs.boolean(label: 'Animated', initial: true),
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
          ),
          const Option(
            label: 'Neutral',
            value: CpTimelineStatus.neutral,
          ),
        ],
      ),
      active: context.knobs.sliderInt(
        label: 'Current',
        initial: 1,
        min: 0,
        max: _data.length - 1,
      ),
    ),
  ),
);

const _data = <CpTimelineItem>[
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
