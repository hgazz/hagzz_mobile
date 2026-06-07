import 'package:bookit/core/helper/analytics/analytics_service.dart';
import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/features/search/model/all_area_response_model.dart';
import 'package:bookit/features/search/model/explore_response_model.dart';
import 'package:bookit/features/search/model/local_model/search_body_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/local_model/sports_choose_model/sports_choose_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  //sports filters

  List<SportsChooseModel> selectedSportsFilters = [];

  void changeSelectedSportsFilters(SportsChooseModel data) {
    if (selectedSportsFilters.contains(data)) {
      selectedSportsFilters.remove(data);
    } else {
      selectedSportsFilters.add(data);
    }
    emit(ChangeSelectedSportsFiltersSuccessState());
  }

  // quick filters
  List<String> quickFilters = [
    AppStrings.nearMeSearch,
    AppStrings.startSoon,
    AppStrings.almostFull,
  ];
  List<String> quickFiltersWithoutAuth = [
    AppStrings.startSoon,
    AppStrings.almostFull,
  ];

  List<int> selectedQuickFilters = [];

  void changeSelectedQuickFiltersByValue(String value) {
    final index = CachedVariables.token != null
        ? quickFilters.indexOf(value)
        : quickFiltersWithoutAuth.indexOf(value);
    if (selectedQuickFilters.contains(index)) {
      selectedQuickFilters.remove(index);
    } else {
      selectedQuickFilters.add(index);
    }
    emit(ChangeSelectedQuickFilterSuccessState());
  }

  void changeSelectedQuickFilters(int index) {
    if (selectedQuickFilters.contains(index)) {
      selectedQuickFilters.remove(index);
    } else {
      selectedQuickFilters.add(index);
    }
    emit(ChangeSelectedQuickFilterSuccessState());
  }

  // areas filters
  // getting all areas from the api

  List<AreaModel> areasFilters = [];

  Future<void> getAreas() async {
    areasFilters = [];
    if (areasFilters.isNotEmpty) {
      return;
    }

    emit(GetAreasLoadingState());
    final response = await DioHelper.getData(
        url: EndPoints.allArea, token: CachedVariables.token);
    if (response.statusCode == 200) {
      var responseModel = AllAreaResponseModel.fromJson(response.data);
      areasFilters = responseModel.data ?? [];
      emit(GetAreasSuccessState());
    } else {
      emit(GetAreasErrorState());
    }
  }

  List<int> selectedAreasFilters = [];
  List<int> selectedAreasFiltersIds = [];

  void changeSelectedAreasFilters(int index) {
    var id = areasFilters[index].id ?? 0;
    if (selectedAreasFilters.contains(index)) {
      selectedAreasFilters.remove(index);
      selectedAreasFiltersIds.remove(id);
    } else {
      selectedAreasFilters.add(index);
      selectedAreasFiltersIds.add(id);
    }
    emit(ChangeSelectedAreasFiltersSuccessState());
  }

  // Level filters
  List<String> levelFilters = [
    AppStrings.allLevels,
    AppStrings.beginner,
    AppStrings.intermediate,
    AppStrings.advanced,
  ];

  List<int> selectedLevelFilters = [0];

  void changeSelectedLevelFilters(int index) {
    if (index == 0) {
      selectedLevelFilters.clear();
      selectedLevelFilters.add(index);
      emit(ChangeSelectedAreasFiltersSuccessState());
      return;
    } else if (selectedLevelFilters.contains(0)) {
      selectedLevelFilters.remove(0);
    }
    if (selectedLevelFilters.contains(index)) {
      selectedLevelFilters.remove(index);
    } else {
      selectedLevelFilters.add(index);
    }
    emit(ChangeSelectedLevelFiltersSuccessState());
  }

  // Age group filters
  List<String> ageGroupFilters = [
    AppStrings.allAges,
    AppStrings.kids,
    AppStrings.junior,
    AppStrings.adult,
  ];

  List<int> selectedAgeGroupFilters = [0];

  void changeSelectedAgeGroupFilters(int index) {
    if (index == 0) {
      selectedAgeGroupFilters.clear();
      selectedAgeGroupFilters.add(index);
      emit(ChangeSelectedAreasFiltersSuccessState());
      return;
    } else if (selectedAgeGroupFilters.contains(0)) {
      selectedAgeGroupFilters.remove(0);
    }
    if (selectedAgeGroupFilters.contains(index)) {
      selectedAgeGroupFilters.remove(index);
    } else {
      selectedAgeGroupFilters.add(index);
    }
    emit(ChangeSelectedAgeGroupFiltersSuccessState());
  }

  // gender filters
  List<String> genderFilters = [
    AppStrings.all,
    AppStrings.men,
    AppStrings.women,
  ];

  int selectedGenderFilterIndex = 0;

  void changeSelectedGenderFilter(int index) {
    selectedGenderFilterIndex = index;
    emit(ChangeSelectedGenderFilterSuccessState());
  }

  void changeSelectedGenderFilterByValue(String value) {
    selectedGenderFilterIndex = genderFilters.indexOf(value);
    emit(ChangeSelectedGenderFilterSuccessState());
  }

  //days filters
  List<String> daysFilters = [
    AppStrings.selectDateRange,
  ];

  List<int> selectedDaysFilters = [];
  String startDate = '';
  String endDate = '';

  void changeSelectedDaysFilters(int index) {
    if (startDate.isEmpty && endDate.isEmpty) {
      selectedDaysFilters.remove(index);
    } else {
      selectedDaysFilters.add(index);
    }
    emit(ChangeSelectedDaysFiltersSuccessState());
  }

  //clear filters
  void clearFilters() {
    selectedQuickFilters = [];
    selectedAreasFilters = [0];
    selectedAreasFiltersIds = [];
    selectedSportsFilters = [];
    selectedLevelFilters = [0];
    selectedAgeGroupFilters = [0];
    selectedGenderFilterIndex = 0;
    selectedDaysFilters = [];
    emit(ChangeSelectedQuickFilterSuccessState());
  }

  // api integration
  List<TrainingModel> currentSearchData = [];

  TextEditingController searchController = TextEditingController();

  int page = 1;
  int totalPages = 0;

  // getting search data from the api by filters
  Future<void> getSearchData({bool isPagination = false}) async {
    emit(GetDefaultSearchDataLoadingState());
    List<int> sportsFilter = [];
    selectedSportsFilters.forEach((element) {
      sportsFilter.add(element.id);
    });
    var searchBodyModel = SearchBodyModel(
      searchText: searchController.text,
      selectedQuickFilters: selectedQuickFilters,
      selectedAreasFilters: selectedAreasFiltersIds,
      selectedLevelFilters: selectedLevelFilters,
      selectedAgeGroupFilters: selectedAgeGroupFilters,
      selectedGenderFilterIndex: selectedGenderFilterIndex,
      startDate: startDate,
      endDate: endDate,
      selectedSportsFilters: sportsFilter,
    );
    if (!isPagination) {
      currentSearchData.clear();
      page = 1;
      totalPages = 0;
      if (searchController.text.isNotEmpty) {
        AnalyticsService.logSearch(searchTerm: searchController.text);
      }
    }
    await DioHelper.postData(
      url: EndPoints.explore,
      token: CachedVariables.token,
      data: searchBodyModel.toJson(),
      query: {"page": page},
    ).then((value) {
      if (value.statusCode == 200) {
        var responseModel = ExploreResponseModel.fromJson(value.data);
        currentSearchData.addAll(responseModel.data?.trainings ?? []);

        for (int i = 0; i < currentSearchData.length - 1; i++) {
          for (int j = i + 1; j < currentSearchData.length; j++) {
            if (currentSearchData[i].id == currentSearchData[j].id) {
              currentSearchData.removeAt(j);
            }
          }
        }
        totalPages = responseModel.data?.totalPages ?? 0;
        page++;
        emit(GetDefaultSearchDataSuccessState());
      } else {
        emit(GetDefaultSearchDataErrorState(error: value.data["message"]));
      }
    }).catchError((error) {
      emit(GetDefaultSearchDataErrorState(error: error.toString()));
    });
  }
}
