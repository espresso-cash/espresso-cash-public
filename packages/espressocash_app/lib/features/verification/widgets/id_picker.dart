import 'package:flutter/material.dart';

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

enum IdType { driversLicense, voterId }

extension IdTypeExtension on IdType {
  String get name {
    switch (this) {
      case IdType.driversLicense:
        return 'Driver\'s License';
      case IdType.voterId:
        return 'Voter ID';
    }
  }

  String get value {
    switch (this) {
      case IdType.driversLicense:
        return 'DRIVERS_LICENSE';
      case IdType.voterId:
        return 'VOTER_ID';
    }
  }
}
