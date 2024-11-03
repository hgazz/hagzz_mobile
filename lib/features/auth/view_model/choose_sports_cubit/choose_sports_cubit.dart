import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/dio/dio_helper.dart';
import '../../../../core/helper/dio/end_points.dart';
import '../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../../../update_sports/model/update_sports_validation_error_model/update_sports_validation_error_model.dart';
import '../../model/api_models/sports_model.dart';
import '../../model/local_model/chosen_sport_model.dart';
import '../../model/local_model/level_model.dart';

part 'choose_sports_state.dart';

class ChooseSportsCubit extends Cubit<ChooseSportsState> {
  ChooseSportsCubit() : super(ChooseSportsInitial());

  static ChooseSportsCubit get(context) => BlocProvider.of(context);

  SportsModel? sportsModel;

  Future<void> getSports() async {
    sportsModel = null;
    emit(GetSportsLoadingState());
    await DioHelper.getData(url: EndPoints.sports).then((value) {
      if (value.statusCode == 200) {
        sportsModel = SportsModel.fromJson(value.data);
        emit(GetSportsSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetSportsErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetSportsErrorState(error: error.toString()));
    });
  }

  List<LevelModel> levels = [
    LevelModel(name: AppStrings.beginner, image: AppIcons.beginnerSVG),
    LevelModel(name: AppStrings.intermediate, image: AppIcons.intermediateSVG),
    LevelModel(name: AppStrings.advanced, image: AppIcons.advancedSVG),
  ];
  int? currentIndex;
  List<LevelModel> sportsLevel = [];
  List<ChosenSportsModel> chooseSports = [];
  List<ChosenSportsModel> userSports = [];

  void changeLevel(int value) {
    currentIndex = value;
    sportsModel?.data?[sportsChooseIndex].level =
        levels[currentIndex ?? 0].name;

    sportsChooseIndex = -1;
    emit(ChangeLevelSuccessState());
  }

  int sportsChooseIndex = -1;

  void changeSports(int index) {
    sportsChooseIndex = index;
    emit(ChangeSportsSuccessState());
  }

  void removeChosenLevel({required int index}) {
    AppFunctions.logPrint(
        message: "sports: ${sportsLevel}\n chossseee: ${chooseSports}");
    sportsModel?.data?[index].level = null;
    AppFunctions.logPrint(
        message: "sports2: ${sportsLevel}\n chossseee2: ${chooseSports}");
    emit(RemoveChosenLevelSuccessState());
  }

  Future<void> updateSports(
      {List<String>? sports, List<String>? levels}) async {
    emit(UpdateSportsLoadingState());
    await DioHelper.postData(
            url: EndPoints.updateSports,
            token: CachedVariables.token,
            data: sports == null && levels == null
                ? await FormData.fromMap({
                    for (int i = 0; i < chooseSports.length; i++)
                      "sport_id[$i]": chooseSports[i].sportId,
                    for (int i = 0; i < chooseSports.length; i++)
                      "level[$i]": chooseSports[i].levelName
                  })
                : await FormData.fromMap({
                    for (int i = 0; i < sports!.length; i++)
                      "sport_id[$i]": sports[i],
                    for (int i = 0; i < levels!.length; i++)
                      "level[$i]": levels[i]
                  }))
        .then((value) {
      if (value.statusCode == 200) {
        emit(UpdateSportsSuccessState());
      } else if (value.statusCode == 400) {
        UpdateSportsValidationErrorModel model =
            UpdateSportsValidationErrorModel.fromJson(value.data);
        emit(UpdateSportsValidationErrorState(
            error: model.errors ?? UpdateSportsValidationError()));
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(UpdateSportsErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(UpdateSportsErrorState(error: error.toString()));
    });
  }

  Future<void> getUserSports() async {
    emit(GetSportsLoadingState());
    await DioHelper.getData(
            url: EndPoints.userSports, token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        sportsModel = SportsModel.fromJson(value.data);
        AppFunctions.logPrint(
            message: "lengttththhh ${sportsModel?.data?.length ?? 0}");
        sportsModel?.data?.forEach((element) {
          sportsLevel.add(LevelModel(name: "", image: ""));
        });
        emit(GetSportsSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetSportsErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetSportsErrorState(error: error.toString()));
    });
  }
}
