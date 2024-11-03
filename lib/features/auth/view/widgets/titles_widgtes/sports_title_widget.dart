import 'package:flutter/cupertino.dart';

import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import '../../../../../core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';

class SportsTitleWidget extends StatelessWidget {
  const SportsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextWidget(text: AppStrings.whatULike),
        LabelTextWidget(text: AppStrings.chooseSportsDescriptionMessage),
      ],
    );
  }
}
