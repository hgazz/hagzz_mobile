import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helper/dio/dio_helper.dart';
import '../../../../helper/dio/end_points.dart';
import '../../../models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../model/address_model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  static AddressCubit get(context) => BlocProvider.of(context);
  List<AddressModel> countries = [];

  void getCountries() async {
    emit(GetCountriesLoadingState());
    await DioHelper.getData(
        url: EndPoints.countries,
        query: {"lang": CachedVariables.lang ?? "en"}).then((value) {
      if (value.statusCode == 200) {
        countries = List<AddressModel>.from(
            (value.data["data"] as List).map((e) => AddressModel.fromJson(e)));
        emit(GetCountriesSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetCountriesErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetCountriesErrorState(error: error.toString()));
    });
  }

  AddressModel? selectedCountry;

  void changeSelectedCountry(AddressModel country) {
    selectedCountry = null;
    selectedCountry = country;
    getCities(id: country.id ?? 0);
    emit(ChangeSelectedCountrySuccessState());
  }

  List<AddressModel> cities = [];

  Future<void> getCities({required int id}) async {
    cities = [];
    selectedCity = null;
    emit(GetCitiesLoadingState());
    await DioHelper.postData(
            url: EndPoints.cities,
            data: {"country_id": id, "lang": CachedVariables.lang ?? "en"})
        .then((value) {
      if (value.statusCode == 200) {
        cities = List<AddressModel>.from(
            (value.data["data"] as List).map((e) => AddressModel.fromJson(e)));
        emit(GetCitiesSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetCitiesErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetCitiesErrorState(error: error.toString()));
    });
  }

  AddressModel? selectedCity;

  void changeSelectedCity(AddressModel city) {
    selectedCity = city;
    getAreas(id: city.id ?? 0);
    emit(ChangeSelectedCitySuccessState());
  }

  List<AddressModel> areas = [];

  Future<void> getAreas({required int id}) async {
    areas = [];
    selectedArea = null;
    emit(GetAreasLoadingState());
    await DioHelper.postData(
            url: EndPoints.areas,
            data: {"city_id": id, "lang": CachedVariables.lang ?? "en"})
        .then((value) {
      if (value.statusCode == 200) {
        areas = List<AddressModel>.from(
            (value.data["data"] as List).map((e) => AddressModel.fromJson(e)));
        emit(GetAreasSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetAreasErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(GetAreasErrorState(error: error.toString()));
    });
  }

  AddressModel? selectedArea;

  void changeSelectedArea(AddressModel area) {
    selectedArea = area;
    emit(ChangeSelectedAreaSuccessState());
  }

  var searchController = TextEditingController();
}
