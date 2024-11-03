import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/features/academy_profile/view/academy_profile_screen.dart';
import 'package:bookit/features/auth/model/local_model/register_model.dart';
import 'package:bookit/features/auth/view/choose_sports_screen/choose_sports_screen.dart';
import 'package:bookit/features/auth/view/complete_profile_screen.dart';
import 'package:bookit/features/auth/view/create_an_account_screen/create_an_account_screen.dart';
import 'package:bookit/features/auth/view/enter_phone_screen/enter_phone.dart';
import 'package:bookit/features/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:bookit/features/coach_profile/view/coach_profile_screen.dart';
import 'package:bookit/features/edit_profile/view/edit_profile_screen.dart';
import 'package:bookit/features/following/view/all_coaches_screen.dart';
import 'package:bookit/features/help_and_support/view/help_and_support_screen.dart';
import 'package:bookit/features/home/view/all_academies_screen.dart';
import 'package:bookit/features/home/view/all_training_screen.dart';
import 'package:bookit/features/invite_friends/view/invite_friends_screen.dart';
import 'package:bookit/features/lost_connection/view/lost_connection_screen.dart';
import 'package:bookit/features/notifications/view/notification_screen.dart';
import 'package:bookit/features/prinacy_policy/view/privacy_policy_screen.dart';
import 'package:bookit/features/profile/view/faqs_screen.dart';
import 'package:bookit/features/profile/view/my_sessions_screen.dart';
import 'package:bookit/features/profile/view/settings_screen.dart';
import 'package:bookit/features/profile/view/support_screen.dart';
import 'package:bookit/features/profile/view_model/my_sessions_cubit/my_sessions_cubit.dart';
import 'package:bookit/features/session/model/local_model/checkout_model.dart';
import 'package:bookit/features/session/model/local_model/session_model.dart';
import 'package:bookit/features/session/model/web_view_data_model/web_view_data_model.dart';
import 'package:bookit/features/session/view/payment_web_view_screen/payment_web_view_screen.dart';
import 'package:bookit/features/session/view/session_screen.dart';
import 'package:bookit/features/terms_and_conditions/view/terms_and_conditions_screen.dart';
import 'package:bookit/features/update_sports/view/update_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/model/local_model/verifcation_code_local_model/verifcation_code_local_model.dart';
import '../../../features/auth/view/verification_code_screen/verification_code_screen.dart';
import '../../../features/following/view/following_screen.dart';
import '../../../features/on_boarding/view/on_boarding_screen.dart';
import '../../../features/saved/view/saved_screen.dart';
import '../../../features/session/view/session_checkout_screen/session_checkout_screen.dart';
import '../../../features/splash/view/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.init:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConstants.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case RouteConstants.enterPhone:
        return MaterialPageRoute(builder: (_) => const EnterPhoneScreen());
      case RouteConstants.verificationCode:
        VerificationCodeLocalModel model =
            settings.arguments as VerificationCodeLocalModel;
        return MaterialPageRoute(
            builder: (_) => VerificationCodeScreen(
                  model: model,
                ));
      case RouteConstants.completeProfile:
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case RouteConstants.chooseSports:
        return MaterialPageRoute(builder: (_) => const ChooseSportsScreen());
      case RouteConstants.createAnAccount:
        final RegisterModel? model = settings.arguments as RegisterModel?;
        return MaterialPageRoute(
            builder: (_) => CreateAnAccountScreen(
                  model: model,
                ));
      case RouteConstants.bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case RouteConstants.lostInternetConnection:
        return MaterialPageRoute(builder: (_) => LostConnectionScreen());
      case RouteConstants.saved:
        return MaterialPageRoute(builder: (_) => const SavedScreen());
      case RouteConstants.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case RouteConstants.following:
        return MaterialPageRoute(builder: (_) => const FollowingScreen());
      case RouteConstants.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case RouteConstants.allCoaches:
        return MaterialPageRoute(builder: (_) => const AllCoachesScreen());
      case RouteConstants.payment:
        final WebViewDataModel data = settings.arguments as WebViewDataModel;
        return MaterialPageRoute(
            builder: (_) => PaymentWebViewScreen(data: data));
      case RouteConstants.helpAndSupport:
        return MaterialPageRoute(builder: (_) => const HelpAndSupportScreen());
      case RouteConstants.termsAndConditions:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsScreen());
      case RouteConstants.academyProfile:
        DetailsDataModel model = settings.arguments as DetailsDataModel;
        return MaterialPageRoute(
            builder: (_) => AcademyProfileScreen(academyData: model));
      case RouteConstants.coachProfile:
        DetailsDataModel model = settings.arguments as DetailsDataModel;
        return MaterialPageRoute(
            builder: (_) => CoachProfileScreen(
                  data: model,
                ));
      case RouteConstants.inviteFriend:
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
      case RouteConstants.sessions:
        SessionLocalModel model = settings.arguments as SessionLocalModel;
        return MaterialPageRoute(
            builder: (_) => SessionScreen(
                  localModel: model,
                ));
      case RouteConstants.mySessions:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: MySessionsCubit()..getMySessions(),
                child: const MySessionsScreen(isBack: true)));
      case RouteConstants.notification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case RouteConstants.allTraining:
        return MaterialPageRoute(builder: (_) => const AllTrainingScreen());
      case RouteConstants.allAcademies:
        return MaterialPageRoute(builder: (_) => const AllAcademiesScreen());
      case RouteConstants.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteConstants.support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      case RouteConstants.faqs:
        return MaterialPageRoute(builder: (_) => const FAQsScreen());
      case RouteConstants.sessionCheckOut:
        final CheckoutModel checkoutModel = settings.arguments as CheckoutModel;
        return MaterialPageRoute(
            builder: (_) => SessionCheckOutScreen(
                  checkoutModel: checkoutModel,
                ));
      case RouteConstants.updateSports:
        return MaterialPageRoute(builder: (_) => const UpdateSportsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
