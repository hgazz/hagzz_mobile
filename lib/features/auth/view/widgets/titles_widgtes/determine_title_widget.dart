import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/features/auth/view/widgets/titles_widgtes/profile_title_widget.dart';
import 'package:bookit/features/auth/view/widgets/titles_widgtes/sports_title_widget.dart';
import 'package:flutter/cupertino.dart';

class DetermineTitleWidget extends StatelessWidget {
  final bool isProfile;

  const DetermineTitleWidget({super.key, required this.isProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isProfile ? ProfileTitleWidget() : SizedBox.shrink(),
        !isProfile
            ? CachedVariables.token == null
                ? SportsTitleWidget()
                : SizedBox.shrink()
            : SizedBox.shrink(),
      ],
    );
  }
}
