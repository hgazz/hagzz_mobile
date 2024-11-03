import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';

class Numeral extends StatelessWidget {
  const Numeral({
    super.key,
    required this.number,
    required this.onKeyPress,
  });

  final int number;
  final VoidCallback onKeyPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: FilledButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceContainer,
          minimumSize: const Size(72, 72),
          shape: const CircleBorder(),
        ),
        onPressed: onKeyPress,
        child: Text(
          '$number',
          style: GoogleFonts.inter(
              fontSize: 26.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black),
        ),
      ),
    );
  }
}
