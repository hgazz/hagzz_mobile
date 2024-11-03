import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/features/auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../../../auth/model/api_models/sports_model.dart';
import '../../../../auth/view/choose_sports_screen/widgets/sports_item_widget/sports_item.dart';

class OtherSportsWidget extends StatelessWidget {
  const OtherSportsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseSportsCubit, ChooseSportsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ChooseSportsCubit.get(context);
        return AnimatedConditionalBuilder(
            condition: cubit.sportsModel != null,
            builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => SportsItem(
                    index: index,
                    data: cubit.sportsModel?.data?[index] ?? SportData(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                  itemCount: cubit.sportsModel?.data?.length ?? 0,
                ),
            fallback: (context) => const LoadingWidget());
      },
    );
  }
}
