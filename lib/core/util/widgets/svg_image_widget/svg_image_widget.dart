import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGImageWidget extends StatelessWidget {
  final String image;
  final double? size;
  final BoxFit? fit;

  const SVGImageWidget(
      {super.key, required this.image, this.size = 20, this.fit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: fit ?? BoxFit.contain,
      width: size?.w,
    );
  }
}
