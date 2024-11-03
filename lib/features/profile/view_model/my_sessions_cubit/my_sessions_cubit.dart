import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/features/profile/model/enum_model/enum_details_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_sessions_state.dart';

class MySessionsCubit extends Cubit<MySessionsState> {
  MySessionsCubit() : super(MySessionsInitial());

  static MySessionsCubit get(context) => BlocProvider.of(context);

  MySessionsCategories mySessionsCategories = MySessionsCategories.upcoming;

  var pageController = PageController();

  void changeDetailsCategory({required MySessionsCategories category}) {
    if (category == MySessionsCategories.upcoming) {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    } else {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    mySessionsCategories = category;
    emit(ChangeMySessionsCategorySuccessState(category: mySessionsCategories));
  }

  // todo get my sessions from api

  List<TrainingModel> upcomingMySessions = [];
  List<TrainingModel> pastMySessions = [];

  int page = 1;
  int totalPages = 0;

  bool? isPastEmpty;

  bool? isUpcomingEmpty;

  Future<void> getMySessions() async {
    if (page == 1) {
      upcomingMySessions = [];
      pastMySessions = [];
    }
    emit(GetMySessionsLoadingState());
    await DioHelper.getData(
            url: EndPoints.mySessions, token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        List<TrainingModel> upcoming =
            value.data["data"]['upcoming_joins'] != null
                ? (value.data["data"]['upcoming_joins'] as List)
                    .map((e) => TrainingModel.fromJson(e['training']))
                    .toList()
                : [];

        List<TrainingModel> past = value.data["data"]['past_joins'] != null
            ? (value.data["data"]['past_joins'] as List)
                .map((e) => TrainingModel.fromJson(e['training']))
                .toList()
            : [];
        int totalPagesUpcoming = value.data['data']['totalPages_upcoming'];
        int totalPagesPast = value.data['data']['totalPages_past'];
        totalPages = totalPagesUpcoming > totalPagesPast
            ? totalPagesUpcoming
            : totalPagesPast;
        upcomingMySessions.addAll(upcoming);
        pastMySessions.addAll(past);

        for (int i = 0; i < upcomingMySessions.length - 1; i++) {
          for (int j = i + 1; j < upcomingMySessions.length; j++) {
            if (upcomingMySessions[i].id == upcomingMySessions[j].id) {
              upcomingMySessions.removeAt(j);
            }
          }
        }
        for (int i = 0; i < pastMySessions.length - 1; i++) {
          for (int j = i + 1; j < pastMySessions.length; j++) {
            if (pastMySessions[i].id == pastMySessions[j].id) {
              pastMySessions.removeAt(j);
            }
          }
        }
        page++;
        isPastEmpty = pastMySessions.isEmpty ? true : false;
        isUpcomingEmpty = upcomingMySessions.isEmpty ? true : false;
        emit(GetMySessionsSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetSavedDateErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      AppFunctions.logPrint(message: "Error: ${error.toString()}");
      emit(GetSavedDateErrorState(error: error.toString()));
    });
  }

  void clearData() {
    upcomingMySessions = [];
    pastMySessions = [];
    page = 1;
    totalPages = 0;
  }
}
