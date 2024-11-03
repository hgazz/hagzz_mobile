import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FollowEmptyWidget extends StatelessWidget {
  final bool isPlaces;

  const FollowEmptyWidget({super.key, required this.isPlaces});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImages.emptyFollow,
        ),
        SizedBox(height: 24.h),
        TitleTextWidget(
            text: isPlaces
                ? AppStrings.emptyFollowPlacesMessage
                : AppStrings.emptyFollowCoachesMessage),
      ],
    );
  }
}
