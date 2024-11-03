import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/auth_cubit/auth_state.dart';

class UserPreferredWidget extends StatelessWidget {
  UserPreferredWidget({super.key});

  int increase = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cubit.userModel != null && CachedVariables.token != null
            //     ? MyActivityWidget()
            //     : SizedBox.shrink(),
            SizedBox(
              height: 10.h,
            ),
            // AnimatedConditionalBuilder(
            //     condition: cubit.sportsModel != null,
            //     builder: (context) => ListView.separated(
            //           shrinkWrap: true,
            //           physics: BouncingScrollPhysics(),
            //           itemBuilder: (context, index) => SportsItem(
            //             index: index,
            //             data: cubit.sportsModel?.data?[index] ?? SportData(),
            //           ),
            //           separatorBuilder: (context, index) => SizedBox(
            //             height: 8.h,
            //           ),
            //           itemCount: cubit.sportsModel?.data?.length ?? 0,
            //         ),
            //     fallback: (context) => const LoadingWidget())
          ],
        );
      },
    );
  }
}
