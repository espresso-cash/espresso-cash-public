import 'package:flutter/material.dart';

import '../models/id_type.dart';
import '../screens/id_type_picker_screen.dart';

class IdPicker extends StatelessWidget {
  const IdPicker({
    super.key,
    this.type,
    required this.onSubmitted,
  });

  final IdType? type;
  final ValueSetter<IdType> onSubmitted;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: StadiumBorder(),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          onTap: () async {
            final IdType? updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IdTypePickerScreen(initial: type),
              ),
            );

            if (context.mounted && updated != null) {
              onSubmitted(updated);
            }
          },
          title: Text(
            type?.name ?? 'Select ID Verification Method',
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
