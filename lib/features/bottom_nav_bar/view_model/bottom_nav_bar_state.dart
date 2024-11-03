abstract class BottomNavBarState {}

class BottomNavBarInitial extends BottomNavBarState {}

class ChangeBottomNavBarState extends BottomNavBarState {}

class CheckForUpdateLoadingState extends BottomNavBarState {}

class CheckForUpdateSuccessState extends BottomNavBarState {}

class CheckForUpdateErrorState extends BottomNavBarState {
  final String error;

  CheckForUpdateErrorState({required this.error});
}
