import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_color.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height, width;
  final BoxFit fit;
  final Color? color;

  const AppImage(
    this.path, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.scaleDown,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (path.endsWith("svg")) {
      return SvgPicture.asset(
        path,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else if (path.endsWith("json")) {
      return Lottie.asset(
        path,
        fit: fit,
        height: height,
        width: width,
      );
    } else if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Loading...',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[400],
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error_outline_rounded,
          color: AppColor.mainColor,
        ),
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }else if (path.contains("assets")) {
      return Image.asset(
        path,
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    } else {
      return Image.file(
        File(path),
        fit: fit,
        height: height,
        width: width,
        color: color,
      );
    }
  }
}
