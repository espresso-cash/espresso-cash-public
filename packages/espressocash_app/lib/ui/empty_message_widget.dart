import 'package:flutter/material.dart';

import 'theme.dart';

class CpEmptyMessageWidget extends StatelessWidget {
  const CpEmptyMessageWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: CpTheme.of(context).secondaryTextColor),
        ),
      );
}
