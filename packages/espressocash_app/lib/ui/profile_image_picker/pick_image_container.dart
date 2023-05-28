import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../gen/assets.gen.dart';
import '../button.dart';

class PickImageContainer extends StatelessWidget {
  const PickImageContainer({
    super.key,
    this.image,
    this.pickImageClicked,
    this.labelStyle,
    required this.label,
    required this.onLabelClicked,
  });

  final File? image;
  final VoidCallback? pickImageClicked;
  final TextStyle? labelStyle;
  final String label;
  final VoidCallback? onLabelClicked;

  @override
  Widget build(BuildContext context) {
    final image = this.image;

    return GestureDetector(
      onTap: pickImageClicked,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 164,
            height: 164,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image == null
                    // ignore: avoid-unnecessary-type-casts, needed here
                    ? Svg(Assets.images.imagePickerIcon.path)
                        as ImageProvider<Object>
                    : FileImage(image),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CpButton(
            text: label,
            onPressed: pickImageClicked,
            variant: CpButtonVariant.inverted,
            size: CpButtonSize.small,
          ),
        ],
      ),
    );
  }
}
