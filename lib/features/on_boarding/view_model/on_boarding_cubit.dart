import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/constants/app_images/app_images.dart';
import '../model/local_model/on_boarding_object.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController controller = PageController();

  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeOnBoadingCurrentIndexSuccessState());
  }

  List<OnBoardingObject> onBoardingList = [
    OnBoardingObject(
      path: AppImages.onBoard1,
      title: AppStrings.onBoardTitle3,
      description: AppStrings.onBoardDescription3,
      buttonText: 'Get Started',
    ),
    OnBoardingObject(
      path: AppImages.onBoard2,
      title: AppStrings.onBoardTitle2,
      description: AppStrings.onBoardDescription2,
      buttonText: 'Keep Going',
    ),
    OnBoardingObject(
      path: AppImages.onBoard3,
      title: AppStrings.onBoardTitle1,
      description: AppStrings.onBoardDescription1,
      buttonText: 'Now let’s get you started!',
    ),
  ];
}
