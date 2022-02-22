import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreCacheUtil {
  static Future cacheImages(BuildContext context, String url) {
    return precacheImage(
        CachedNetworkImageProvider(
          url,
          errorListener: () => print('error '),
        ),
        context);
  }
}
