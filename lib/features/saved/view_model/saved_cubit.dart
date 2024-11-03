import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInitial());

  static SavedCubit get(context) => BlocProvider.of(context);
  List<TrainingModel>? savedData;
  bool isEmpty = false;
  int page = 1;
  int totalPages = 0;

  Future<void> getSavedData({int? myPage}) async {
    if (savedData == null) {
      savedData = [];
    }
    if (myPage != null) {
      page = myPage;
    }
    emit(GetSavedDataLoadingState());
    await DioHelper.getData(
        url: EndPoints.saved,
        token: CachedVariables.token,
        query: {"page": myPage ?? page}).then((value) {
      if (value.statusCode == 200) {
        savedData?.addAll(List<TrainingModel>.from(
            (value.data["data"]["favorites"] as List)
                .map((e) => TrainingModel.fromJson(e["training"]))));

        for (int i = 0; i < savedData!.length - 1; i++) {
          for (int j = i + 1; j < savedData!.length; j++) {
            AppFunctions.logPrint(
                message: "id::: $i: ${savedData?[i].id} ${savedData?[i].name}");
            AppFunctions.logPrint(
                message: "id::: $j: ${savedData?[j].id} ${savedData?[j].name}");
            AppFunctions.logPrint(
                message: "${savedData?[i].id == savedData?[j].id}");
            if (savedData?[i].id == savedData?[j].id) {
              AppFunctions.logPrint(
                  message: "${savedData?[i].id == savedData?[j].id}");
              savedData?.removeAt(j);
            }
          }
        }
        totalPages = value.data["data"]["totalPages"];
        page++;
        emit(GetSavedDateSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetSavedDateErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      AppFunctions.logPrint(message: "Error: ${error.toString()}");
      emit(GetSavedDateErrorState(error: error.toString()));
    });
  }

  bool isSaved = false;

  void setValue({required bool isFav}) {
    isSaved = isFav;
    emit(SetSavedValueSuccessState());
  }

  void changeSavedValue() {
    isSaved = !isSaved;
    emit(ChangeSavedValueSuccessState());
  }
}
