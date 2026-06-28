import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/constants/app_media/app_media.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/features/auth/model/api_models/sports_model.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../search/model/local_model/sports_choose_model/sports_choose_model.dart';

class SportItemWidget extends StatelessWidget {
  final SportData? sport;
  final bool isEmpty;

  const SportItemWidget(
      {super.key, required this.sport, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sport != null
            ? Expanded(
                child: InkWell(
                  onTap: () {
                    if (isEmpty) {
                      AppFunctions.namedNavigateAndFinishTo(
                          context: context,
                          navigatedScreen: RouteConstants.enterPhone);
                    } else {
                      SearchCubit.get(context).getSearchData().then((value) {
                        SearchCubit.get(context).selectedSportsFilters = [];
                        SearchCubit.get(context).changeSelectedSportsFilters(
                            SportsChooseModel(
                                id: sport?.id ?? -1, image: sport?.icon ?? ''));
                        SearchCubit.get(context).getSearchData();
                        BottomNavBarCubit.get(context).changeIndex(1);
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    margin: EdgeInsets.only(bottom: 5.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff000000).withOpacity(0.03),
                              blurRadius: 14.r,
                              offset: Offset(0, 0))
                        ],
                        gradient: LinearGradient(
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              Color(0xffC9C9C9),
                              AppColors.white,
                            ]),
                        border:
                            Border.all(color: AppColors.borderColor, width: 1)),
                    child: isEmpty
                        ? Icon(Icons.add)
                        : SvgPicture.network(
                            width: 40.w,
                            height: 40.h,
                            sport?.icon ?? '',
                            fit: BoxFit.scaleDown,
                            placeholderBuilder: (_) => SvgPicture.asset(
                              AppMedia.sportAsset(sport?.name),
                              width: 40.w,
                              height: 40.h,
                            ),
                            errorBuilder: (_, __, ___) => SvgPicture.asset(
                              AppMedia.sportAsset(sport?.name),
                              width: 40.w,
                              height: 40.h,
                            ),
                          ),
                  ),
                ),
              )
            : ShimmerWidget(
                width: 40.w,
                height: 40.h,
                containerShape: BoxShape.circle,
              ),
        isEmpty
            ? CustomTextWidget(
                text: AppStrings.add,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black)
            : sport != null
                ? CustomTextWidget.server(
                    text:
                        // todo make the name depends on current localization
                        sport?.name ?? '',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)
                : ShimmerWidget(width: 60.w, height: 20.h)
      ],
    );
  }
}
