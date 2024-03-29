import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MerchantLogoIcon extends StatelessWidget {
  const MerchantLogoIcon({
    super.key,
    required this.logoUrl,
  });

  final String logoUrl;

  static const double size = 128.0;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(size / 2);

    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        cacheKey: logoUrl,
        height: size,
        width: size,
        errorWidget: (BuildContext context, String url, dynamic error) =>
            Container(),
        imageUrl: logoUrl,
        imageBuilder: (context, provider) => DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: provider),
          ),
        ),
      ),
    );
  }
}
