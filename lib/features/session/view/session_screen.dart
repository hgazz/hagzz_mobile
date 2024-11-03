import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:bookit/features/profile/view/widgets/bottom_sheet_widget.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:bookit/features/session/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/session/model/local_model/checkout_model.dart';
import 'package:bookit/features/session/view/widgets/actions_bottom_sheet_widget.dart';
import 'package:bookit/features/session/view/widgets/page_view_widget/page_view_widget.dart';
import 'package:bookit/features/session/view/widgets/selected_session_details_data_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/router/rout_constants.dart';
import '../../search/model/local_model/sports_choose_model/sports_choose_model.dart';
import '../../search/view_model/search_cubit.dart';
import '../model/local_model/session_model.dart';

class SessionScreen extends StatefulWidget {
  final SessionLocalModel localModel;

  SessionScreen({super.key, required this.localModel});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    if (widget.localModel.longitude != null &&
        widget.localModel.latitude != null) {
      AppFunctions.launchCoordinates(widget.localModel.latitude.toString(),
          widget.localModel.longitude.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit()
        ..getTrainingDetailsById(
            id: widget.localModel.sessionId,
            classId: widget.localModel.classId),
      child: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) {
          var cubit = SessionCubit.get(context);

          if (state is ChangeFavValueSuccessState) {
            cubit.getTrainingDetailsById(id: widget.localModel.sessionId);
          }
        },
        builder: (context, state) {
          var cubit = SessionCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                HeaderWidget(
                  backOnPressed: () {
                    SessionCubit.get(context).sessionDetailsCategories =
                        SessionDetailsCategories.details;
                    if (widget.localModel.isPushNotification == false) {
                      AppFunctions.popNavigate(context: context);
                    } else {
                      AppFunctions.namedNavigateAndFinishTo(
                          context: context,
                          navigatedScreen: RouteConstants.bottomNavBar);
                    }
                  },
                  // todo : choose the right title de
                  //  pend on the localization
                  title: SessionCubit.get(context)
                          .trainingDetailsResponseModel
                          ?.data
                          ?.training
                          ?.name ??
                      '',
                  trailingIcon: AppIcons.menu,
                  trailingOnPressed: () {
                    AppFunctions.logPrint(
                        message:
                            "idddddd: ${SessionCubit.get(context).trainingDetailsResponseModel?.data?.training?.id}");
                    AppFunctions.logPrint(message: "Favvvvvv : ${cubit.isFav}");
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheetWidget(
                          title: AppStrings.actions,
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: ActionsBottomSheetWidget(
                              isJoined: cubit.trainingDetailsResponseModel?.data
                                      ?.isJoined ??
                                  false,
                              id: widget.localModel.sessionId,
                              isSaved: cubit.trainingDetailsResponseModel?.data
                                      ?.training?.isFav ??
                                  false)),
                    );
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                const SelectedSessionDetailsDataWidget(),
                SizedBox(
                  height: 16.h,
                ),
                SessionPageViewWidget(),
                // todo add is joined condition here
                if (CachedVariables.token != null)
                  if (!(SessionCubit.get(context)
                          .trainingDetailsResponseModel
                          ?.data
                          ?.isJoined ??
                      true))
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 16.h),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 0),
                        ),
                        onPressed: () {
                          if (SessionCubit.get(context)
                                  .trainingDetailsResponseModel
                                  ?.data
                                  ?.training
                                  ?.maxPlayers ==
                              SessionCubit.get(context)
                                  .trainingDetailsResponseModel
                                  ?.data
                                  ?.joins
                                  ?.length) {
                            AppAlert.error(
                                message: AppFunctions.translateText(
                                    text: AppStrings
                                        .sorryTrainingIsFullYouCanFindAnotherOne,
                                    context: context),
                                context: context);
                            SearchCubit.get(context).selectedSportsFilters.add(
                                SportsChooseModel(
                                    id: cubit.trainingDetailsResponseModel?.data
                                            ?.training?.sport?.id ??
                                        0,
                                    image: cubit.trainingDetailsResponseModel
                                            ?.data?.training?.sport?.icon ??
                                        ''));
                            BottomNavBarCubit.get(context).changeIndex(1);
                            AppFunctions.namedNavigateAndFinishTo(
                                context: context,
                                navigatedScreen: RouteConstants.bottomNavBar);
                          } else {
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.sessionCheckOut,
                                args: CheckoutModel(
                                    id: widget.localModel.sessionId,
                                    isNotification: false));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0.h),
                          child: CustomTextWidget(
                              text: cubit.trainingDetailsResponseModel?.data
                                          ?.training?.maxPlayers ==
                                      cubit.trainingDetailsResponseModel?.data
                                          ?.joins?.length
                                  ? AppStrings.viewSimilarSessions
                                  : AppStrings.join,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                      ),
                    ),
              ],
            )),
          );
        },
      ),
    );
  }
}
