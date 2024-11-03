import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:bookit/features/home/model/home_response_model/home_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int sliderIndex = 0;

  void changeSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeSliderIndexSuccessState(index: index));
  }

  late HomeModel homeData;

  // function for getting home data from api
  Future<void> getHomeData({required context}) async {
    emit(HomeLoadingState());
    // api call
    await DioHelper.getData(
            url: EndPoints.home,
            token: CachedVariables.token ?? AuthCubit.get(context).token)
        .then((value) {
      if (value.statusCode == 200) {
        if (value.data != null) {
          homeData = HomeModel.fromJson(value.data);
          emit(
            HomeSuccessState(homeData: homeData),
          );
        }
      } else {
        emit(HomeErrorState(error: "Error"));
      }
    }).catchError((error, st) {
      AppFunctions.logPrint(message: 'error is ${error.toString()} st is $st');
      emit(HomeErrorState(error: error.toString()));
    });
  }

  int page = 1;
  int totalPages = 0;
  List<TrainingModel>? allTraining;

  Future<void> getAllTraining({required context}) async {
    if (allTraining == null) {
      allTraining = [];
    }
    emit(GetAllTrainingLoadingState());
    await DioHelper.getData(
        url: EndPoints.allTraining,
        token: CachedVariables.token ?? AuthCubit.get(context).token,
        query: {"page": page}).then((value) {
      if (value.statusCode == 200) {
        var data = List<TrainingModel>.from(
            (value.data["data"]["trainings"] as List)
                .map((e) => TrainingModel.fromJson(e)));
        allTraining?.addAll(data);
        totalPages = value.data["data"]["totalPages"];
        page++;
        AppFunctions.logPrint(message: "totalll: ${totalPages} \n page $page");
        emit(GetAllTrainingSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetAllTrainingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetAllTrainingErrorState(error: error.toString()));
    });
  }

  List<AcademiesAndRelatedSports>? allAcademies;

  Future<void> getAllAcademies({required context}) async {
    emit(GetAllAcademiesLoadingState());

    await DioHelper.getData(
        url: EndPoints.allAcademies,
        token: CachedVariables.token,
        query: {"page": page}).then((value) {
      if (value.statusCode == 200) {
        if (allAcademies == null) {
          allAcademies = [];
        }
        var data = List<AcademiesAndRelatedSports>.from(
            (value.data["data"]["academies"] as List)
                .map((e) => AcademiesAndRelatedSports.fromJson(e)));
        AppFunctions.logPrint(message: "Dataaaaaa: ${data}");
        allAcademies?.addAll(data);
        totalPages = value.data["data"]["totalPages"];
        page++;
        emit(GetAllAcademiesSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetAllAcademiesErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetAllAcademiesErrorState(error: error.toString()));
    });
  }
}
