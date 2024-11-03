import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/help_and_support/view_model/help_support_cubit.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HelpSupportCubit()..getHelpSupportData(),
        child: BlocConsumer<HelpSupportCubit, HelpSupportState>(
          listener: (context, state) {
            if (state is GetHelpSupportErrorState) {
              AppFunctions.showError(error: state.error, context: context);
            }
          },
          builder: (context, state) {
            var cubit = HelpSupportCubit.get(context);
            return state is GetHelpSupportLoadingState
                ? LoadingWidget()
                : SafeArea(
                    child: Column(
                      children: [
                        HeaderWidget(
                            backOnPressed: () {
                              AppFunctions.popNavigate(context: context);
                            },
                            title: AppStrings.help),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: AppStrings.contactUs,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                              SizedBox(
                                height: 24.h,
                              ),
                              cubit.helpAndSupportModel?.data?.email != null
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: AppStrings.contactInfo,
                                              context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: ": ", context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: cubit.helpAndSupportModel?.data
                                                  ?.email?.value ??
                                              '',
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blue,
                                          )),
                                    ]))
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 24.h,
                              ),
                              cubit.helpAndSupportModel?.data?.whatsapp != null
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: AppStrings.phoneNumber,
                                              context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: ": ", context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: cubit.helpAndSupportModel?.data
                                                  ?.whatsapp?.value ??
                                              '',
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blue,
                                          )),
                                    ]))
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 24.h,
                              ),
                              cubit.helpAndSupportModel?.data?.egyptAddress !=
                                      null
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: AppStrings.egyptAddress,
                                              context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: ": ", context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: cubit.helpAndSupportModel?.data
                                                  ?.egyptAddress?.value ??
                                              '',
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blue,
                                          )),
                                    ]))
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 24.h,
                              ),
                              cubit.helpAndSupportModel?.data?.qatarAddress !=
                                      null
                                  ? RichText(
                                      text: TextSpan(children: [
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: AppStrings.qatarAddress,
                                              context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: AppFunctions.translateText(
                                              text: ": ", context: context),
                                          style: GoogleFonts.inter(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          )),
                                      TextSpan(
                                          text: cubit.helpAndSupportModel?.data
                                                  ?.qatarAddress?.value ??
                                              '',
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blue,
                                          )),
                                    ]))
                                  : SizedBox.shrink(),
                              // CustomTextWidget(
                              //     text: AppStrings.writeYourInquiry,
                              //     fontSize: 14.sp,
                              //     fontWeight: FontWeight.w400,
                              //     color: AppColors.textGreyColor),
                              // SizedBox(
                              //   height: 8.h,
                              // ),
                              // FormFieldWidget(
                              //     controller: TextEditingController(),
                              //     hintText: AppStrings.helpExample,
                              //     keyInputType: TextInputType.text,
                              //     maxLength: 500,
                              //     maxLines: 9,
                              //     validator: (value) {
                              //       return AppValidator.generalValidator(
                              //           value: value!, context: context);
                              //     }),
                              // SizedBox(
                              //   height: 24.h,
                              // ),
                              // BottomWidget(
                              //   text: AppStrings.submit,
                              //   onTap: () {},
                              //   isLoading: false,
                              // )
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     InkWell(
                              //         onTap: () async{
                              //           String androidUrl ="https://wa.me/01026558999/?text=${Uri.parse("Hello")}";
                              //           String iosUrl = "https://wa.me/+201026558999?text=${Uri.parse("")}";
                              //           var whatsappAndroid =Uri.parse("https://wa.me/+201026558999?text=Hello");
                              //           if (await canLaunchUrl(Uri.parse(androidUrl))) {
                              //           await launchUrl(Uri.parse(androidUrl));
                              //           } else {
                              //             ScaffoldMessenger.of(context).showSnackBar(
                              //               const SnackBar(
                              //                 content: Text(
                              //                     "Error Please try again"),
                              //               ),
                              //             );
                              //           }
                              //         },
                              //         child: Image.asset(AppIcons.whatsapp,
                              //         fit: BoxFit.scaleDown,
                              //         width: 40.w,
                              //         height: 40.h,)),
                              //     SizedBox(width: 16.w,),
                              //     InkWell(
                              //         onTap: () {},
                              //         child: Image.asset(AppIcons.gmail,
                              //           fit: BoxFit.scaleDown,
                              //           width: 40.w,
                              //           height: 40.h,)),
                              //   ],
                              // )
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
