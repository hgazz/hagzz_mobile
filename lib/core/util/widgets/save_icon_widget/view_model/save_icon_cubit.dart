import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../helper/cach/cached_variables.dart';
import '../../../../helper/dio/dio_helper.dart';
import '../../../../helper/dio/end_points.dart';
import '../../../models/api_models/api_response_models/default_response_model/default_response_model.dart';

part 'save_icon_state.dart';

class SaveIconCubit extends Cubit<SaveIconState> {
  SaveIconCubit() : super(SaveIconInitial());

  static SaveIconCubit get(context) => BlocProvider.of(context);

  Future<void> addToSaved({required int id}) async {
    emit(SavedTrainingLoadingState());
    await DioHelper.postData(
        url: EndPoints.addToSaved,
        token: CachedVariables.token,
        data: {"training_id": id}).then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);

      if (value.statusCode == 200) {
        emit(SavedTrainingSuccessState(message: model.message ?? ''));
      } else if (value.statusCode == 401) {
        emit(UnAuthorizedState());
      } else {
        emit(SavedTrainingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(SavedTrainingErrorState(error: error.toString()));
    });
  }

  Future<void> deleteFromSaved({required int id, required context}) async {
    emit(UnSavedTrainingLoadingState());

    await DioHelper.postData(
            url: EndPoints.deleteFromSaved(id: id),
            token: CachedVariables.token)
        .then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(UnSavedTrainingSuccessState(message: model.message ?? ''));
      } else if (value.statusCode == 401) {
        emit(UnAuthorizedState());
      } else {
        emit(UnSavedTrainingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(UnSavedTrainingErrorState(error: error.toString()));
    });
  }

  bool? isSave;

  void setSaveValue(bool isSave) {
    AppFunctions.logPrint(message: "Is Savedddd: $isSave");
    this.isSave = isSave;
    emit(SetSaveValueSuccessState());
  }

  void changeSaveValue(bool isSave) {
    this.isSave = isSave;
    emit(ChangeSaveValueSuccessState());
  }
}
