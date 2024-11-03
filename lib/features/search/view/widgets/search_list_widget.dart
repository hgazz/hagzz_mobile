import 'package:bookit/core/util/constants/app_lottie/app_lottie.dart';
import 'package:bookit/core/util/widgets/training_card_loading_widget/training_card_loading_widget.dart';
import 'package:bookit/core/util/widgets/training_card_widget/training_card_widget.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({super.key});

  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = SearchCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getSearchData(isPagination: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        var currentList = cubit.currentSearchData;
        if (currentList.isEmpty && state is GetDefaultSearchDataSuccessState) {
          return Center(
            child: Lottie.asset(AppLottie.noData),
          );
        }
        // todo get the activities from the server
        var isLoading = state is GetDefaultSearchDataLoadingState;
        return ListView.separated(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: isLoading ? currentList.length + 1 : currentList.length,
          itemBuilder: (context, index) {
            // todo get the search from the server
            if (isLoading && currentList.length == 0) {
              return TrainingCardLoadingWidget();
            }
            if (index < currentList.length) {
              var current = currentList[index];
              return TrainingCardWidget(
                isVertical: true,
                isPast: false,
                trainingItem: current,
              );
            } else {
              return TrainingCardLoadingWidget();
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8.h);
          },
        );
      },
    );
  }
}
