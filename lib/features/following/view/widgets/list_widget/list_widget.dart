import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/places_widget/places_widget.dart';
import 'package:bookit/features/following/model/category_enum.dart';
import 'package:bookit/features/following/view/widgets/coaches_empty_widget/coaches_empty_widget.dart';
import 'package:bookit/features/following/view/widgets/places_empty_widget/places_empty_widget.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = FollowingCubit.get(context);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getFollowData();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowingCubit, FollowingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FollowingCubit.get(context);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: AnimatedConditionalBuilder(
                condition: cubit.followingModel != null,
                builder: (context) => PageView(
                      controller: cubit.pageController,
                      onPageChanged: (index) {
                        if (index == 0) {
                          cubit.changeSelectedCategory(
                              category: FollowingCategory.places);
                        } else {
                          cubit.changeSelectedCategory(
                              category: FollowingCategory.coaches);
                        }
                      },
                      children: [
                        AnimatedConditionalBuilder(
                          condition:
                              cubit.followingModel?.academies?.isNotEmpty ??
                                  false,
                          builder: (context) => ListView.separated(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              if (index <
                                  (cubit.followingModel?.academies?.length ??
                                      0)) {
                                return PlacesWidget(
                                  isVertical: true,
                                  data: cubit.followingModel!.academies![index],
                                );
                              } else {
                                return cubit.totalPages == cubit.page
                                    ? LoadingWidget()
                                    : SizedBox.shrink();
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 6.h,
                            ),
                            itemCount:
                                cubit.followingModel!.academies!.length + 1,
                          ),
                          fallback: (context) => PlacesEmptyWidget(),
                        ),
                        AnimatedConditionalBuilder(
                          condition:
                              cubit.followingModel?.coaches?.isNotEmpty ??
                                  false,
                          builder: (context) => ListView.separated(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              if (index <
                                  (cubit.followingModel?.coaches?.length ??
                                      0)) {
                                return PlacesWidget(
                                  isVertical: true,
                                  data: cubit.followingModel!.coaches![index],
                                );
                              } else {
                                return cubit.totalPages == cubit.page
                                    ? LoadingWidget()
                                    : SizedBox.shrink();
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 6.h,
                            ),
                            itemCount:
                                cubit.followingModel!.coaches!.length + 1,
                          ),
                          fallback: (context) => CoachesEmptyWidget(),
                        ),
                      ],
                    ),
                fallback: (context) => const LoadingWidget()),
          ),
        );
      },
    );
  }
}
