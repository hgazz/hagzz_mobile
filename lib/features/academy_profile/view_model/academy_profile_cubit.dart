import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/features/academy_profile/model/academy_details_model/academy_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../model/enum_model/enum_details_model.dart';

part 'academy_profile_state.dart';

class AcademyProfileCubit extends Cubit<AcademyProfileState> {
  AcademyProfileCubit() : super(AcademyProfileInitial());

  static AcademyProfileCubit get(context) => BlocProvider.of(context);
  var pageViewController = PageController();
  var dismissKey = UniqueKey();
  var pageController = PageController(
    initialPage: 0,
  );
  AcademyDetailsCategories academyDetailsCategories =
      AcademyDetailsCategories.activities;

  void changeDetailsCategory({required AcademyDetailsCategories category}) {
    academyDetailsCategories = category;
    emit(ChangeCoachDetailsCategorySuccessState(
        category: academyDetailsCategories));
  }

  AcademyDetailsModel? academyDetails;

  Future<void> getAcademyDetails({required int id}) async {
    academyDetails = null;
    emit(GetAcademyDetailsLoadingState());
    await DioHelper.getData(
            url: EndPoints.academyDetails(id: id), token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        academyDetails = AcademyDetailsModel.fromJson(value.data);
        emit(GetAcademyDetailsSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetAcademyDetailsErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetAcademyDetailsErrorState(error: error.toString()));
    });
  }

  List<TrainingModel> academyTraining = [];

  int page = 1;
  int totalPages = 0;

  Future<void> getTraining({required int id}) async {
    emit(GetAcademyTrainingLoadingState());
    await DioHelper.getData(
            url: EndPoints.getAcademyTraining(id: id),
            query: {"page": page},
            token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        List<TrainingModel> data = List<TrainingModel>.from(
            (value.data["data"]["trainings"] as List)
                .map((e) => TrainingModel.fromJson(e)));

        totalPages = value.data["data"]["totalPages"];
        academyTraining.addAll(data);
        for (int i = 0; i < academyTraining.length - 1; i++) {
          for (int j = i + 1; j < academyTraining.length; j++) {
            if (academyTraining[i].id == academyTraining[j].id) {
              academyTraining.removeAt(j);
            }
          }
        }

        page++;
        emit(GetAcademyTrainingSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetAcademyTrainingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetAcademyTrainingErrorState(error: error.toString() ?? ''));
    });
  }
}
