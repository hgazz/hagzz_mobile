import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/cach/cached_variables.dart';
import '../../../../core/helper/dio/dio_helper.dart';
import '../../../../core/helper/dio/end_points.dart';
import '../../model/faq_model.dart';

part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  FaqsCubit() : super(FaqsInitial());

  static FaqsCubit get(context) => BlocProvider.of(context);

  // get faqs from api
  Future<void> getFaqs() async {
    emit(GetFaqsLoadingState());
    await DioHelper.getData(url: EndPoints.faqs, token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        List<FaqModel> faqs = value.data["data"] != null
            ? (value.data["data"] as List)
                .map((e) => FaqModel.fromMap(e))
                .toList()
            : [];

        emit(GetFaqsSuccessState(faqs: faqs));
      } else {
        emit(GetFaqsErrorState());
      }
    }).catchError((error) {
      emit(GetFaqsErrorState());
    });
  }
}
