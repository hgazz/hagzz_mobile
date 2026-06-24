import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../core/util/widgets/app_bar_widget/app_bar_widget.dart';
import '../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../profile/view/widgets/bottom_sheet_widget.dart';
import '../../model/web_view_data_model/web_view_data_model.dart';
import '../widgets/failed_bottom_sheet_widget.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final WebViewDataModel data;

  const PaymentWebViewScreen({super.key, required this.data});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: _handlePageStarted,
          onWebResourceError: (error) {
            AppFunctions.logPrint(message: "Error: ${error.toString()}");
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.data.paymentData.resultObj?.payUrl ?? 'about:blank'),
      );
  }

  Future<void> _handlePageStarted(String url) async {
    AppFunctions.logPrint(message: "Started: $url");

    if (!url.contains("status=Paid")) {
      return;
    }

    final cubit = SessionCubit.get(context);
    final joined = await cubit.joinTrainingSession(
      widget.data.paymentData.resultObj?.id ?? "0",
      widget.data.paymentData.resultObj?.id ?? "0",
      widget.data.training,
    );

    if (!mounted) {
      return;
    }

    if (joined) {
      AppFunctions.showSuccessDialogBox(
        context: context,
        child: FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 0),
          ),
          onPressed: () {
            widget.data.cubit.getTrainingDetailsById(
              id: widget.data.training.id ?? 0,
            );
            AppFunctions.popNavigate(context: context);
            AppFunctions.popNavigate(context: context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0.h),
            child: CustomTextWidget(
              text: AppStrings.backToTraining,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
      );
      return;
    }

    AppFunctions.popNavigate(context: context);
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetWidget(
        height: MediaQuery.of(context).size.height * 0.45,
        child: FailedBottomSheetWidget(
          error: cubit.errorMessage ??
              AppFunctions.translateText(
                text: AppStrings.pleaseTryAgain,
                context: context,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppStrings.payment,
      ),
      body: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) async {
          if (state is JoinTrainingSessionSuccessState) {}
        },
        builder: (context, state) {
          AppFunctions.logPrint(
              message: "Dataaa: ${widget.data.paymentData.resultObj?.payUrl}");
          return WebViewWidget(controller: controller);
        },
      ),
    );
  }
}
