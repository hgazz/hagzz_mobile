import 'package:bookit/core/util/widgets/shimmer_widget/container_loading_widget.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentHeaderRowLoadingWidget extends StatelessWidget {
  const DepartmentHeaderRowLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerWidget(width: 60.w, height: 20.h),
        ShimmerWidget(width: 60.w, height: 20.h),
      ],
    );
  }
}
