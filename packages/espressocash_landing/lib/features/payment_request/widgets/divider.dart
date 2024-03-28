import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: const IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: _dividerColor)),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Center(
                  child: Text(
                    'or ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                ),
              ),
              Expanded(child: Divider(color: _dividerColor)),
            ],
          ),
        ),
      );
}

const _dividerColor = Color(0xFFCECECE);
