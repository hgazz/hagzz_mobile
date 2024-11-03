import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/helper/cach/cached_variables.dart';
import '../../../core/helper/dio/dio_helper.dart';
import '../../../core/helper/dio/end_points.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/constants/app_icons/app_icons.dart';
import '../../../core/util/constants/app_strings/app_strings.dart';
import '../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../../../core/util/models/api_models/user_model/user_model.dart';
import '../../../core/util/widgets/address_widget/model/address_model.dart';
import '../../../core/util/widgets/address_widget/view_model/address_cubit.dart';
import '../../auth/model/api_models/sports_model.dart';
import '../../auth/model/local_model/chosen_sport_model.dart';
import '../../auth/model/local_model/field_change_state_model.dart';
import '../../auth/model/local_model/level_model.dart';
import '../model/local_model/edit_profile_local_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  File? image;
  ImagePicker? imagePicker = ImagePicker();

  void getImage({required File? image}) {
    if (image != null) {
      profileHasChanges = true;
      this.image = image;
      emit(GetUerImageFromGallery());
    } else {
      profileHasChanges = false;
    }
  }

  Future<void> getImageFromGallery() async {
    profileHasChanges = true;
    XFile? pickedImage =
        await imagePicker?.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(GetUerImageFromGallery());
    } else {
      profileHasChanges = false;
    }
  }

  String? userImage;

  UserProfileModel? userModel;

  Future<void> getUserData({context}) async {
    userModel = null;
    userSports = [];
    emit(GetUserProfileDataLoadingState());

    await DioHelper.getData(
            url: EndPoints.profile, token: CachedVariables.token)
        .then((value) {
      if (value.statusCode == 200) {
        userModel = UserProfileModel.fromJson(value.data);
        AppFunctions.logPrint(
            message: "sportsss: ${userModel?.data?.sports ?? []}");

        userModel?.data?.sports?.sort((s1, s2) => s1.level != null ? 0 : 1);
        userModel?.data?.sports?.forEach((element) {
          AppFunctions.logPrint(message: "Element : $element");
          userSports.add(ChosenSportsModel(
              sportId: element.id ?? 0, levelName: element.level ?? ''));
        });
        AppFunctions.logPrint(message: "User Sports: ${userSports}");
        emit(GetUserProfileDataSuccessState());
      } else {
        emit(GetUserProfileDataErrorState(error: value.data["message"]));
      }
    }).catchError((error) {
      emit(GetUserProfileDataErrorState(error: error.toString()));
    });
  }

  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateController = TextEditingController();

  assignDataToController({required Profile data, required context}) {
    nameController.text = data.name ?? '';
    phoneNumberController.text = data.phone ?? '';
    userImage = data.image;
    dateController.text = data.birthDate ?? '';
    isMale = data.gender?.toLowerCase() == "male" ? true : false;
    AddressCubit.get(context).selectedCountry = null;
    AddressCubit.get(context).selectedCity = null;
    AddressCubit.get(context).selectedArea = null;
    AddressCubit.get(context).changeSelectedCountry(
        userModel?.data?.profile?.country ?? AddressModel());
    AddressCubit.get(context)
        .changeSelectedCity(userModel?.data?.profile?.city ?? AddressModel());
    AddressCubit.get(context)
        .changeSelectedArea(userModel?.data?.profile?.area ?? AddressModel());

    // AddressCubit.get(context)
    //     .getCities(id: AddressCubit.get(context).selectedCountry?.id ?? 0);
    // AddressCubit.get(context)
    //     .getAreas(id: AddressCubit.get(context).selectedCity?.id ?? 0);
    // AppFunctions.logPrint(
    //     message: "Id :${AddressCubit.get(context).selectedCity?.id ?? 0}");

    // isAgree = true;
    emit(AssignDataToController());
  }

  Future<void> updateProfile({required EditProfileLocalModel data}) async {
    emit(UpdateUserProfileDataLoadingState());
    await DioHelper.postData(
            url: EndPoints.updateProfile,
            data: FormData.fromMap(await data.toMap()),
            token: CachedVariables.token)
        .then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(UpdateUserProfileDataSuccessState(message: model.message ?? ''));
      } else {
        emit(UpdateUserProfileDataErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(UpdateUserProfileDataErrorState(error: error.toString()));
    });
  }

  bool profileHasChanges = false;
  List<FieldChangeStateModel> changesState = [
    FieldChangeStateModel(fieldName: "name", isChanged: false),
    FieldChangeStateModel(fieldName: "phone", isChanged: false),
    FieldChangeStateModel(fieldName: "birthDate", isChanged: false),
    FieldChangeStateModel(fieldName: "gender", isChanged: false),
    FieldChangeStateModel(fieldName: "image", isChanged: false),
    FieldChangeStateModel(fieldName: "country", isChanged: false),
    FieldChangeStateModel(fieldName: "city", isChanged: false),
    FieldChangeStateModel(fieldName: "area", isChanged: false),
  ];

  void changeProfileChangesState({required bool hasChanges}) {
    profileHasChanges = hasChanges;

    emit(ChangeProfileSaveChangeBottomState(hasChanges: hasChanges));
  }

  void checkUserDataChanges({required context}) {
    profileHasChanges = false;
    changesState = [
      FieldChangeStateModel(fieldName: "name", isChanged: false),
      FieldChangeStateModel(fieldName: "phone", isChanged: false),
      FieldChangeStateModel(fieldName: "birthDate", isChanged: false),
      FieldChangeStateModel(fieldName: "gender", isChanged: false),
      FieldChangeStateModel(fieldName: "image", isChanged: false),
      FieldChangeStateModel(fieldName: "country", isChanged: false),
      FieldChangeStateModel(fieldName: "city", isChanged: false),
      FieldChangeStateModel(fieldName: "area", isChanged: false),
    ];
    if (nameController.text != userModel?.data?.profile?.name) {
      changesState[0].isChanged = true;
    } else {
      changesState[0].isChanged = false;
    }
    if (phoneNumberController.text != userModel?.data?.profile?.phone) {
      changesState[1].isChanged = true;
    } else {
      changesState[1].isChanged = false;
    }
    if (dateController.text != userModel?.data?.profile?.birthDate) {
      changesState[2].isChanged = true;
    } else {
      changesState[2].isChanged = false;
    }

    if (isMale !=
        (userModel?.data?.profile?.gender?.toLowerCase() == "male"
            ? true
            : false)) {
      changesState[3].isChanged = true;
    } else {
      changesState[3].isChanged = false;
    }

    if (image != userModel?.data?.profile?.image) {
      changesState[4].isChanged = true;
    } else {
      changesState[4].isChanged = false;
    }

    if (AddressCubit.get(context).selectedCountry?.id !=
        userModel?.data?.profile?.country?.id) {
      changesState[5].isChanged = true;
    } else {
      changesState[5].isChanged = false;
    }
    if (AddressCubit.get(context).selectedCity?.id !=
        userModel?.data?.profile?.city?.id) {
      changesState[6].isChanged = true;
    } else {
      changesState[6].isChanged = false;
    }
    if (AddressCubit.get(context).selectedArea?.id !=
        userModel?.data?.profile?.area?.id) {
      changesState[7].isChanged = true;
    } else {
      changesState[7].isChanged = false;
    }

    AppFunctions.logPrint(message: "${changesState.map((e) => e.isChanged)}");
    for (int i = 0; i < changesState.length; i++) {
      if (changesState[i].isChanged) {
        profileHasChanges = true;
      }
    }

    AppFunctions.logPrint(message: "HAS::::${profileHasChanges}");

    emit(CheckUserDataChangesSuccessState());
  }

  bool? isAgree;

  void changeAgreeTermsAndCondition() {
    isAgree ??= false;
    isAgree = !isAgree!;
    emit(ChangeAgreeTermsAndConditionSuccessState());
  }

  bool? isMale;

  void changeGender(bool? value) {
    genderValidation = null;
    isMale = value;
    emit(ChangeGenderSuccessState());
  }

  String? genderValidation;

  void setGenderValidationError({required context}) {
    genderValidation = AppFunctions.translateText(
        text: AppStrings.genderValidationError, context: context);
    emit(SetGenderValidationErrorSuccessState());
  }

  int? currentIndex;
  List<LevelModel> sportsLevel = [];
  List<ChosenSportsModel> chooseSports = [];
  List<ChosenSportsModel> userSports = [];
  int sportsChooseIndex = -1;

  void changeSports(int index) {
    sportsChooseIndex = index;
    emit(ChangeSportsSuccessState());
  }

  void changeLevel(int value) {
    currentIndex = value;
    sportsLevel[sportsChooseIndex] = levels[currentIndex ?? 0];
    sportsModel?.data?[sportsChooseIndex].level =
        levels[currentIndex ?? 0].name;
    chooseSports.add(ChosenSportsModel(
        sportId: sportsModel?.data?[sportsChooseIndex].id ?? 0,
        levelName: sportsLevel[sportsChooseIndex].name));

    sportsChooseIndex = -1;
    emit(ChangeLevelSuccessState());
  }

  void removeUserChosenLevel({required int sportId}) {
    for (int i = 0; i < userSports.length; i++) {
      if (userSports[i].sportId == sportId) {
        userSports[i].levelName = "";
      }
    }
    emit(RemoveChosenLevelSuccessState());
  }

  void changeUserLevel(int value) {
    currentIndex = value;

    userSports[userSportIndex] = ChosenSportsModel(
        sportId: userSports[userSportIndex].sportId,
        levelName: levels[currentIndex!].name);
    userSportIndex = -1;
    emit(ChangeLevelSuccessState());
  }

  void removeChosenLevel({required int index}) {
    sportsLevel.forEach((element) {
      for (int i = 0; i < chooseSports.length; i++) {
        if (element.name == chooseSports[i].levelName) {
          chooseSports.removeAt(i);
        }
      }
    });

    sportsLevel[index] = LevelModel(
      name: '',
      image: '',
    );
    AppFunctions.logPrint(message: "Sportssss: ${sportsLevel[index]}");
    emit(RemoveChosenLevelSuccessState());
  }

  int userSportIndex = -1;

  void changeUserSport(int index) {
    userSportIndex = index;
    emit(ChangeSportsSuccessState());
  }

  List<LevelModel> levels = [
    LevelModel(name: AppStrings.beginner, image: AppIcons.beginnerSVG),
    LevelModel(name: AppStrings.intermediate, image: AppIcons.intermediateSVG),
    LevelModel(name: AppStrings.advanced, image: AppIcons.advancedSVG),
  ];

  SportsModel? sportsModel;

  Future<void> getSports() async {
    sportsModel = null;
    emit(GetSportsLoadingState());
    await DioHelper.getData(url: EndPoints.sports).then((value) {
      if (value.statusCode == 200) {
        sportsModel = SportsModel.fromJson(value.data);
        sportsModel?.data?.forEach((element) {
          sportsLevel.add(LevelModel(name: "", image: ""));
        });
        emit(GetSportsSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetSportsErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetSportsErrorState(error: error.toString()));
    });
  }
}
