import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedImageWidget extends StatelessWidget {
  final String image;

  const RoundedImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 243.h,
        width: 265.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48.r),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  image,
                ).image)));
  }
}
