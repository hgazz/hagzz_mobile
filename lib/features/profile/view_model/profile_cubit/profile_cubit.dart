import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  bool isEnglish = false;

  changeLanguage({required bool isEnglish}) {
    this.isEnglish = isEnglish;
    emit(ChangeLanguageSuccessState(isEnglish: isEnglish));
  }

  Future<void> setLanguage() async {
    AppFunctions.logPrint(message: "Language : ${CachedVariables.lang}");
    isEnglish = CachedVariables.lang == "en" ? true : false;

    emit(SetLanguageSuccessState());
  }

  Future<void> sendLanguage({required isEnglish}) async {
    await DioHelper.postData(
            url: EndPoints.language,
            data: {"lang": isEnglish ? "en" : "ar"},
            token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        this.isEnglish = isEnglish;
        emit(SendLanguageSuccessState(isEnglish: isEnglish));
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(SendLanguageErrorState(error: model.message ?? ""));
      }
    }).catchError((error) {
      emit(SendLanguageErrorState(error: error.toString()));
    });
  }
}
