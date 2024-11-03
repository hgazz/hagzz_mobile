import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/auth/model/api_models/sports_model.dart';
import 'package:bookit/features/auth/model/local_model/level_model.dart';
import 'package:bookit/features/auth/view/choose_sports_screen/widgets/level_item_widget/level_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../view_model/choose_sports_cubit/choose_sports_cubit.dart';

class SportsItem extends StatelessWidget {
  final int index;
  final SportData data;

  const SportsItem({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseSportsCubit, ChooseSportsState>(
      builder: (context, state) {
        var cubit = ChooseSportsCubit.get(context);
        return Center(
          child: InkWell(
            onTap: () {
              cubit.changeSports(index);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                    color: cubit.sportsLevel.isNotEmpty
                        ? cubit.sportsLevel[index].name != ""
                            ? AppColors.black
                            : AppColors.greyBorderColor
                        : AppColors.greyBorderColor),
              ),
              child: cubit.sportsChooseIndex != index
                  ? ListTile(
                      leading: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: CircleAvatar(
                          radius: 12.r,
                          backgroundColor: AppColors.transparent,
                          child: SvgPicture.network(
                            data.icon ?? "",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(
                              text: data.name ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                          SizedBox(
                            width: 10.w,
                          ),
                          (cubit.sportsModel?.data?[index].level != null)
                              ? LevelItem(
                                  isChoose: true,
                                  onTap: null,
                                  data: LevelModel(
                                      name: cubit.sportsModel?.data?[index]
                                              .level ??
                                          '',
                                      image: cubit.sportsModel?.data?[index]
                                                  .level
                                                  ?.toLowerCase() ==
                                              AppStrings.beginner
                                          ? AppIcons.beginnerSVG
                                          : cubit.sportsModel?.data?[index]
                                                      .level
                                                      ?.toLowerCase() ==
                                                  AppStrings.intermediate
                                              ? AppIcons.intermediateSVG
                                              : AppIcons.advancedSVG))
                              : const SizedBox.shrink()
                        ],
                      ),
                      trailing: (cubit.sportsModel?.data?[index].level != null)
                          ? InkWell(
                              onTap: () {
                                cubit.removeChosenLevel(index: index);
                              },
                              child: Icon(Icons.close))
                          : null,
                    )
                  : Column(
                      children: [
                        const Center(
                          child: CustomTextWidget(
                              text: AppStrings.yourLevel,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              cubit.levels.length,
                              (index) => LevelItem(
                                  isChoose: false,
                                  onTap: () {
                                    cubit.changeLevel(index);
                                  },
                                  data: cubit.levels[index])),
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
