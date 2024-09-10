import 'package:flutter/material.dart';

import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../models/id_type.dart';

class IdTypePickerScreen extends StatelessWidget {
  const IdTypePickerScreen({
    super.key,
    this.initial,
  });

  final IdType? initial;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text('Select id method'.toUpperCase()),
          ),
          body: _Content(initial: initial),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.initial});

  final IdType? initial;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  IdType? _selectedType;

  final _types = IdType.values;

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
