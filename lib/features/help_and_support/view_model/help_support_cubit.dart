import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/models/api_models/error_response_model/error_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/help_and_support_model/help_and_support_model.dart';

part 'help_support_state.dart';

class HelpSupportCubit extends Cubit<HelpSupportState> {
  HelpSupportCubit() : super(HelpSupportInitial());

  static HelpSupportCubit get(context) => BlocProvider.of(context);
  HelpAndSupportModel? helpAndSupportModel;

  Future<void> getHelpSupportData() async {
    emit(GetHelpSupportLoadingState());
    await DioHelper.getData(
        url: EndPoints.settings,
        query: {'lang': CachedVariables.lang ?? "en"}).then((value) {
      if (value.data["status"] == 200) {
        helpAndSupportModel = HelpAndSupportModel.fromJson(value.data);
        emit(GetHelpSupportSuccessState());
      } else {
        emit(GetHelpSupportErrorState(
            error: ErrorResponseModel.fromJson(value.data)));
      }
    }).catchError((error) {
      emit(GetHelpSupportErrorState(
          error: ErrorResponseModel(message: error.toString())));
    });
  }
}
