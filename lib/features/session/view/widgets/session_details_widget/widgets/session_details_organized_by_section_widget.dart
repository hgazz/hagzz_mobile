import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/core/util/widgets/circle_image_widget/circle_image_widget.dart';
import 'package:bookit/core/util/widgets/place_holder_image_widget/place_holder_image_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:bookit/features/session/view/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/util/widgets/row_contain_icon_and_text_widget/row_contain_icon_and_text_widget.dart';
import '../../../../../../core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';

class SessionDetailsOrganizedBySectionWidget extends StatelessWidget {
  final Training training;

  const SessionDetailsOrganizedBySectionWidget(
      {super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: AppStrings.organizedBy,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.surfaceContainer,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: training?.academy?.logo != null
                    ? CircleImageWidget(image: training?.academy?.logo ?? '')
                    : const PlaceHolderImageWidget(),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleTextWidget.server(
                        text: training?.academy?.commercialName ?? ''),
                    RowContainIconAndTextWidget(
                        icon: AppIcons.persons,
                        text:
                            training?.academy?.followsCount.toString() ?? "0"),
                    CustomTextWidget.server(
                      text: AppFunctions.getStringFromList(
                          item: training?.academy?.sports ?? []),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    )
                  ],
                ),
              ),
              OutlinedButtonWidget(
                onTap: () {
                  AppFunctions.namedNavigateTo(
                      context: context,
                      navigatedScreen: RouteConstants.academyProfile,
                      args: DetailsDataModel(
                          id: training!.academy!.id!,
                          name: training.academy!.commercialName!));
                },
                icon: AppIcons.arrowRight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
