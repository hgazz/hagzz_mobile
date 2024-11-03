part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class GetCountriesLoadingState extends AddressState {}

class GetCountriesSuccessState extends AddressState {}

class GetCountriesErrorState extends AddressState {
  final String error;

  GetCountriesErrorState({required this.error});
}

class GetCitiesLoadingState extends AddressState {}

class GetCitiesSuccessState extends AddressState {}

class GetCitiesErrorState extends AddressState {
  final String error;

  GetCitiesErrorState({required this.error});
}

class GetAreasLoadingState extends AddressState {}

class GetAreasSuccessState extends AddressState {}

class GetAreasErrorState extends AddressState {
  final String error;

  GetAreasErrorState({required this.error});
}

class ChangeSelectedCountrySuccessState extends AddressState {}

class ChangeSelectedCitySuccessState extends AddressState {}

class ChangeSelectedAreaSuccessState extends AddressState {}
