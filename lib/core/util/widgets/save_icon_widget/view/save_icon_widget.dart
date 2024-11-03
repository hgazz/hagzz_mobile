import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/save_icon_widget/view_model/save_icon_cubit.dart';
import 'package:bookit/features/saved/view_model/saved_cubit.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../features/home/view_model/home_cubit.dart';
import '../../../../../features/profile/view/widgets/bottom_sheet_widget.dart';
import '../../../../../features/profile/view/widgets/remove_item_validation_widget.dart';
import '../../../constants/app_icons/app_icons.dart';
import '../../../constants/app_strings/app_strings.dart';

class SaveIconWidget extends StatelessWidget {
  final int id;
  final bool isSaved;
  final bool isBottomSheet;
  final bool isSessionDetails;
  final int? index;
  void Function(bool value) getSaveValue;

  SaveIconWidget(
      {super.key,
      required this.id,
      required this.isSaved,
      this.isBottomSheet = false,
      this.isSessionDetails = false,
      this.index,
      required this.getSaveValue});

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "is Saveeeeed: ${isSaved}");
    return BlocProvider(
      create: (context) => SaveIconCubit()..setSaveValue(isSaved),
      child: BlocConsumer<SaveIconCubit, SaveIconState>(
        listener: (context, state) {
          var cubit = SaveIconCubit.get(context);

          if (state is SavedTrainingSuccessState) {
            getSaveValue(true);
            AppAlert.success(message: state.message, context: context);
            cubit.changeSaveValue(true);
            if (index != null) {
              HomeCubit.get(context).homeData.data?.training?[index!].isSaved =
                  true;
            }
            SavedCubit.get(context).savedData = null;
            SavedCubit.get(context).getSavedData(myPage: 1);
            if (isSessionDetails) {
              SessionCubit.get(context)
                  .trainingDetailsResponseModel
                  ?.data
                  ?.training
                  ?.isFav = true;
            }
            // SearchCubit.get(context).getSearchData();
          }
          if (state is UnSavedTrainingSuccessState) {
            cubit.changeSaveValue(false);
            getSaveValue(false);
            AppFunctions.popNavigate(context: context);
            if (index != null) {
              HomeCubit.get(context).homeData.data?.training?[index!].isSaved =
                  false;
            }
            AppAlert.success(message: state.message, context: context);
            SavedCubit.get(context).savedData = null;
            SavedCubit.get(context).getSavedData(myPage: 1);
            if (isSessionDetails) {
              SessionCubit.get(context)
                  .trainingDetailsResponseModel
                  ?.data
                  ?.training
                  ?.isFav = false;
            }
            // HomeCubit.get(context).getHomeData(context: context);
            // SearchCubit.get(context).getSearchData();
          }
          if (state is SavedTrainingErrorState) {
            AppAlert.error(message: state.error, context: context);
          }
          if (state is UnSavedTrainingErrorState) {
            AppFunctions.popNavigate(context: context);

            AppAlert.error(message: state.error, context: context);
          }

          if (state is UnAuthorizedState) {
            AppAlert.success(
              message: AppFunctions.translateText(
                  text: AppStrings.youMustLogin, context: context),
              context: context,
            );
            AppFunctions.namedNavigateTo(
                context: context, navigatedScreen: RouteConstants.enterPhone);
          }
        },
        builder: (context, state) {
          var cubit = SaveIconCubit.get(context);

          return LikeButton(
            size: isBottomSheet ? 42 : 30,
            isLiked: cubit.isSave,
            circleColor:
                CircleColor(start: Color(0xffC5C5C5), end: Color(0xffC5C5C5)),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Color(0xffC5C5C5),
              dotSecondaryColor: Color(0xffC5C5C5),
            ),
            onTap: (value) async {
              if (!cubit.isSave!) {
                cubit.addToSaved(id: id);
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget(
                        title: AppStrings.removeItem,
                        height: MediaQuery.of(context).size.height * .30,
                        child: RemoveItemValidationWidget(
                          onPressed: () {
                            cubit.deleteFromSaved(id: id, context: context);
                          },
                        ),
                      );
                    });
              }
              return await true;
            },
            animationDuration: Duration(milliseconds: 1000),
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked ? Icons.bookmark_rounded : Symbols.bookmark_rounded,
                size: isBottomSheet ? 45 : 25,
              );
              return SvgPicture.asset(
                isLiked ? AppIcons.saveSmall : AppIcons.savedOutlined,
                width: isLiked ? 20 : 25,
              );
            },
          );
          return GestureDetector(
            onTap: () {
              if (!cubit.isSave!) {
                cubit.addToSaved(id: id);
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget(
                        title: AppStrings.removeItem,
                        child: RemoveItemValidationWidget(
                          onPressed: () {
                            cubit.deleteFromSaved(id: id, context: context);
                          },
                        ),
                      );
                    });
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: cubit.isSave! ? 20 : 25,
              child: SvgPicture.asset(
                cubit.isSave! ? AppIcons.save : AppIcons.savedOutlined,
                width: cubit.isSave! ? 20 : 25,
              ),
            ),
          );
        },
      ),
    );
  }
}
/*
IconButton(
            onPressed: () {
              if (!cubit.isSave!) {
                cubit.addToSaved(id: id);
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget(
                        title: AppStrings.removeItem,
                        child: RemoveItemValidationWidget(
                          onPressed: () {
                            cubit.deleteFromSaved(id: id, context: context);
                          },
                        ),
                      );
                    });
              }
            },
            icon: SvgPicture.asset(
              cubit.isSave! ? AppIcons.save : AppIcons.savedOutlined,
            ),
          )
 */
