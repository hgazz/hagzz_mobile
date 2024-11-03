part of 'faqs_cubit.dart';

@immutable
sealed class FaqsState {}

final class FaqsInitial extends FaqsState {}

final class GetFaqsLoadingState extends FaqsState {}

final class GetFaqsSuccessState extends FaqsState {
  final List<FaqModel> faqs;

  GetFaqsSuccessState({required this.faqs});
}

final class GetFaqsErrorState extends FaqsState {}
