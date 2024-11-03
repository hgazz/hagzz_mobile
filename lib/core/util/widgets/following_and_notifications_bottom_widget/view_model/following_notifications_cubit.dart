import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/model/type_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'following_notifications_state.dart';

class FollowingNotificationsCubit extends Cubit<FollowingNotificationsState> {
  FollowingNotificationsCubit() : super(FollowingNotificationsInitial());

  static FollowingNotificationsCubit get(context) => BlocProvider.of(context);

  bool isFollowing = false;

  void setFollowing({required bool isFollow}) {
    AppFunctions.logPrint(message: "Follow::$isFollow");
    isFollowing = isFollow;
    emit(SetFollowingValueSuccessState());
  }

  void changeFollowingState() {
    isFollowing = !isFollowing;
    emit(ChangeFollowingStateSuccessState(isFollowing: isFollowing));
  }

  Future<void> changeFollowing({required TypeData data}) async {
    emit(ChangeFollowingLoadingState());
    await DioHelper.postData(
            url: isFollowing ? EndPoints.deleteFollow : EndPoints.addFollow,
            data: data.toMap(),
            token: CachedVariables.token)
        .then((value) {
      var model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(ChangeFollowingSuccessState(message: model.message ?? ''));
      } else {
        emit(ChangeFollowingErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(ChangeFollowingErrorState(error: error.toString()));
    });
  }
}
