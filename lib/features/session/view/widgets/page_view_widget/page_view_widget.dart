import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/enum_model/enum_details_models.dart';
import '../session_chat_widget.dart';
import '../session_classes_widget/session_classes_widget.dart';
import '../session_details_widget/session_details_widget.dart';

class SessionPageViewWidget extends StatelessWidget {
  const SessionPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        return Expanded(
            child: PageView(
          controller: cubit.pageController,
          onPageChanged: (index) {
            if (index == 0) {
              cubit.changeDetailsCategory(
                  category: SessionDetailsCategories.details);
            } else if (index == 1) {
              cubit.changeDetailsCategory(
                  category: SessionDetailsCategories.classes);
            } else {
              cubit.changeDetailsCategory(
                  category: SessionDetailsCategories.chat);
            }
          },
          children: [
            const SessionDetailsWidget(),
            const SessionClassesWidget(),
            const SessionChatWidget(),
          ],
        ));
      },
    );
  }
}
