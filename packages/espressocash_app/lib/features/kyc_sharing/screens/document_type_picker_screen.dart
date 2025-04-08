import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../models/document_type.dart';

class DocumentTypePickerScreen extends StatelessWidget {
  const DocumentTypePickerScreen({super.key, this.initial, this.types});

  final DocumentType? initial;
  final List<DocumentType>? types;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.deepGreyColor,
      appBar: CpAppBar(title: Text(context.l10n.selectIdMethod.toUpperCase())),
      body: _Content(initial: initial, types: types),
    ),
  );
}

class _Content extends StatefulWidget {
  const _Content({this.initial, this.types});

  final DocumentType? initial;
  final List<DocumentType>? types;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  DocumentType? _selectedType;
  late final List<DocumentType> _types;

  @override
  void initState() {
    super.initState();
    _types = widget.types ?? DocumentType.values;
    _selectedType = switch (widget.initial) {
      final type when _types.contains(type) => type,
      DocumentType.voterId ||
      DocumentType.ninV2 ||
      DocumentType.passport ||
      DocumentType.idCard ||
      null => null,
    };
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: EdgeInsets.only(
      top: 40,
      left: 20,
      right: 20,
      bottom: MediaQuery.paddingOf(context).bottom,
    ),
    itemCount: _types.length,
    itemExtent: _tileHeight,
    itemBuilder: (BuildContext context, int index) {
      final type = _types[index];
      final selected = type == _selectedType;

      return DecoratedBox(
        decoration:
            selected
                ? const ShapeDecoration(
                  color: CpColors.blackTextFieldBackgroundColor,
                  shape: StadiumBorder(),
                )
                : const BoxDecoration(),
        child: ListTile(
          dense: true,
          title: Text(type.name.toUpperCase(), style: TextStyle(fontSize: selected ? 19 : 17)),
          selectedColor: Colors.white,
          shape: selected ? const StadiumBorder() : null,
          onTap: () => Navigator.pop(context, type),
        ),
      );
    },
  );
}

const _tileHeight = 46.0;
