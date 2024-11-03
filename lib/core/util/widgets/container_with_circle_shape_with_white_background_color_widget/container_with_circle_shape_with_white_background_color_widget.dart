import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ContainerWithCircleShapeWithWhiteBackgroundColorWidget
    extends StatelessWidget {
  final String image;
  final bool isDetails;

  const ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
      {super.key, required this.image, required this.isDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (isDetails ? 70 : 75).w,
      height: 70.h,
      // padding: EdgeInsets.all(18.r),
      // decoration: BoxDecoration(
      //     // shape: BoxShape.circle,
      //     // color: AppColors.whiteEBColor,
      //     ),
      child: SvgPicture.asset(
        image,
      ),
    );
  }
}
