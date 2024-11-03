import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/widgets/dot_indicator_widget/dot_indicator_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int sliderIndex = 0;

  void changeSliderIndex(int index) {
    setState(() {
      sliderIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Column(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: 2.2,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  autoPlay: state is! HomeLoadingState ? true : false,
                  onPageChanged: (index, reason) => changeSliderIndex(index),
                ),
                items: state is! HomeLoadingState
                    ? cubit.homeData.data?.banners
                        ?.map((item) => InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  // color: AppColors.borderColor,
                                    borderRadius: BorderRadius.circular(28.r),
                                    image: DecorationImage(
                                        image: Image.network(item.logo ?? '')
                                            .image,
                                        fit: BoxFit.fill)),
                              ),
                            ))
                        .toList()
                    : [""]
                        .map((e) => ShimmerWidget(
                            width: double.infinity, height: 100.h))
                        .toList()),
            SizedBox(
              height: 8.h,
            ),
            state is! HomeLoadingState
                ? DotIndicatorWidget(
                    currentIndex: sliderIndex,
                    count: state is! HomeLoadingState
                        ? cubit.homeData.data?.banners?.length ?? 0
                        : 0,
                  )
                : ShimmerWidget(
                    width: 8.w,
                    height: 20.h,
                    containerShape: BoxShape.circle,
                  )
          ],
        );
      },
    );
  }
}
