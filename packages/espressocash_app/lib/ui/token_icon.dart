import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

import '../core/tokens/token.dart';
import '../gen/assets.gen.dart';

class CpTokenIcon extends StatelessWidget {
  const CpTokenIcon({
    Key? key,
    required this.token,
    required this.size,
  }) : super(key: key);

  final Token token;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = token.logoURI;
    final borderRadius = BorderRadius.circular(size / 2);
    if (url == '' || url == null) {
      return _DefaultIcon(size: size);
    } else {
      return ClipRRect(
        borderRadius: borderRadius,
        child: _TokenIconImage(url: url, cacheKey: token.symbol, size: size),
      );
    }
  }
}

class _TokenIconImage extends StatelessWidget {
  const _TokenIconImage({
    Key? key,
    required this.url,
    required this.cacheKey,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (extension(url) == '.svg') {
      return SvgPicture.network(url, width: size, height: size);
    } else {
      return CachedNetworkImage(
        cacheKey: cacheKey,
        height: size,
        width: size,
        errorWidget: (BuildContext context, String url, dynamic error) =>
            const _DefaultIcon(),
        imageUrl: url,
        imageBuilder: (context, provider) => DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: provider),
          ),
        ),
      );
    }
  }

  final double size;
  final String cacheKey;
  final String url;
}

class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        Assets.images.tokenLogo.path,
        width: size,
        height: size,
      );

  final double? size;
}
