import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/saved/view/widgets/list_of_saved_widget/list_of_saved_widget.dart';
import 'package:bookit/features/saved/view_model/saved_cubit.dart';
import 'package:flutter/material.dart';

import '../../profile/view/widgets/header_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    SavedCubit.get(context).page = 1;
    SavedCubit.get(context).getSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              backOnPressed: () {
                AppFunctions.popNavigate(context: context);
              },
              title: AppStrings.saved,
              trailingIcon: null,
            ),
            Expanded(child: const ListOfSavedWidget()),
          ],
        ),
      ),
    );
  }
}
