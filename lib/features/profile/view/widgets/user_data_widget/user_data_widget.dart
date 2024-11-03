import 'package:bookit/core/util/widgets/container_with_circle_shape_with_white_background_color_widget/container_with_circle_shape_with_white_background_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_images/app_images.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../../core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import '../../../../edit_profile/view_model/edit_profile_cubit.dart';

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          return Row(
            children: [
              EditProfileCubit.get(context).userModel?.data?.profile?.image !=
                      null
                  ? CircleAvatar(
                      radius: 40.r,
                      backgroundImage: EditProfileCubit.get(context)
                                  .userModel
                                  ?.data
                                  ?.profile
                                  ?.image !=
                              null
                          ? Image.network(
                              EditProfileCubit.get(context)
                                      .userModel
                                      ?.data
                                      ?.profile
                                      ?.image ??
                                  "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, obj, str) =>
                                  Image.asset(AppImages.profileImage),
                            ).image
                          : Svg(AppImages.defaultCoachImage),
                    )
                  : ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
                      image: AppImages.defaultCoachImage, isDetails: false),
              SizedBox(
                width: 21.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget.server(
                    text: EditProfileCubit.get(context)
                            .userModel
                            ?.data
                            ?.profile
                            ?.name ??
                        '',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RegularWith12FontSizeText.server(
                    text: EditProfileCubit.get(context)
                            .userModel
                            ?.data
                            ?.profile
                            ?.phone ??
                        '',
                    color: AppColors.greyColor,
                  ),
                ],
              ))
            ],
          );
        },
        listener: (context, state) {});
  }
}
