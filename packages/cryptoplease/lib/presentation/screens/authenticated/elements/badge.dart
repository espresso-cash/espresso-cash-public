import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key, required this.value}) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) => Container(
        width: 15,
        height: 15,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: CpColors.primaryColor,
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
