import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geideapay/widgets/count_down_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../core/util/widgets/text_bottom_widget/text_bottom_widget.dart';
import '../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../view_model/otp_cubit/otp_cubit.dart';

class ResendCodeWidget extends StatefulWidget {
  final String phone;
  final bool isWhatsapp;

  const ResendCodeWidget(
      {super.key, required this.phone, required this.isWhatsapp});

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  bool isFinish = false;
  int timeLeft = 120;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      builder: (context, state) {
        var cubit = OtpCubit.get(context);
        return cubit.isTimerEnd
            ? Center(
                child: TextBottomWidget(
                    text: AppStrings.resendCode,
                    onTap: state is! ResendOtpLoadingState
                        ? () {
                            cubit.resendOtp(
                                phone: widget.phone,
                                isWhatsapp: widget.isWhatsapp);
                          }
                        : null),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                      text: AppFunctions.translateText(
                          context: context, text: AppStrings.resendCodeIn),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                  SizedBox(
                    width: 4.w,
                  ),
                  CircularCountDownTimer(
                      width: 90,
                      height: 90,
                      duration: 120,
                      textFormat: CountdownTextFormat.MM_SS,
                      controller: CountDownController(),
                      textStyle: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                      fillColor: AppColors.transparent,
                      onComplete: () {
                        cubit.changeTimerState(isFinish: true);
                      },
                      isReverse: true,
                      strokeWidth: 0,
                      ringColor: AppColors.transparent)
                  // TimerButton.builder(
                  //   builder: (context, timeLeft) {
                  //     String minute;
                  //     String second;
                  //     if (timeLeft != 0) {
                  //       if (timeLeft > 60) {
                  //         minute = "${timeLeft ~/ 60}";
                  //         second = "${timeLeft % 60}";
                  //         if (second.length == 1) {
                  //           second = "0$second";
                  //         }
                  //       } else {
                  //         minute = "00";
                  //         second = "${timeLeft}";
                  //         if (second.length == 1) {
                  //           second = "0$second";
                  //         }
                  //       }
                  //     } else {
                  //       cubit.changeTimerState(isFinish: true);
                  //       minute = "00";
                  //       second = "00";
                  //     }
                  //     if ("$minute:$second" == "00:-1") {
                  //       cubit.changeTimerState(isFinish: true);
                  //       minute = "00";
                  //       second = "00";
                  //     }
                  //     return Text(
                  //       "$minute:$second",
                  //       style: GoogleFonts.inter(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 15.sp,
                  //       ),
                  //     );
                  //   },
                  //   onPressed: () {},
                  //   timeOutInSeconds: timeLeft, // Use the timeLeft variable
                  // ),
                ],
              );
      },
      listener: (context, state) {
        var cubit = OtpCubit.get(context);

        if (state is ResendOtpSuccessState) {
          cubit.changeTimerState(isFinish: false);
          AppAlert.success(message: state.message, context: context);
        }
        if (state is ResendOtpErrorState) {
          AppAlert.error(message: state.error, context: context);
        }
      },
    );
  }
}
