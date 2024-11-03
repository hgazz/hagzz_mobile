import 'package:flutter/cupertino.dart';

import '../../../../../core/helper/cach/cached_variables.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import '../../../../../core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedVariables.token == null
            ? const TitleTextWidget(text: AppStrings.completeProfileTitle)
            : const SizedBox.shrink(),
        CachedVariables.token == null
            ? const LabelTextWidget(text: AppStrings.completeProfileLabel)
            : const SizedBox.shrink(),
      ],
    );
  }
}
