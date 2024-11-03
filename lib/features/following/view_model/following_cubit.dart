import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/features/following/model/category_enum.dart';
import 'package:bookit/features/following/model/following_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../model/coaches_for_u_model.dart';

part 'following_state.dart';

class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit() : super(FollowingInitial());

  static FollowingCubit get(context) => BlocProvider.of(context);

  FollowingCategory selectedCategory = FollowingCategory.places;
  var pageController = PageController();

  void changeSelectedCategory({required FollowingCategory category}) {
    if (category == FollowingCategory.places) {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    } else {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    selectedCategory = category;
    emit(ChangeSelectedCategorySuccessState(category: category));
  }

  FollowingModel? followingModel;
  int page = 1;
  int totalPages = 0;

  Future<void> getFollowData({int? myPage}) async {
    if (myPage != null) {
      page = myPage;
    }
    emit(GetFollowDataLoadingState());
    await DioHelper.getData(
        url: EndPoints.follows,
        token: CachedVariables.token,
        query: {"page": page}).then((value) {
      if (value.statusCode == 200) {
        List<PlaceCoachModel> myCoaches = [];
        List<PlaceCoachModel> myAcademies = [];
        if (page > 1) {
          myCoaches.addAll(followingModel?.coaches ?? []);
          myAcademies.addAll(followingModel?.academies ?? []);
        }
        AppFunctions.logPrint(message: "My Academiessssss: $myAcademies");
        AppFunctions.logPrint(message: "My Coachessss: $myCoaches");
        followingModel = FollowingModel.fromJson(value.data,
            myCoaches: myCoaches != [] ? myCoaches : null,
            myAcademies: myAcademies != [] ? myAcademies : null);
        totalPages = followingModel?.totalPages ?? 0;
        page++;

        for (int i = 0; i < (followingModel?.coaches?.length ?? 0) - 1; i++) {
          for (int j = i + 1; j < (followingModel?.coaches?.length ?? 0); j++) {
            if (followingModel?.coaches?[i].id ==
                followingModel?.coaches?[j].id) {
              followingModel?.coaches?.removeAt(j);
            }
          }
        }
        for (int i = 0; i < (followingModel?.academies?.length ?? 0) - 1; i++) {
          for (int j = i + 1;
              j < (followingModel?.academies?.length ?? 0);
              j++) {
            if (followingModel?.academies?[i].id ==
                followingModel?.academies?[j].id) {
              followingModel?.academies?.removeAt(j);
            }
          }
        }

        emit(GetFollowDataSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);

        emit(GetFollowDataErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      AppFunctions.logPrint(message: "Errror : ${error.toString()}");
      emit(GetFollowDataErrorState(error: error.toString()));
    });
  }

  CoachesForUModel? coachesForUModel;

  Future<void> getCoachesForU() async {
    emit(GetCoachesForUDataLoadingState());
    await DioHelper.getData(
            url: EndPoints.getCoachesForU, token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        coachesForUModel = CoachesForUModel.fromJson(value.data);
        emit(GetCoachesForUDataSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        coachesForUModel = CoachesForUModel();
        emit(GetCoachesForUDataErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      coachesForUModel = CoachesForUModel();

      emit(GetCoachesForUDataErrorState(error: error.toString()));
    });
  }
}
