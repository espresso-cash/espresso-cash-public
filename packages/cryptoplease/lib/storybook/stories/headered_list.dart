import 'package:cryptoplease/ui/headered_list/headered_list.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpHeaderedList = Story(
  name: 'CpHeaderedList',
  builder: (context) => CpHeaderedList(
    headerContent: SizedBox(
      height: 300,
      child: Center(
        child: Text(
          context.knobs.text(label: 'Header', initial: 'Header'),
          style: const TextStyle(fontSize: 36),
        ),
      ),
    ),
    headerSubContent: Text(
      context.knobs.text(label: 'Sub Header', initial: 'Sub Header'),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
    headerAppBar: Center(
      child: Text(
        context.knobs.text(label: 'AppBar', initial: 'Header app bar'),
      ),
    ),
    headerButtons: [
      HeaderedListButton(
        label: 'Person',
        onPressed: () {},
        icon: const Icon(Icons.person),
      ),
      HeaderedListButton(
        label: 'Book',
        onPressed: () {},
        icon: const Icon(Icons.book),
      ),
    ],
    onRefresh: () async => Future<void>.delayed(const Duration(seconds: 3)),
    child: CpHeaderedListContent(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.timelapse),
        title: Text('Item ${index + 1}'),
        subtitle: Text('Subtitle ${index + 1}'),
      ),
      itemCount:
          context.knobs.boolean(label: 'Empty', initial: false) ? 0 : 100,
      emptyWidget: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'No data',
          textAlign: TextAlign.center,
          style: TextStyle(color: CpTheme.of(context).secondaryTextColor),
        ),
      ),
      showDivider: context.knobs.boolean(label: 'Show Divider', initial: true),
    ),
  ),
);
