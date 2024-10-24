import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../models/document_type.dart';

class DocumentTypePickerScreen extends StatelessWidget {
  const DocumentTypePickerScreen({
    super.key,
    this.initial,
  });

  final DocumentType? initial;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(context.l10n.selectIdMethod.toUpperCase()),
          ),
          body: _Content(initial: initial),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.initial});

  final DocumentType? initial;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  DocumentType? _selectedType;

  final _types = DocumentType.values;

  @override
  void initState() {
    super.initState();

    _selectedType = widget.initial;
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
            decoration: selected
                ? const ShapeDecoration(
                    color: CpColors.blackTextFieldBackgroundColor,
                    shape: StadiumBorder(),
                  )
                : const BoxDecoration(),
            child: ListTile(
              dense: true,
              title: Text(
                type.name.toUpperCase(),
                style: TextStyle(fontSize: selected ? 19 : 17),
              ),
              selectedColor: Colors.white,
              shape: selected ? const StadiumBorder() : null,
              onTap: () => Navigator.pop(context, type),
            ),
          );
        },
      );
}

const _tileHeight = 46.0;
