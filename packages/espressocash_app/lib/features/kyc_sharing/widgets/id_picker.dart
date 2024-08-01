import 'package:flutter/material.dart';

import '../models/id_type.dart';

class IdPicker extends StatelessWidget {
  const IdPicker({
    super.key,
    this.enabled = true,
    required this.type,
  });

  final IdType? type;
  final bool enabled;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: Color(0xFF9D8A59),
          shape: StadiumBorder(),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          onTap: enabled ? () {} : null,
          title: Text(
            type?.name ?? 'ID Type',
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      );
}
