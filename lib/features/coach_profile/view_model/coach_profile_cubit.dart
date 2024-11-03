import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/features/coach_profile/model/coach_details_model/coach_details_model.dart';
import 'package:bookit/features/coach_profile/model/enum_datails_catgory/enum_details_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/models/api_models/training_model/training_model.dart';

part 'coach_profile_state.dart';

class CoachProfileCubit extends Cubit<CoachProfileState> {
  CoachProfileCubit() : super(CoachProfileInitial());

  static CoachProfileCubit get(context) => BlocProvider.of(context);

  CoachDetailsCategory coachDetailsCategory = CoachDetailsCategory.upcoming;

  void changeCoachDetailsCategory({required CoachDetailsCategory category}) {
    if (category == CoachDetailsCategory.upcoming) {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    if (category == CoachDetailsCategory.past) {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    coachDetailsCategory = category;
    emit(
        ChangeCoachDetailsCategorySuccessState(category: coachDetailsCategory));
  }

  CoachDetailsModel? coachDetails;

  Future<void> getCoachDetails({required int id}) async {
    coachDetails = null;
    emit(GetCoachProfileDataLoadingState());
    await DioHelper.getData(
            url: EndPoints.coachDetails(id: id), token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        coachDetails = CoachDetailsModel.fromJson(value.data);
        getCoachTraining(id: id);
        emit(GetCoachProfileDataSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetCoachProfileDataErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetCoachProfileDataErrorState(error: error.toString()));
    });
  }

  var pageController = PageController();
  List<TrainingModel> pastTraining = [];
  List<TrainingModel> upcomingTraining = [];

  int page = 1;
  int totalPages = 0;

  Future<void> getCoachTraining({required int id}) async {
    await DioHelper.getData(
        url: EndPoints.getCoachTraining(id: id),
        token: CachedVariables.token,
        query: {"page": page}).then((value) {
      if (value.statusCode == 200) {
        List<TrainingModel> upcoming = List<TrainingModel>.from(
            (value.data["data"]["upcoming_trainings"] as List)
                .map((e) => TrainingModel.fromJson(e)));
        List<TrainingModel> past = List<TrainingModel>.from(
            (value.data["data"]["past_trainings"] as List)
                .map((e) => TrainingModel.fromJson(e)));
        totalPages = value.data["data"]["totalPages"];
        upcomingTraining.addAll(upcoming);
        pastTraining.addAll(past);

        for (int i = 0; i < upcomingTraining.length - 1; i++) {
          for (int j = i + 1; j < upcomingTraining.length; j++) {
            if (upcomingTraining[i].id == upcomingTraining[j].id) {
              upcomingTraining.removeAt(j);
            }
          }
        }
        for (int i = 0; i < pastTraining.length - 1; i++) {
          for (int j = i + 1; j < pastTraining.length; j++) {
            if (pastTraining[i].id == pastTraining[j].id) {
              pastTraining.removeAt(j);
            }
          }
        }

        page++;
        emit(GetCoachTrainingSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetCoachTrainingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetCoachTrainingErrorState(error: error.toString()));
    });
  }
}
