import 'dart:io';

import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PickImageContainer extends StatelessWidget {
  const PickImageContainer({
    Key? key,
    this.image,
    this.pickImageClicked,
    this.labelStyle,
    required this.label,
    required this.onLabelClicked,
  }) : super(key: key);

  final File? image;
  final VoidCallback? pickImageClicked;
  final TextStyle? labelStyle;
  final String label;
  final VoidCallback? onLabelClicked;

  @override
  Widget build(BuildContext context) => GestureDetector(
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
                      // ignore: avoid-unnecessary-type-casts
                      ? Svg(Assets.images.imagePickerIcon.path)
                          as ImageProvider<Object>
                      : FileImage(image!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onLabelClicked,
                child: Text(
                  label.toUpperCase(),
                  style: labelStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 13),
                ),
              ),
            )
          ],
        ),
      );
}
