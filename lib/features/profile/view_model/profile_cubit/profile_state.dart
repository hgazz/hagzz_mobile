part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class SendLanguageLoadingState extends ProfileState {}

class SendLanguageSuccessState extends ProfileState {
  final bool isEnglish;

  SendLanguageSuccessState({required this.isEnglish});
}

class SendLanguageErrorState extends ProfileState {
  final String error;

  SendLanguageErrorState({required this.error});
}

class SetLanguageSuccessState extends ProfileState {}

class ChangeLanguageSuccessState extends ProfileState {
  final bool isEnglish;

  ChangeLanguageSuccessState({required this.isEnglish});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeLanguageSuccessState &&
          runtimeType == other.runtimeType &&
          isEnglish == other.isEnglish;

  @override
  int get hashCode => isEnglish.hashCode;
}
