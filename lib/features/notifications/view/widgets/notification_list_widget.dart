// import 'package:animated_conditional_builder/animated_conditional_builder.dart';
// import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../view_model/notification_cubit.dart';
// import 'notification_card_widget.dart';
//
// class NotificationListWidget extends StatefulWidget {
//   const NotificationListWidget({super.key});
//
//   @override
//   State<NotificationListWidget> createState() => _NotificationListWidgetState();
// }
//
// class _NotificationListWidgetState extends State<NotificationListWidget> {
//   final scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     var cubit = NotificationCubit.get(context);
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.offset) {
//         if (cubit.totalPages >= cubit.page) {
//           cubit.getNotifications();
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NotificationCubit, NotificationState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = NotificationCubit.get(context);
//         return Expanded(
//             child: AnimatedConditionalBuilder(
//           condition: cubit.notificationsModel != null,
//           builder: (context) => ListView.separated(
//             padding: EdgeInsets.symmetric(horizontal: 16.r),
//             itemBuilder: (context, index) {
//               if (index !=
//                   (cubit.notificationsModel?.data?.notifications?.length ??
//                       0 + 1)) {
//                 return NotificationCardWidget(
//                   data: cubit.notificationsModel?.data?.notifications?[index],
//                 );
//               } else {
//                 return cubit.totalPages == cubit.page
//                     ? LoadingWidget()
//                     : SizedBox.shrink();
//               }
//             },
//             separatorBuilder: (context, index) => SizedBox(height: 16.h),
//             itemCount:
//                 cubit.notificationsModel?.data?.notifications?.length ?? 0,
//           ),
//           fallback: (context) => ListView.separated(
//             padding: EdgeInsets.symmetric(horizontal: 16.0.r),
//             itemBuilder: (context, index) {
//               return NotificationCardWidget(
//                 data: null,
//               );
//             },
//             separatorBuilder: (context, index) => SizedBox(height: 16.h),
//             itemCount: 3,
//           ),
//         ));
//       },
//     );
//   }
// }
