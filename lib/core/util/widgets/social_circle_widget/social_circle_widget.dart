import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../svg_image_widget/svg_image_widget.dart';

class SocialCircleWidget extends StatelessWidget {
  final String icon;
  final Color backgroundColor;
  final void Function()? onTap;

  const SocialCircleWidget(
      {super.key,
      required this.icon,
      required this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 35.r,
        backgroundColor: backgroundColor,
        child: SVGImageWidget(
          image: icon,
          size: 35,
        ),
      ),
    );
  }
}
