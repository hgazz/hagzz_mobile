import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_bottom_sheets/app_bottom_sheets.dart';
import '../container_icon_widget/container_icon_widget.dart';

class MoreProfileIconWidget extends StatelessWidget {
  const MoreProfileIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerIconWidget(
      icon: Icons.more_vert,
      onTap: () {
        AppBottomSheet.moreProfileIconBottomSheet(context: context);
      },
      margin: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
