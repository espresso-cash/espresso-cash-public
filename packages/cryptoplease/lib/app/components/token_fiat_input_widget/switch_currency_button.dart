import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SwitchCurrencyButton extends StatelessWidget {
  const SwitchCurrencyButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width / 4,
        child: CustomPaint(
          painter: _LinePainter(),
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Assets.images.switchCurrency.svg(),
            ),
          ),
        ),
      );
}

class _LinePainter extends CustomPainter {
  _LinePainter() {
    _paint
      ..color = CpColors.strokeColor
      ..strokeWidth = 2;
  }

  final _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, size.height / 2);
    final p2 = Offset(size.width, size.height / 2);
    canvas.drawLine(p1, p2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
