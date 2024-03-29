import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../gen/assets.gen.dart';

class PickImageContainer extends StatelessWidget {
  const PickImageContainer({
    super.key,
    this.image,
    this.pickImageClicked,
  });

  final File? image;
  final VoidCallback? pickImageClicked;

  @override
  Widget build(BuildContext context) {
    final image = this.image;

    return GestureDetector(
      onTap: pickImageClicked,
      child: Container(
        width: 114,
        height: 114,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
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
    );
  }
}
