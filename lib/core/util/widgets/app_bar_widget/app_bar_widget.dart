import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/container_icon_widget/container_icon_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/medium_text_widget/medium_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onLeadingTap;
  final String? title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final bool hasLeading;

  const AppBarWidget(
      {super.key,
      this.onLeadingTap,
      this.title,
      this.leadingWidget,
      this.titleWidget,
      this.actions,
      this.hasLeading = true});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          leading: hasLeading
              ? leadingWidget ??
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: ContainerIconWidget(
                        icon: Icons.arrow_back,
                        onTap: onLeadingTap ??
                            () => AppFunctions.popNavigate(context: context)),
                  )
              : null,
          leadingWidth: leadingWidget != null ? 60.w : null,
          title: titleWidget ??
              (title != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: MediumTextWidget(text: title ?? ''),
                    )
                  : null),
          actions: actions,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.h);
}
