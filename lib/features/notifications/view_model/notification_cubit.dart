import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/features/notifications/model/api_models/notifications_model/notifications_model.dart';
import 'package:bookit/features/notifications/model/enum_model/enum_details_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationTabs currentNotificationTab = NotificationTabs.present;

  void changeDetailsCategory({required NotificationTabs category}) {
    if (category == NotificationTabs.present) {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    } else if (category == NotificationTabs.past) {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    currentNotificationTab = category;
    emit(ChangeNotificationTabSuccessState(category: currentNotificationTab));
  }

  var pageController = PageController();

  NotificationsModel? notificationsModel;
  int page = 1;
  int newTotalPages = 0;
  int pastTotalPages = 0;

  Future<void> getNotifications({int? myPage}) async {
    if (myPage != null) {
      notificationsModel = null;
      page = myPage;
    }
    AppFunctions.logPrint(
        message: "Dataaaaaaa:${notificationsModel?.data?.pastNotifications}");
    AppFunctions.logPrint(message: "pageeeee: ${page}");
    emit(GetNotificationLoadingState());

    await DioHelper.getData(
        url: EndPoints.notifications,
        token: CachedVariables.token,
        query: {
          "page": page,
        }).then((value) {
      if (value.statusCode == 200) {
        NotificationsModel? newNotificationModel;
        if (page == 1) {
          notificationsModel = NotificationsModel.fromJson(value.data);
        } else {
          newNotificationModel = NotificationsModel.fromJson(value.data);
        }
        notificationsModel?.data?.newNotifications
            ?.addAll(newNotificationModel?.data?.newNotifications ?? []);
        notificationsModel?.data?.pastNotifications
            ?.addAll(newNotificationModel?.data?.pastNotifications ?? []);

        if (page == 1) {
          newTotalPages = notificationsModel?.data?.newTotalPages ?? 0;
          pastTotalPages = notificationsModel?.data?.pastTotalPages ?? 0;
        }
        page++;
        emit(GetNotificationSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetNotificationErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetNotificationErrorState(error: error.toString()));
    });
  }

  Future<void> makeNotificationRead({required String id}) async {
    emit(MakeNotificationReadLoadingState());
    await DioHelper.getData(
      url: EndPoints.makeNotificationRead(id: id),
      token: CachedVariables.token,
    ).then((value) {
      if (value.statusCode == 200) {
        emit(MakeNotificationReadSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(MakeNotificationReadErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(MakeNotificationReadErrorState(error: error.toString()));
    });
  }
}
