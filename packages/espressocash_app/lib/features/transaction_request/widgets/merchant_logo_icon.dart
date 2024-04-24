import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

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
      child: extension(logoUrl) == '.svg'
          ? SvgPicture.network(logoUrl, width: size / 2, height: size / 2)
          : CachedNetworkImage(
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
