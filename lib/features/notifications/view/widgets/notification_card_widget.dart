import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/outline_icon_bottom_widget/outline_icon_bottom_widget.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/notifications/model/api_models/notifications_model/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../session/model/local_model/checkout_model.dart';
import '../../../session/view_model/session_cubit.dart';

class NotificationCardWidget extends StatelessWidget {
  final NotificationData? data;

  const NotificationCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          data != null
              ? Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: const ShapeDecoration(
                    color: AppColors.transparent,
                    shape: OvalBorder(
                      eccentricity: 0,
                      side: BorderSide(
                        color: AppColors.greyBorderColor,
                      ),
                    ),
                  ),
                  child: SvgPicture.network(
                    data?.academyImage ?? '',
                    fit: BoxFit.none,
                    placeholderBuilder: (context) {
                      return Icon(Icons.notifications_outlined);
                    },
                  ),
                )
              : ShimmerWidget(
                  width: 56.w,
                  height: 56.h,
                ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data != null
                    ? RichText(
                        text: TextSpan(children: [
                        TextSpan(
                            text: "${data?.training?.trainingName ?? ''} ",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            )),
                        TextSpan(
                            text: data?.description ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGreyColor,
                            )),
                      ]))
                    : ShimmerWidget(width: 180.w, height: 20.h),
                SizedBox(height: 8.h),
                data != null
                    ? CustomTextWidget(
                        text: data?.createdAt ?? '',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGreyColor)
                    : SizedBox.shrink(),
                SizedBox(height: 16.h),
                data != null
                    ? BlocConsumer<SessionCubit, SessionState>(
                        listener: (context, state) {
                          if (state is GetTrainingDetailsByIdSuccessState) {
                            AppFunctions.logPrint(
                                message: "||||||||||||||||||||||||||||||||||");
                          }
                          if (state is GetTrainingDetailsByIdErrorState) {
                            AppAlert.error(
                                message: state.error, context: context);
                          }
                        },
                        builder: (context, state) {
                          return OutLineIconBottomWidget(
                              onTap: () {
                                AppFunctions.logPrint(
                                    message: "Typeee: ${data?.type}");

                                if (data?.type == "0" ||
                                    data?.type == "1" ||
                                    data?.type == "2" ||
                                    data?.type == "cancel_booking") {
                                  AppFunctions.namedNavigateTo(
                                      context: context,
                                      navigatedScreen:
                                          RouteConstants.sessionCheckOut,
                                      args: CheckoutModel(
                                          id: data?.training?.id ?? 0,
                                          isNotification: true));
                                }
                              },
                              icon: data?.type == 2
                                  ? Icon(
                                      Icons.arrow_forward_outlined,
                                      color: AppColors.black,
                                      size: 20,
                                    )
                                  : SizedBox.shrink(),
                              text: AppFunctions.translateText(
                                  text:
                                      AppFunctions.getNotificationBottomString(
                                          type: data?.type == "cancel_booking"
                                              ? 1
                                              : int.parse(data?.type ?? "0")),
                                  context: context));
                        },
                      )
                    : ShimmerWidget(width: 80.w, height: 25.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
