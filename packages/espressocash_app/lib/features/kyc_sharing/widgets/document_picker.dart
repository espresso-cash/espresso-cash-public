import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../models/document_type.dart';
import '../screens/document_type_picker_screen.dart';

class DocumentPicker extends StatelessWidget {
  const DocumentPicker({super.key, this.type, this.types, required this.onSubmitted});

  final DocumentType? type;
  final List<DocumentType>? types;
  final ValueSetter<DocumentType> onSubmitted;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(color: CpColors.blackGreyColor, shape: StadiumBorder()),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () async {
        final DocumentType? updated = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentTypePickerScreen(initial: type, types: types),
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
      trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 28),
    ),
  );
}
