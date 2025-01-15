import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReusableWidget {
  static Widget loadSvg(String icon,
      {double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      "assets/icons/$icon.svg",
      height: height,
      width: width,
      // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
      color: color,
      //colorFilter: color != null ? ColorFilter.mode(color, BlendMode.src) : null,
    );
  }

  static loadImageFromNetwork(
    String url, {
    double? height,
    double? width,
    BoxFit boxFit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: boxFit,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }
}
